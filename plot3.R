
#Loading the data
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, temp)
Full_Data <- read.table(unz(temp, "household_power_consumption.txt"), 
                        sep = ";", 
                        header = T, 
                        na = "?",
                        colClasses = c("character",
                                       "character",
                                       "numeric",
                                       "numeric",
                                       "numeric",
                                       "numeric",
                                       "numeric",
                                       "numeric",
                                       "numeric"))
unlink(temp)

#Converting Date and Time variables to Date/Time classes
Data <- subset(Full_Data, Date %in% c("1/2/2007", "2/2/2007"))
DateTime <- as.POSIXlt.character(paste(Data$Date, Data$Time), format = "%d/%m/%Y %H:%M:%S")
powerData <- cbind(DateTime, subset(Data, select = -c(Date, Time)))

#Making Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(powerData$DateTime, powerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$DateTime, powerData$Sub_metering_2, col = "red")
lines(powerData$DateTime, powerData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1)
dev.off()