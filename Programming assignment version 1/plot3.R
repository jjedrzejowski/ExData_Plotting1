## this script reads data from file and prepares it for plotting
## then it plots three Sub_metering variables against time, into "plot3.png" file
##
## Read in the data - only two days, from 1/2/2007 until 2/2/2007
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
png(filename="plot3.png", width=480, height=480)
## plot Sub_metering_1 over time, then add two more variables, in different colors
plot(data4plot$Date_Time, data4plot$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(data4plot$Date_Time,data4plot$Sub_metering_2, type="l", col="red")
points(data4plot$Date_Time,data4plot$Sub_metering_3, type="l", col="blue")
## add appropriately formatted legend
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
## close device
dev.off()