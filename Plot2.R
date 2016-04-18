# This program inputs Household Power Consumption data (if necessary), filters
# it for Feb 1-2, 2007, and does a line plot of Global Active Power consumption
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
png(filename="~/GitHub/Exploratory Data Analysis/Plot2.png", height=480, width=480, bg="white")

plot(hpc$DateTime,hpc$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

dev.off()