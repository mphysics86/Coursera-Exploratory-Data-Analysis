## Project 1
## Plot 2
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

##Only keep columns for plot
data<- select(data,Global_active_power,datetime)


##-----------------------------------
##
##     Plotting the Data
##
##-----------------------------------
png()
dev.copy(png, file= "plot2.png")

plot(data$datetime,data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")


dev.off()




