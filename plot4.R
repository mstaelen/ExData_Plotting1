if (c("household_power_consumption.txt") %in% dir()) {
        print("we use the current file")
} else {
        if (c("exdata-data-household_power_consumption.zip") %in% dir()) {
                filePath <- file.path(getwd())
                files <- unzip( "exdata-data-household_power_consumption.zip" 
                                , exdir = filePath )
        } else {
                print("Note: exdata-data-household_power_consumption.zip is required")
                stop("Please try again")
        }
}

hpc <- read.csv2("./household_power_consumption.txt")

sample <- subset(hpc,(hpc$Date %in% c("2/2/2007","1/2/2007")))
sample$DateTime <- strptime(paste(sample$Date, sample$Time),format="%d/%m/%Y %H:%M:%S")
sample$Global_active_power <- as.numeric(sample$Global_active_power)
sample$Global_reactive_power <- as.numeric(sample$Global_reactive_power)
sample$Global_intensity <- as.numeric(sample$Global_intensity)
sample$Sub_metering_1 <-as.numeric(as.character(sample$Sub_metering_1))
sample$Sub_metering_2 <-as.numeric(as.character(sample$Sub_metering_2))
sample$Sub_metering_3 <-as.numeric(as.character(sample$Sub_metering_3))

## Plot 4
#----
library(datasets)
png(filename="plot4.png",width=480,height=480,units="px")
par(mfcol = c(2, 2), mar = c(4, 4, 3, 2), oma = c(0, 0, 2, 0))

hist(sample$Global_active_power,col="red",main = "Global Active Power",
     xlab="Global active power (kilowatts)")

plot(x=sample$DateTime,y=sample$Sub_metering_1, col="black",type="l"
     ,xlab="",ylab="Energy sub metering")
lines(x=sample$DateTime,y=sample$Sub_metering_2,col="red",type="l")
points(x=sample$DateTime,y=sample$Sub_metering_3,col="blue",type="l")
legend("topright",  lty=1,
       col = c("black", "red","blue"), 
       legend =  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = "Energy sub metering")


plot(x=sample$DateTime,y=sample$Global_active_power,type="l"
     ,ylab="Global active power (kilowatts)"
     ,xlab="")


plot(x=sample$DateTime,y=sample$Global_reactive_power, type="l"
     ,ylab="Global reactive power"
     ,xlab="DateTime")
dev.off()
#----
print("done")