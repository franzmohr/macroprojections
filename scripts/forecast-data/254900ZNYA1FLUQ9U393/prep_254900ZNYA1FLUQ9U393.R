
rm(list = ls())

library(dplyr)
library(tidyr)

lei <- "254900ZNYA1FLUQ9U393"

root_path <- paste0("scripts/forecast-data/", lei, "/")

# Get list of files in the folder
list_files <- list.files(paste0(root_path, "raw/"))

nlist <- length(list_files)
result <- NULL
for (i in 1:nlist) {
  
  file_i <- list_files[i]
  
  path_i <- paste0("scripts/forecast-data/254900ZNYA1FLUQ9U393/raw/", file_i)
  
  type_i <- gsub(".csv", "", substring(file_i, 10, nchar(file_i)))
  date_i <- as.Date(substring(file_i, 1, 8), "%Y%m%d")
  
  temp_i <- read.csv(path_i) %>%
    rename(geo = Category) %>%
    pivot_longer(cols = -c("geo"), names_to = "year", values_to = "value") %>%
    mutate(year = substring(year, 2, 5),
           variable = type_i,
           pubdate = date_i)
  
  result <- bind_rows(result, temp_i)
  rm(temp_i)
}

ctry_list <- read.csv("scripts/support-data/geo_list.csv")

result <- result %>%
  mutate(geo = case_when(geo == "Czechia" ~ "Czech Republic",
                         geo == "Slovakia" ~ "Slovak Republic",
                         TRUE ~ geo)) %>%
  left_join(ctry_list, by = c("geo" = "ctry_name")) %>%
  select(year, ctry, variable, pubdate, value) %>%
  filter(!is.na(ctry))

write.csv(result,
          file = "scripts/forecast-data/254900ZNYA1FLUQ9U393/forecasts.csv",
          row.names = FALSE)
