
rm(list = ls())

library(dplyr)
library(tidyr)

lei <- "5299001Z8JOKGWV5O949"

root_path <- paste0("scripts/forecast-data/", lei, "/")

# Get list of files in the folder
list_files <- list.files(paste0(root_path, "raw/"))

nlist <- length(list_files)
result <- NULL
for (i in 1:nlist) {
  
  file_i <- list_files[i]
  
  path_i <- paste0(root_path, "raw/", file_i)
  
  date_i <- as.Date(substring(file_i, 1, 8), "%Y%m%d")
  
  temp_i <- read.csv(path_i) %>%
    pivot_longer(cols = -c("variable"), names_to = "year", values_to = "value") %>%
    mutate(year = substring(year, 2, 5),
           pubdate = date_i,
           ctry = "122")
  
  result <- bind_rows(result, temp_i)
  rm(temp_i)
}

write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
