rm(list = ls())

library(dplyr)
library(httr)
library(readxl)
library(xml2)

institution <- "Congressional Budget Office"

root_path <- paste0("scripts/forecast-data/", institution, "/")

# One row per vintage: publication date, the Excel file on cbo.gov, the report
# it belongs to and an archived copy of the file. cbo.gov answers scripted
# requests with HTTP 403 (bot protection), so each file is tried at cbo.gov
# first and then at its Internet Archive copy (archive_url).
vintages <- read.csv(paste0(root_path, "vintages.csv"),
                     stringsAsFactors = FALSE, colClasses = "character")

# Labels of the three rows in the calendar-year sheet, after lower-casing and
# removing footnote markers. Real GDP and the CPI-U take the
# "Percentage change" row below the label; the unemployment rate is the level.
row_specs <- list(
  NGDP_RPCH = list(label = "^real gdp$", pct = TRUE),
  PCPIPCH   = list(label = "^consumer price index, all urban consumers( [(]cpi-u[)])?$", pct = TRUE),
  LUR       = list(label = "^unemployment rate, civilian, 16 years or older$", pct = FALSE)
)

# Rounding to one decimal as CBO prints its tables (half away from zero)
round_half_up <- function(x, digits = 1) {
  sign(x) * floor(abs(x) * 10^digits + 0.5 + 1e-9) / 10^digits
}

is_excel_file <- function(path) {
  if (!file.exists(path) || file.size(path) < 8) return(FALSE)
  b <- readBin(path, "raw", 8)
  identical(b[1:4], as.raw(c(0x50, 0x4b, 0x03, 0x04))) ||                    # xlsx (zip)
    identical(b, as.raw(c(0xd0, 0xcf, 0x11, 0xe0, 0xa1, 0xb1, 0x1a, 0xe1)))  # xls (OLE2)
}

download_vintage <- function(file_url, archive_url) {
  ext <- tolower(tools::file_ext(file_url))
  path <- tempfile(fileext = paste0(".", ext))
  for (u in c(file_url, archive_url)) {
    if (is.na(u) || u == "") next
    for (attempt in 1:3) {
      r <- tryCatch(GET(u, user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64)"),
                        write_disk(path, overwrite = TRUE), timeout(180)),
                    error = function(e) NULL)
      if (!is.null(r) && status_code(r) == 200 && is_excel_file(path)) return(path)
      # cbo.gov's bot protection does not go away on retry
      if (!is.null(r) && status_code(r) == 403) break
      Sys.sleep(5)
    }
  }
  stop("Could not download ", file_url, " or its archived copy ", archive_url)
}

# Cells of a sheet in an .xlsx file that have a solid fill (CBO shades the
# forecast values: "Actual values reflect data released as of ... Forecast
# values are shaded.")
xlsx_shaded_cells <- function(path, sheet) {
  dir <- tempfile("xlsx_")
  utils::unzip(path, exdir = dir)
  on.exit(unlink(dir, recursive = TRUE))
  wb <- read_xml(file.path(dir, "xl", "workbook.xml"))
  xml_ns_strip(wb)
  sh <- xml_find_all(wb, "//sheets/sheet")
  rid <- xml_attr(sh, "id")[xml_attr(sh, "name") == sheet]
  if (length(rid) != 1) stop("Sheet '", sheet, "' not found in workbook.xml")
  rels <- read_xml(file.path(dir, "xl", "_rels", "workbook.xml.rels"))
  xml_ns_strip(rels)
  rel <- xml_find_all(rels, "//Relationship")
  target <- sub("^/?xl/", "", xml_attr(rel, "Target")[xml_attr(rel, "Id") == rid])
  st <- read_xml(file.path(dir, "xl", "styles.xml"))
  xml_ns_strip(st)
  solid <- vapply(xml_find_all(st, "/styleSheet/fills/fill"), function(f) {
    p <- xml_find_first(f, "./patternFill")
    if (inherits(p, "xml_missing")) return(FALSE)
    fg <- xml_find_first(p, "./fgColor")
    white <- !inherits(fg, "xml_missing") && identical(toupper(xml_attr(fg, "rgb")), "FFFFFFFF")
    identical(xml_attr(p, "patternType"), "solid") && !white
  }, logical(1))
  xfs <- xml_find_all(st, "/styleSheet/cellXfs/xf")
  xf_solid <- solid[as.integer(xml_attr(xfs, "fillId")) + 1]
  ws <- read_xml(file.path(dir, "xl", target))
  xml_ns_strip(ws)
  cells <- xml_find_all(ws, "//sheetData/row/c")
  ref <- xml_attr(cells, "r")
  s <- as.integer(xml_attr(cells, "s"))
  col <- vapply(strsplit(gsub("[0-9]", "", ref), ""), function(ch) {
    sum(match(ch, LETTERS) * 26^(rev(seq_along(ch)) - 1))
  }, numeric(1))
  data.frame(row = as.integer(gsub("[A-Z]", "", ref)), col = col,
             shaded = !is.na(s) & xf_solid[pmax(s, 0) + 1] %in% TRUE)
}

# The same for the one .xls (BIFF8) file, February 2013, which readxl reads
# without formats: a minimal reader of the OLE2 container and of the BIFF
# records that carry the cell formats (XF: fill pattern; cell records: row,
# column, XF index)
u16 <- function(b, o) as.integer(b[o + 1]) + 256L * as.integer(b[o + 2])
u32 <- function(b, o) u16(b, o) + 65536 * u16(b, o + 2)
s32 <- function(b, o) { v <- u32(b, o); if (v >= 2^31) v - 2^32 else v }

ole_stream <- function(path, name) {
  b <- readBin(path, "raw", file.size(path))
  ssz <- 2^u16(b, 30)
  nfat <- u32(b, 44)
  if (nfat > 109) stop("OLE2 files with more than 109 FAT sectors are not supported")
  difat <- vapply(seq_len(nfat) - 1, function(i) s32(b, 76 + 4 * i), numeric(1))
  sec <- function(s) b[512 + s * ssz + seq_len(ssz)]
  fat <- unlist(lapply(difat, function(s) {
    x <- sec(s)
    vapply(0:(ssz / 4 - 1), function(i) s32(x, 4 * i), numeric(1))
  }))
  chain <- function(s) {
    out <- numeric()
    while (s >= 0) { out <- c(out, s); s <- fat[s + 1] }
    out
  }
  dir <- do.call(c, lapply(chain(s32(b, 48)), sec))
  for (k in 0:(length(dir) / 128 - 1)) {
    e <- dir[k * 128 + 1:128]
    nl <- u16(e, 64)
    if (nl < 2) next
    if (rawToChar(e[seq(1, nl - 2, by = 2)]) == name) {
      if (u32(e, 120) < 4096) stop("stream ", name, " is in the mini stream (not supported)")
      return(do.call(c, lapply(chain(s32(e, 116)), sec))[seq_len(u32(e, 120))])
    }
  }
  stop("stream ", name, " not found")
}

xls_shaded_cells <- function(path, sheet) {
  w <- ole_stream(path, "Workbook")
  pos <- 0
  xf_fill <- integer()
  sheets <- list()
  while (pos + 4 <= length(w)) {
    id <- u16(w, pos)
    len <- u16(w, pos + 2)
    if (id == 0x00E0) xf_fill <- c(xf_fill, floor(u32(w, pos + 4 + 14) / 2^26) %% 64) # XF: fill pattern
    if (id == 0x0085) {                                                                 # BOUNDSHEET
      cch <- as.integer(w[pos + 4 + 7])
      unicode <- as.integer(w[pos + 4 + 8]) %% 2 == 1
      idx <- if (unicode) seq(1, 2 * cch, 2) else seq_len(cch)
      sheets[[rawToChar(w[pos + 4 + 8 + idx])]] <- u32(w, pos + 4)
    }
    pos <- pos + 4 + len
  }
  if (is.null(sheets[[sheet]])) stop("sheet '", sheet, "' not found in the BIFF stream")
  pos <- sheets[[sheet]]
  out <- list()
  repeat {
    id <- u16(w, pos)
    len <- u16(w, pos + 2)
    d <- pos + 4
    if (id %in% c(0x0203, 0x027E, 0x00FD, 0x0201, 0x0006)) {    # NUMBER, RK, LABELSST, BLANK, FORMULA
      out[[length(out) + 1]] <- c(u16(w, d), u16(w, d + 2), u16(w, d + 4))
    } else if (id %in% c(0x00BD, 0x00BE)) {                      # MULRK, MULBLANK
      c1 <- u16(w, d + 2)
      c2 <- u16(w, d + len - 2)
      step <- if (id == 0x00BD) 6 else 2
      for (j in 0:(c2 - c1)) out[[length(out) + 1]] <- c(u16(w, d), c1 + j, u16(w, d + 4 + j * step))
    }
    pos <- pos + 4 + len
    if (id == 0x000A || pos + 4 > length(w)) break                # EOF of the sheet
  }
  m <- do.call(rbind, out)
  data.frame(row = m[, 1] + 1, col = m[, 2] + 1, shaded = xf_fill[m[, 3] + 1] %in% 1)
}

# Parse one vintage: returns year, variable, value (full precision) and
# whether the year is a projection
parse_vintage <- function(path, pubdate) {
  sheets <- excel_sheets(path)
  sheet <- grep("calendar year", sheets, ignore.case = TRUE, value = TRUE)
  if (length(sheet) != 1) {
    stop("no unique calendar-year sheet (sheets: ", paste(sheets, collapse = ", "), ")")
  }
  m <- read_excel(path, sheet = sheet, col_names = FALSE, col_types = "text",
                  range = cellranger::cell_limits(c(1, 1), c(NA, NA)),
                  .name_repair = "minimal")
  m <- as.matrix(as.data.frame(m, stringsAsFactors = FALSE))
  m[] <- trimws(gsub("[[:space:]]+", " ", m))

  # Header: the first row with at least five years
  is_year <- matrix(grepl("^(19|20)[0-9]{2}$", m), nrow(m))
  hdr <- which(rowSums(is_year) >= 5)
  if (!length(hdr)) stop("no row of years in sheet '", sheet, "'")
  hdr <- hdr[1]
  ycols <- which(is_year[hdr, ])
  years <- as.integer(m[hdr, ycols])
  lab_cols <- seq_len(min(ycols) - 1)

  # Label = first non-empty cell left of the years; the units column sits
  # in the same block
  labels <- apply(m[, lab_cols, drop = FALSE], 1, function(r) {
    r <- r[!is.na(r) & r != ""]
    if (length(r)) r[1] else NA_character_
  })
  units <- apply(m[, lab_cols, drop = FALSE], 1, function(r) paste(r[!is.na(r)], collapse = " | "))
  lab_clean <- sub("[[:space:]]*[(][a-z][)]$", "", tolower(labels))

  # Actual vs. projected years: the forecast values are shaded (all files).
  # As a check, the first shaded year must be the year before the
  # publication year or the publication year itself.
  pubyear <- as.integer(format(pubdate, "%Y"))
  shade <- if (grepl("[.]xlsx$", path, ignore.case = TRUE)) {
    xlsx_shaded_cells(path, sheet)
  } else {
    xls_shaded_cells(path, sheet)
  }

  out <- NULL
  for (v in names(row_specs)) {
    spec <- row_specs[[v]]
    r0 <- which(grepl(spec$label, lab_clean) & seq_along(lab_clean) > hdr)
    if (!length(r0)) stop("row for ", v, " not found")
    r <- r0[1]
    if (spec$pct) {
      cand <- r:min(r + 2, nrow(m))
      cand <- cand[grepl("percent(age)? change", units[cand], ignore.case = TRUE)]
      if (!length(cand)) stop("percentage-change row for ", v, " not found below row ", r)
      r <- cand[1]
    }
    values <- suppressWarnings(as.numeric(m[r, ycols]))
    s <- shade[shade$row == r, ]
    projection <- s$shaded[match(ycols, s$col)] %in% TRUE
    if (!any(projection)) stop("no shaded (forecast) cells in the ", v, " row")
    if (any(diff(projection) < 0)) stop("shaded cells of the ", v, " row are not the final years")
    if (!min(years[projection]) %in% c(pubyear - 1, pubyear)) {
      stop("first shaded year of ", v, " (", min(years[projection]),
           ") is neither the publication year nor the year before")
    }
    out <- bind_rows(out, data.frame(year = years, variable = v, value = values,
                                     projection = projection))
  }
  out
}

result <- NULL
for (i in seq_len(nrow(vintages))) {
  pubdate_i <- as.Date(vintages$pubdate[i])
  path_i <- download_vintage(vintages$file_url[i], vintages$archive_url[i])
  temp_i <- tryCatch(parse_vintage(path_i, pubdate_i),
                     error = function(e) stop("Vintage ", vintages$pubdate[i], " (",
                                              vintages$file_url[i], "): ", conditionMessage(e),
                                              call. = FALSE))
  unlink(path_i)

  temp_i <- temp_i %>%
    filter(projection, !is.na(value))
  # Every vintage has to give all three variables over at least three years
  n_i <- table(factor(temp_i$variable, levels = names(row_specs)))
  if (any(n_i < 3)) {
    stop("Vintage ", vintages$pubdate[i], ": too few projection years (",
         paste(names(n_i), n_i, collapse = ", "), ")")
  }

  result <- bind_rows(result, temp_i %>% mutate(pubdate = pubdate_i))
  Sys.sleep(2)
}

result <- result %>%
  mutate(year = as.character(year),
         ctry = 111, # United States
         value = round_half_up(value, 1)) %>%
  arrange(pubdate, variable, year) %>%
  select(year, ctry, variable, pubdate, value)

write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
