#Data file init
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
#Read file
hpc <- read.csv2("./household_power_consumption.txt")
#Prepare the data
sample <- subset(hpc,(hpc$Date %in% c("2/2/2007","1/2/2007")))
sample$DateTime <- strptime(paste(sample$Date, sample$Time),format="%d/%m/%Y %H:%M:%S")
sample$Global_active_power <- as.numeric(sample$Global_active_power)
sample$Global_reactive_power <- as.numeric(sample$Global_reactive_power)
sample$Global_intensity <- as.numeric(sample$Global_intensity)
sample$Sub_metering_1 <-as.numeric(as.character(sample$Sub_metering_1))
sample$Sub_metering_2 <-as.numeric(as.character(sample$Sub_metering_2))
sample$Sub_metering_3 <-as.numeric(as.character(sample$Sub_metering_3))

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
print("Done.")
