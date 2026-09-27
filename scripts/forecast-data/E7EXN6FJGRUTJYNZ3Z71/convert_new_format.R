# Converts the WEO vintages published on the IMF Data Portal (October 2025,
# April 2026), which are no longer issued as WEO_PUB SDMX files, into the
# columns that prep.R produces: year, variable, ctry, value, pubdate.
#
# Source: the official "WEO <Month> <Year> Entire Dataset in Excel" files
# (sheet "Countries"). ISO3 codes are mapped to the IMF numeric WEO country
# codes with the April 2025 tab-delimited file (weoapr2025all.xls), the last
# vintage that carries both the "WEO Country Code" and the "ISO" column.
# Nothing is interpolated or imputed: rows without a value are dropped, as in
# prep.R.

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readxl)
})

root <- "C:/Users/mo_fr/AppData/Local/Temp/claude/D--workspace-r-bvartools/139db88b-2aa1-4cf7-9255-29204084a6a0/scratchpad/mp_consumption/E7EXN6FJGRUTJYNZ3Z71_weo/"
orig <- paste0(root, "original/")

vars <- c("NGDP_RPCH", "PCPIPCH", "LUR")

# ISO3 -> IMF numeric code, from the April 2025 tab-delimited file (UTF-16LE)
con <- file(paste0(orig, "weoapr2025all.xls"), encoding = "UTF-16LE")
tab <- read.delim(con, colClasses = "character", check.names = FALSE,
                  na.strings = c("", "n/a", "--"))
code_map <- tab %>%
  select(code = `WEO Country Code`, iso = ISO) %>%
  filter(!is.na(code), !is.na(iso)) %>%
  distinct()
stopifnot(!any(duplicated(code_map$iso)), !any(duplicated(code_map$code)))
code_map$code <- as.integer(code_map$code)
# The portal uses ISO "KOS" for Kosovo, which the April 2025 file lists as
# "UVK" (WEO code 967, country name "Kosovo"). Liechtenstein (LIE) has no WEO
# numeric code in any WEO_PUB file and is therefore left out.
stopifnot(code_map$code[code_map$iso == "UVK"] == 967)
code_map <- bind_rows(code_map, data.frame(code = 967L, iso = "KOS"))
# The euro area is the only aggregate that carries a last-actual year, so it
# is the only aggregate prep.R keeps from the WEO_PUB files (REF_AREA 163,
# LUR only in practice). On the portal it is "G163" on the sheet
# "Country Groups".
code_map <- bind_rows(code_map, data.frame(code = 163L, iso = "G163"))

# LATEST_ACTUAL_ANNUAL_DATA is either a year ("2024") or, for economies that
# report on a fiscal-year basis, a string like "FY2023/24". In the WEO_PUB
# files that prep.R reads, LASTACTUALDATE for such series is always the year
# in which the fiscal year ENDS (checked on every series whose NOTES say
# "Latest actual data: FYxxxx/yy" in 20241022_weo.xml and 20250422_weo.xml:
# 386 and 367 series, no exception, including the series whose notes state
# FY(t/t+1) = CY(t)). The same rule is applied here, so that the projection
# cut-off is the one prep.R would have used.
last_actual_year <- function(x) {
  out <- rep(NA_character_, length(x))
  cy <- !is.na(x) & grepl("^[0-9]{4}$", x)
  fy <- !is.na(x) & grepl("^FY[0-9]{4}/[0-9]{2}$", x)
  out[cy] <- x[cy]
  out[fy] <- as.character(as.integer(substr(x[fy], 3, 6)) + 1L)
  bad <- !is.na(x) & !cy & !fy
  if (any(bad)) stop("Unrecognised LATEST_ACTUAL_ANNUAL_DATA: ",
                     paste(unique(x[bad]), collapse = ", "))
  out
}

convert <- function(file, pubdate) {
  x <- bind_rows(
    read_excel(paste0(orig, file), sheet = "Countries", col_types = "text"),
    read_excel(paste0(orig, file), sheet = "Country Groups", col_types = "text") %>%
      filter(COUNTRY.ID == "G163")
  )
  x <- x %>%
    filter(FREQUENCY == "Annual", INDICATOR.ID %in% vars)
  # a series must appear only once per country and indicator
  stopifnot(!any(duplicated(x[, c("COUNTRY.ID", "INDICATOR.ID")])))
  unmapped <- setdiff(unique(x$COUNTRY.ID), code_map$iso)
  if (length(unmapped) > 0) {
    message(file, ": ISO codes without IMF numeric code: ",
            paste(unmapped, collapse = ", "))
  }
  yrs <- grep("^[0-9]{4}$", names(x), value = TRUE)
  x %>%
    select(iso = COUNTRY.ID, variable = INDICATOR.ID,
           last = LATEST_ACTUAL_ANNUAL_DATA, all_of(yrs)) %>%
    mutate(last = last_actual_year(last)) %>%
    pivot_longer(all_of(yrs), names_to = "year", values_to = "value") %>%
    # prep.R: TIME_PERIOD > LASTACTUALDATE (series without a last actual
    # year are dropped there, because the comparison yields NA)
    filter(!is.na(last), year > last) %>%
    filter(!is.na(value), value != "n/a", value != "--") %>%
    mutate(value = as.numeric(gsub(",", "", value))) %>%
    filter(!is.na(value)) %>%
    inner_join(code_map, by = "iso") %>%
    transmute(year, variable, ctry = code, value,
              pubdate = as.Date(pubdate)) %>%
    arrange(variable, ctry, year)
}

vintages <- list(
  list(file = "WEOOct2025all.xlsx", pubdate = "2025-10-14", out = "20251014_weo.csv"),
  list(file = "WEOApr2026all.xlsx", pubdate = "2026-04-14", out = "20260414_weo.csv")
)

if (sys.nframe() == 0L) for (v in vintages) {
  res <- convert(v$file, v$pubdate)
  write.csv(res, paste0(root, "raw/", v$out), row.names = FALSE)
  cat(v$out, ":", nrow(res), "rows,", length(unique(res$ctry)), "countries\n")
  print(table(res$variable, res$year))
}
