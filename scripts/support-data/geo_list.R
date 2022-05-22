

library(dplyr)
library(readr)
library(readxl)
library(rsdmx)

# Temporary files
tf <- tempfile(tmpdir = tdir <- tempdir()) #temp file and folder

# IMF-code - country name - mapping
download.file("https://www.imf.org/-/media/Files/Publications/WEO/WEO-Database/2022/WEOApr2022-SDMX-DSD.ashx", tf)

imf_mapping <- read_excel(path = tf, sheet = "REF_AREA", skip = 7) %>%
  rename(ctry = Code,
         ctry_name = Description) %>%
  select(ctry, ctry_name)

# IMF-code - ISO3 - mapping
iso3 <- read_excel("scripts/support-data/geo.xlsx", na = "n/a") %>%
  select(`WEO Country Code`, ISO) %>%
  rename(ctry = `WEO Country Code`,
         iso3 = ISO) %>%
  distinct() %>%
  mutate(ctry = as.character(ctry))

# Alpha 2 and alpha 3 mapping for euro area
#iso2 <- read_csv("scripts/support-data/iso2_iso3.csv")

# Combine
geo_list <- imf_mapping %>%
  left_join(iso3, by = "ctry") %>%
  #left_join(iso2, by = "iso3") %>%
  select(ctry, iso3, ctry_name)

write.csv(geo_list, file = "scripts/support-data/geo_list.csv", row.names = FALSE)