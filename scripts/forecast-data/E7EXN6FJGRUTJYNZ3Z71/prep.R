
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
result <- parallel::mclapply(list_files, read_imf_pred, root_path = root_path, mc.cores = 3)

# Combine data
result <- bind_rows(result)

# Write institution-specific csv file
write.csv(result,
          file = paste0(root_path, "forecasts.csv"),
          row.names = FALSE)
