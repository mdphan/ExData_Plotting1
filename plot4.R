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

## Generate plot 4
png(filename="plot4.png")
par(mfrow=c(2,2))

plot(sdata$Time, sdata$Global_active_power, type = "l", xlab ="", ylab="Global Active Power")

plot(sdata$Time, sdata$Voltage, type = "l", xlab ="datetime", ylab="Voltage")

plot(sdata$Time, sdata$Sub_metering_1, col="black", xlab="", ylab="Energy sub metering", type = "l")
lines(sdata$Time, sdata$Sub_metering_2, col="red")
lines(sdata$Time, sdata$Sub_metering_3, col="blue")
leg.txt <- names(sdata[,7:9])
leg.lty <- rep("solid",3)
leg.col <- c("black", "red", "blue")
legend("topright", lty=leg.lty, col=leg.col, legend=leg.txt)

plot(sdata$Time, sdata$Global_reactive_power, type = "l", xlab ="datetime", ylab="Global_reactive_power")

dev.off()
