
rm(list = ls())

library(dplyr)
library(tidyr)

root_path <- "scripts/forecast-data/529900FMFN29HKS4BE19/"

# Get list of files in the folder
list_files <- list.files(paste0(root_path, "raw/"))

nlist <- length(list_files)
result <- NULL
for (i in 1:nlist) {
  
  file_i <- list_files[i]
  
  path_i <- paste0(root_path, "raw/", file_i)
  
  date_i <- as.Date(substring(file_i, 1, 8), "%Y%m%d")
  
  temp_i <- readxl::read_excel(path_i) %>%
    pivot_longer(cols = -c("variable"), names_to = "year", values_to = "value") %>%
    mutate(pubdate = date_i,
           ctry = 122L)
  
  result <- bind_rows(result, temp_i)
  rm(temp_i)
}

write.csv(result,
          file = "scripts/forecast-data/529900FMFN29HKS4BE19/forecasts.csv",
          row.names = FALSE)
