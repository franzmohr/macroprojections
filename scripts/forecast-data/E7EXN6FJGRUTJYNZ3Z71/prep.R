
rm(list = ls())

# Imports and prepares data from the IMF World Economic Outlook database

# Notes for future work:
# - The update is very slow. Think about revising the code to achieve a faster import.
# - Produce feedback files with errors that are stored in the institution's folder


library(dplyr)
library(rsdmx)
library(tidyr)

lei <- "E7EXN6FJGRUTJYNZ3Z71"

root_path <- paste0("scripts/forecast-data/", lei, "/")

# Get list of files in the folder
list_files <- list.files(paste0(root_path, "raw/"))
list_files <- list_files[which(grepl(".xml", tolower(list_files)))]

nlist <- length(list_files)
result <- NULL

# Define function, which read individual xml files
read_imf_pred <- function(file_i, root_path) {
  
  path_i <- paste0(root_path, "raw/", file_i)
  
  date_i <- as.Date(substring(file_i, 1, 8), "%Y%m%d")
  
  temp_i <- readSDMX(file = path_i, isURL = FALSE)
  temp_i <- as.data.frame(temp_i) %>%
    filter(FREQ == "A",
           TIME_PERIOD > LASTACTUALDATE,
           CONCEPT %in% c("NGDP_RPCH", "PCPIPCH", "LUR")) %>%
    rename(variable = CONCEPT,
           ctry = REF_AREA,
           value = OBS_VALUE,
           year = TIME_PERIOD) %>%
    select(year, variable, ctry, value) %>%
    mutate(value = ifelse(value == "n/a", NA, value)) %>%
    filter(!is.na(value)) %>%
    mutate(value = gsub(",", "", value),
           value = as.numeric(value),
           pubdate = date_i,
           ctry = as.integer(ctry))
  
  return(temp_i)
}

# Read xml files in parallel
result <- parallel::mclapply(list_files, read_imf_pred, root_path = root_path)

# Combine data
result <- bind_rows(result)

# WEO vintages from October 2025 on are published only in the IMF's new data
# portal format (ISO3 country codes, fiscal years as "FY2023/24"). They are
# kept as raw/YYYYMMDD_weo.csv, already converted to the columns above; the
# conversion is documented in raw/README.md.
list_csv <- list.files(paste0(root_path, "raw/"), pattern = "_weo[.]csv$", full.names = TRUE)
if (length(list_csv) > 0) {
  weo_csv <- bind_rows(lapply(list_csv, function(f) {
    read.csv(f, stringsAsFactors = FALSE) %>%
      mutate(year = as.character(year), pubdate = as.Date(pubdate), ctry = as.integer(ctry))
  }))
  result <- bind_rows(result %>% mutate(year = as.character(year)), weo_csv)
}

# Article IV staff reports for Austria: projections from the staff report's
# indicator table, dated by the report's publication date. Only the variables
# with an IMF WEO code are kept; see article-iv/coverage.md for the sources.
list_a4 <- list.files(paste0(root_path, "article-iv/raw/"), pattern = "_forecasts[.]csv$", full.names = TRUE)
if (length(list_a4) > 0) {
  article_iv <- bind_rows(lapply(list_a4, function(f) {
    read.csv(f, check.names = FALSE, stringsAsFactors = FALSE) %>%
      pivot_longer(cols = -c("variable"), names_to = "year", values_to = "value") %>%
      filter(variable %in% c("NGDP_RPCH", "PCPIPCH", "LUR"), !is.na(value)) %>%
      mutate(ctry = 122L, pubdate = as.Date(substring(basename(f), 1, 8), "%Y%m%d"))
  }))
  result <- bind_rows(result %>% mutate(year = as.character(year)), article_iv)
}

# Write institution-specific csv file
write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
