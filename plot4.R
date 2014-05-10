## Coursera. Explopratory Data Analysis: Course Project 1.4. May 10, 2014

## read in, examine, and subset data; set column types; create new variable Date_time
library(data.table)
DT <- fread("household_power_consumption.txt", header = TRUE, na.strings = "?")
str(DT)
DT <- DT[DT$Date=="1/2/2007" | DT$Date=="2/2/2007",]
DT[, 3:9:= lapply(.SD, as.numeric), .SDcols = 3:9]
x <- paste(DT$Date, DT$Time)
DT[, Date_time:= as.POSIXct(strptime(x, "%d/%m/%Y %H:%M:%S"))]

## save graphs (plot4) as .png image
png(file = "plot4.png")
par(mfrow = c(2,2))
plot(DT$Date_time, DT$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(DT$Date_time, DT$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(DT$Date_time, DT$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(DT$Date_time, DT$Sub_metering_2, col = "red", type = "l")
lines(DT$Date_time, DT$Sub_metering_3, col = "blue", type = "l")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, col = c("black", "red", "blue"), bty = "n")
plot(DT$Date_time, DT$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

