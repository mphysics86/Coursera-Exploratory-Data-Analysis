## Project 1
## Plot 4
## 
## Contains the code that produces plot 2 of the project.
##


##-------------------------------
##
##     Reading the Data
##
##--------------------------------

library(dplyr)
## read data into "data" variable, reads '?' as "NA"
data<- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE, na.strings="?")
data<- tbl_df(data)

## only include data between 2/1/2007 and 2/2/2007
data<- filter(data,Date == "1/2/2007" | Date == "2/2/2007")


##------------------------------------
##
## Cleaning Data for the plot
##
##----------------------------------------


## Combine date and time data into one column called "datetime"
data<- mutate(data, datetime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))


##-----------------------------------
##
##     Plotting the Data
##
##-----------------------------------
png()
dev.copy(png, file= "plot4.png")
par(mfrow= c(2,2))

##Panel 11
plot(data$datetime,data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")



## Panel 21
plot(data$datetime,data$Voltage,type="l", 
     ylab="Voltage", xlab="datetime")


## Panel 12
plot(data$datetime,data$Sub_metering_1,type="l",col="black", ylab="Energy Sub Metering", xlab="")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1), col=c("black","red","blue"),bty = "n", cex= 0.75)


## Panel 22

plot(data$datetime, data$Global_reactive_power, type="l",
     ylab="Global_active_power",xlab="datetime")

dev.off()
