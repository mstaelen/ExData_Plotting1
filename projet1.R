setwd("~/Documents/DataScientist/Module 4/Projet 1")
hpc <- read.csv2("./data/household_power_consumption.txt")
library(lubridate)

#sample <- hpc[((hpc$Date=="2/2/2007") | (hpc$Date=="1/2/2007")) ,]
sample <- subset(hpc,(hpc$Date %in% c("2/2/2007","1/2/2007")))
sample$DateTime <- strptime(paste(sample$Date, sample$Time),format="%d/%m/%Y %H:%M:%S")
sample$Global_active_power <- as.numeric(sample$Global_active_power)
sample$Global_reactive_power <- as.numeric(sample$Global_reactive_power)
sample$Global_intensity <- as.numeric(sample$Global_intensity)
sample$Sub_metering_1 <-as.numeric(as.character(sample$Sub_metering_1))
sample$Sub_metering_2 <-as.numeric(as.character(sample$Sub_metering_2))
sample$Sub_metering_3 <-as.numeric(as.character(sample$Sub_metering_3))

##Plot 1
#-----
library(datasets)
png(filename="plot1.png",width=480,height=480,units="px")
#with(faithful, {
        hist(sample$Global_active_power,col="red",main = "Global Active Power",
                    xlab="Global active power (kilowatts)")
 #    }     ) ## Create plot on screen device

#dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
#----

##Plot 2
#-----
library(datasets)
png(filename="plot2.png",width=480,height=480,units="px")
with(faithful, {   
        plot(x=sample$DateTime,y=sample$Global_active_power,type="l"
             ,ylab="Global active power (kilowatts)"
             ,xlab="")
        })
dev.off()
#----

##Plot 3
#----
library(datasets)

png(filename="plot3.png",width=480,height=480,units="px")
plot(x=sample$DateTime,y=sample$Sub_metering_1, col="black",type="l"
     ,xlab="",ylab="Energy sub metering")
lines(x=sample$DateTime,y=sample$Sub_metering_2,col="red",type="l")
points(x=sample$DateTime,y=sample$Sub_metering_3,col="blue",type="l")
legend("topright",  lty=1,
       col = c("black", "red","blue"), 
       legend =  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = "Energy sub metering")

dev.off()
#----


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