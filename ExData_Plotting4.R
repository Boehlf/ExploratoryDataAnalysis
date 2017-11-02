getwd()
setwd("C:/Git/Workspace/ExploratoryDataAnalysis/Assignment1")


filepath_plot1 <- paste(getwd(),"/Data",sep="")

# Cname of the file to store Human Activity Recognition Using Smartphones data
filename <- "exdata_data_household_power_consumption.zip"

## Download data at "C:/Git/Workspace/ExploratoryDataAnalysis/Data"
if (!file.exists(filename)) {
  fileURL <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filePath <- file.path(filepath_plot1, filename)
  download.file(fileURL, filePath)
}

# check if file exists otherwise extract
if (!file.exists("household_power_consumption.txt")) {
  unzip(zipfile = filePath, exdir = filepath_plot1)
}

extractfilepath = paste(filepath_plot1, "/household_power_consumption.txt", sep = "")
household_power_consumption <-
  read.table(
    extractfilepath,
    header = TRUE,
    sep = ";",
    stringsAsFactors = FALSE,
    dec = "."
  )

FEB_2007_household_power_consumption <-
  household_power_consumption[household_power_consumption$Date %in% c("1/2/2007", "2/2/2007") , ]


datetime <- strptime(paste(FEB_2007_household_power_consumption$Date, FEB_2007_household_power_consumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(FEB_2007_household_power_consumption$Global_active_power)
globalReactivePower <- as.numeric(FEB_2007_household_power_consumption$Global_reactive_power) 
voltage <- as.numeric(FEB_2007_household_power_consumption$Voltage)
subMetering1 <- as.numeric(FEB_2007_household_power_consumption$Sub_metering_1)
subMetering2 <- as.numeric(FEB_2007_household_power_consumption$Sub_metering_2)
subMetering3 <- as.numeric(FEB_2007_household_power_consumption$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
