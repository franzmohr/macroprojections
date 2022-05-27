
rm(list = ls())

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
for (i in 1:nlist) {
  
  file_i <- list_files[i]
  
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
  
  result[[i]] <- temp_i
  rm(temp_i)
}

result <- bind_rows(result)

write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
