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
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
plot(data$Date,data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab=NA)
dev.off()