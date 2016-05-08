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

#Create plot
png("plot2.png", width = 480, height = 480)
plot(datetime, globalActivePowr, type="l", xlab = "", ylab ="Global Active Power (kilowatts")
dev.off()