# Create plot 1
library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

source <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
summary <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Histogram 
summary[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

totalsum <- summary[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

barplot(totalsum[, Emissions]
        , names = totalsum[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")