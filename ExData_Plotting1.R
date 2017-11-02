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
if (!file.exists("household_power_consumption")) {
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


globalActivePower <- as.numeric(FEB_2007_household_power_consumption$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
