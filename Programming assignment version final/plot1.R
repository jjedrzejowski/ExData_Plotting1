## plot1.R
##
## this script reads data from file and prepares it for plotting
## then it plots a histogram of variable Global_active_power into "plot1.png" file
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
## open up device
png(filename="plot1.png", width=480, height=480)
## plot a histogram
hist(data4plot$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency",col="red")
## close device
dev.off()

