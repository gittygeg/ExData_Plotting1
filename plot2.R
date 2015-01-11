## Exploratory Data Analysis Project One
# prepare data repository for this project
if (!file.exists("data")) {
  dir.create("data")
}

# acquire raw data for this project
if (!file.exists("./data/household_power_consumption.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./data/household_power_consumption.zip")
  dateDownloaded <- date()
}

# initialize or refresh the raw data file
if (!file.exists("./data/household_power_consumption.txt")) {
  unzip("./data/household_power_consumption.zip", exdir = "./data")
}

# read raw data file into table
# use colClasses to set appropiate class types for table columns
# to speed file read, avoid coercions, and filter for unkown values

classes <- c(rep("character",2), rep("numeric",7))

powerData <- read.table("./data/household_power_consumption.txt",
                        sep=";",
                        colClasses=classes, header=TRUE,
                        stringsAsFactors=FALSE,
                        na.strings="?")

onlyDates = c("1/2/2007","2/2/2007")
chartData <- powerData[powerData$Date %in% onlyDates,]

DateTime <- paste(chartData$Date, chartData$Time, sep = " ")
pTimes <- as.POSIXct(DateTime, tz="", format="%d/%m/%Y %H:%M:%S")

#head(pTimes)
chartData <- cbind(pTimes, chartData)

# plot2 - line chart
plot(pTimes, chartData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )
