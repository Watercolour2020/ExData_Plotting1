# This program inputs Household Power Consumption data (if necessary), filters
# it for Feb 1-2, 2007, and does a 2x2 lattice plot of power consumption and
# Author H Stiff April 2016

setwd("~/GitHub/Exploratory Data Analysis")
if (!exists("hpc")) {                                                           #if hpc dataset does
     hpc <-                                                                     #not exist,
          subset(
               read.csv(                                                        #import from txt file
                    "~/GitHub/Exploratory Data Analysis/household_power_consumption.txt",
                    sep = ";",
                    na.strings = "?"
               ),
               Date == "1/2/2007" |
               Date == "2/2/2007"                                               #subset to Feb1 & Feb2 2007
          )
     hpc$DateTime <-
          strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")              #add date-time column
}                                                                               #note: date in dmy format
#View(hpc)
#-------------------------------------------------------------------------------
# Start device driver to save output to PNG file
png(filename="~/GitHub/Exploratory Data Analysis/Plot4.png", height=480, width=480, bg="white")

par(mfrow = c(2, 2))  # 2 rows and 2 columns
#Plot1 - Global active power consumption time-series...
plot(hpc$DateTime,hpc$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

#Plot2 - Voltage time-series...
plot(hpc$DateTime,hpc$Voltage,type="l",ylab="Voltage)",xlab="")

#Plot3 - Energy sub-metering time-series...
plot(hpc$DateTime,hpc$Sub_metering_1,type="n",ylab="Energy Sub-Metering",xlab="")
lines(hpc$DateTime,hpc$Sub_metering_1,type="l",xlab="",col="black",ylim=c(0,30))
lines(hpc$DateTime,hpc$Sub_metering_2,type="l",xlab="",col="red",ylim=c(0,30))
lines(hpc$DateTime,hpc$Sub_metering_3,type="l",xlab="",col="blue",ylim=c(0,30))
legend("topright",c("Sub metering 1","Sub metering 2","Sub metering 3"),pch=c(NA,NA,NA),col=c("black","red","blue"),lty=c(1,1,1))

#Plot4 - Global reactive power consumption time-series...
plot(hpc$DateTime,hpc$Global_reactive_power,type="l",ylab="Global Reactive Power (kilowatts)",xlab="")

dev.off()