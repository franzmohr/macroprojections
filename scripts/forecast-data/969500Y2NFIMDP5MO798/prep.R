
rm(list = ls())

library(dplyr)
library(tidyr)

lei <- "969500Y2NFIMDP5MO798"

root_path <- paste0("scripts/forecast-data/", lei, "/")

# One file per Economic Outlook edition (or interim release) and variable,
# "YYYYMMDD_<VARIABLE>.csv", with a column "Category" of country names as in
# scripts/support-data/geo_list.csv and one column per projection year
list_files <- list.files(paste0(root_path, "raw/"), pattern = "[.]csv$")

result <- NULL
for (file_i in list_files) {

  path_i <- paste0(root_path, "raw/", file_i)

  type_i <- gsub(".csv", "", substring(file_i, 10, nchar(file_i)))
  date_i <- as.Date(substring(file_i, 1, 8), "%Y%m%d")

  temp_i <- read.csv(path_i) %>%
    rename(geo = Category) %>%
    pivot_longer(cols = -c("geo"), names_to = "year", values_to = "value") %>%
    mutate(year = substring(year, 2, 5),
           variable = type_i,
           pubdate = date_i) %>%
    filter(!is.na(value))

  result <- bind_rows(result, temp_i)
  rm(temp_i)
}

ctry_list <- read.csv("scripts/support-data/geo_list.csv")

# Values that do not measure what the IMF code stands for are listed in
# exclusions.csv (pubdate, variable, geo, reason) and dropped
exclusions <- read.csv(paste0(root_path, "exclusions.csv"), stringsAsFactors = FALSE) %>%
  mutate(pubdate = as.Date(as.character(pubdate), "%Y%m%d"))

result <- result %>%
  # Only variables with an IMF WEO code
  filter(variable %in% c("NGDP_RPCH", "PCPIPCH", "LUR")) %>%
  anti_join(exclusions, by = c("pubdate", "variable", "geo")) %>%
  left_join(ctry_list, by = c("geo" = "ctry_name")) %>%
  select(year, ctry, variable, pubdate, value) %>%
  filter(!is.na(ctry))

write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
