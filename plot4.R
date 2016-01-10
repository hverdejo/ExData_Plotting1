##Estimate memory requirements
## Since the file is 2,075,259 rows and 9 columns
## 2075259 * 9 * 8 bytes = 149,418,648 bytes, i.e 149.42 MB
##Read data
data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
##Adjust column classes
data$Date<-as.Date(data$Date, format=("%d/%m/%Y"))
##Subset Data to read only data from 2007-02-01 to 2007-02-02
data<-subset(data, data$Date=="2007-02-01 00:01:00"|data$Date=="2007-02-02 23:59:00")
## Paste "Date" and "Time" data in one POSIXlt object
data$Date<-paste(data$Date, data$Time)
data$Date<-strptime(data$Date, format=("%Y-%m-%d %H:%M:%S"))

##We open a png graphic device with the specified requirements
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")


##We set the lattice parameters. We use mfcol insted of mfrow
##to fill the lattice by columns
par(mfcol=c(2,2))

## We plot the first graph, simmilar to the one required on plot2.R
plot(data$Date,data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab=NA)

## We plot the second graph, similar to the one required on plot3.R
yrange<-range(c(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3))
## We plot the first graph and then add the other series 
plot(data$Date,data$Sub_metering_1, type="l", ylim=yrange, ylab="Energy sub metering", xlab=NA)
lines(data$Date,data$Sub_metering_2, col="red")
lines(data$Date,data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1 , col=c("black","red","blue"))

## We plot Voltaje against Date
plot(data$Date,data$Voltage, type="l", ylab="Voltage", xlab="datetime")

## We plot Global Reactive Power against Date
plot(data$Date, data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()