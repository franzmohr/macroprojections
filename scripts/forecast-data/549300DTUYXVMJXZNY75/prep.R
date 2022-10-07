
rm(list = ls())

library(dplyr)
library(ecb)
library(readr)
library(readxl)
library(tidyr)

lei <- "549300DTUYXVMJXZNY75"

root_path <- paste0("scripts/forecast-data/", lei, "/")

# Download data from ECB homepage
data <- get_data("MPD.A..YER+HIC+URX...0000")

result <- data %>%
  mutate(pubmonth = substring(pd_seas_ex, 1, 1), # Extract month of projection
         pubyear = paste0("20", substring(pd_seas_ex, 2, 3))) %>% # Extract year of projection
  filter(obstime >= pubyear) %>% # Drop "actual" data
  # Convert ECB codes to IMF codes
  mutate(variable = case_when(pd_item == "YER" ~ "NGDP_RPCH",
                              pd_item == "HIC" ~ "PCPIPCH",
                              pd_item == "URX" ~ "LUR"),
         # Convert ECB codes to pseudo-dates
         pubdate = case_when(pubmonth == "A" ~ "-12-01",
                             pubmonth == "G" ~ "-06-01",
                             pubmonth == "S" ~ "-09-01",
                             pubmonth == "W" ~ "-03-01"),
         # Gernate publication date variable
         pubdate = paste0(pubyear, pubdate)) %>%
  rename(year = obstime,
         value = obsvalue) %>%
  select(year, ref_area, variable, pubdate, value)

geo_list <- readr::read_csv("scripts/forecast-data/549300DTUYXVMJXZNY75/imf_ecb.csv")

result <- result %>%
  left_join(geo_list, by = c("ref_area" = "ecb")) %>%
  select(year, ctry, variable, pubdate, value) %>%
  filter(!is.na(ctry))

write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
