#Check if file exist, if not download it and unzip it.
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
#Read file and filter data
data<- read.table(file, header = TRUE, sep=";", stringsAsFactors = FALSE, dec = ".")
filterData <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

#convert data to numeric, date and time values
datetime <- strptime(paste(filterData$Date, filterData$Time, sep= " "), "%d/%m/%Y %H:%M:%S")
globalActivePowr <- as.numeric(filterData$Global_active_power)
globalReactivePowr <- as.numeric(filterData$Global_reactive_power)
voltage <-as.numeric(filterData$Voltage)
subMetering1 <- as.numeric(filterData$Sub_metering_1)
subMetering2 <- as.numeric(filterData$Sub_metering_2)
subMetering3 <- as.numeric(filterData$Sub_metering_3)

#Create plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot(datetime, globalActivePowr, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePowr, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
