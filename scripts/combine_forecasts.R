
rm(list = ls())

library(dplyr)
library(openxlsx)

# Get list of all available institutions from which forecasts are available
# At the same time this is the list of folders with raw data
list_institutions <- list.dirs("scripts/forecast-data", full.names = FALSE, recursive = FALSE)

root_path <- "scripts/forecast-data/"

ntot <- length(list_institutions)

# Combine institutions' projections ----

result <- NULL
for (i in 1:ntot) {
  
  file_i <- paste0(root_path, list_institutions[i])
  
  if ("forecasts.csv" %in% list.files(file_i)) { # Only update if a valid forecasts.csv file is available
    
    temp_i <- read.csv(paste0(file_i, "/forecasts.csv")) # Read data
    
    if (!"institution" %in% names(temp_i)) {
     temp_i[, "institution"] <- list_institutions[i] # Add institution information
    }
    
    for (j in c("year", "ctry", "variable", "pubdate")) {
      if (class(temp_i[, j]) != "character") {
        temp_i[, j] <- as.character(temp_i[, j])
      }
    }
    
    # Later me, please add
    # - checks
    # - produce feedback files with errors that are stored in the institution's folder
    # - put this loop into an lapply function for parallelisation
    
    result[[i]] <- temp_i
  }
}

result <- bind_rows(result)

# Meta data ----

meta <- result %>%
  select(institution, variable, pubdate) %>%
  distinct() %>%
  group_by(institution, variable) %>%
  filter(pubdate == max(pubdate))

# Save data ----

# xlsx
wb <- createWorkbook()
addWorksheet(wb, "data")
addWorksheet(wb, "meta")
writeData(wb, "data", result)
writeData(wb, "meta", meta)
saveWorkbook(wb, file = "data/forecasts.xlsx", overwrite = TRUE)

# csv
write.csv(result, file = "data/forecasts.csv", row.names = FALSE)
write.csv(result, file = "data/meta.csv", row.names = FALSE)
