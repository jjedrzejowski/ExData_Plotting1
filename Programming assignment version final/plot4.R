## plot4.R
##
## this script reads data from file and prepares it for plotting
## then it creates four plots and saves them in "plot4.png" file
##
## Read in the data - only two days, from 1/2/2007 until 2/2/2007
## Date and time are read in as characters - leaving default settings for read.table
## causes their conversion to factor type.

household <- read.table(file=unz("exdata-data-household_power_consumption.zip", 
                                 "household_power_consumption.txt"), header=FALSE, sep=";",
                        na.strings="?", colClasses=c("character", "character", "numeric",
                                                     "numeric", "numeric", "numeric", 
                                                     "numeric", "numeric", "numeric"),
                        col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power",
                                    "Voltage", "Global_intensity", "Sub_metering_1", 
                                    "Sub_metering_2", "Sub_metering_3"),
                        skip=66637, nrows=2880)
## manipulate the data, to get the first two columns in a proper date/time class
Temp <- paste(household$Date, household$Time, sep=" ")
Date_Time <- strptime(Temp, format="%d/%m/%Y %H:%M:%S")
## make dataframe with data for plotting
data4plot <- cbind(Date_Time, household[,3:9])
## open up png device
png(filename="plot4.png", width=480, height=480)
## prepare canvas for four plots
par(mfrow=c(2,2))
## plot Global_active_power over time in top right corner
plot(data4plot$Date_Time, data4plot$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")
## plot Voltage over time in top left corner
plot(data4plot$Date_Time, data4plot$Voltage, type="l", xlab="datetime", ylab="Voltage")
## in bottom left corner, plot Sub_metering_1 over time, then add two more variables, in different colors
plot(data4plot$Date_Time, data4plot$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(data4plot$Date_Time, data4plot$Sub_metering_2, type="l", col="red")
points(data4plot$Date_Time, data4plot$Sub_metering_3, type="l", col="blue")
## add appropriately formatted legend
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty="n", lty=c(1,1,1), col=c("black", "red", "blue"))
## in the bottom right corner, plot Global_reactive_power over time
plot(data4plot$Date_Time, data4plot$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")
## close device
dev.off()