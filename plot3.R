## Project 1
## Plot 3
## 
## Contains the code that produces plot 3 of the project.
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

##Only keep columns for plot
data<- select(data,Sub_metering_1,Sub_metering_2,Sub_metering_3,datetime)


##-----------------------------------
##
##     Plotting the Data
##
##-----------------------------------
png()
dev.copy(png, file= "plot3.png")

plot(data$datetime,data$Sub_metering_1,type="l",col="black", ylab="Energy Sub Metering", xlab="")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")

legend("topright", legend = colnames(data)[1:3], lty=c(1,1), col=c("black","red","blue"))

dev.off()
