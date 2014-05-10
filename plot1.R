## Coursera. Explopratory Data Analysis: Course Project 1.1. May 10, 2014

## read in, examine, and subset data; set column types; create new variable Date_time
library(data.table)
DT <- fread("household_power_consumption.txt", header = TRUE, na.strings = "?")
str(DT)
DT <- DT[DT$Date=="1/2/2007" | DT$Date=="2/2/2007",]
DT[, 3:9:= lapply(.SD, as.numeric), .SDcols = 3:9]
x <- paste(DT$Date, DT$Time)
DT[, Date_time:= as.POSIXct(strptime(x, "%d/%m/%Y %H:%M:%S"))]

## save histogram (plot1) as .png image
png(file = "plot1.png")
hist(DT$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
