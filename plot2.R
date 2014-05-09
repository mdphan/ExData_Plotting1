## Download and unzip data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")) {
    download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip", method = "curl")
    unzip("exdata-data-household_power_consumption.zip")
    dateDownloaded <- format(Sys.Date(), "%Y%m%d")
}

## Load data
data <- read.csv2("household_power_consumption.txt", na.strings = "?", as.is = TRUE)
data[,c(3:9)] <- sapply(data[,c(3:9)], as.numeric) ## change columns 3:9 to numeric
data$Time <- strptime(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Select data between 2007-02-01 to 2007-02-02 for plotting
sdata <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

## Generate plot 2
png(filename="plot2.png")
plot(sdata$Time, sdata$Global_active_power, type = "l", xlab ="", ylab="Global Active Power (kilowatts)")
dev.off()
