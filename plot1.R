##Estimate memory requirements
## Since the file is 2,075,259 rows and 9 columns
## 2075259 * 9 * 8 bytes = 149,418,648 bytes, i.e 149.42 MB
##Read data
data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
##Adjust column classes. Date as a date object, Time as POSIXlt
data$Date<-as.Date(data$Date, format=("%d/%m/%Y"))
data$Time<-strptime(data$Time, format=("%H:%M:%S"))
##Subset Data to read only data from 2007-02-01 to 2007-02-02
data<-subset(data, data$Date=="2007-02-01"|data$Date=="2007-02-02")

##We open a png graphic device with the specified requirements
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
## And then we plot the histogram
hist(data$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()