## Project 1
## Plot 1
## 
## Contains the code that produces plot 1 of the project.
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

##Only keep columns for plot
data<- select(data,Global_active_power)


##-----------------------------------
##
##     Plotting the Data
##
##-----------------------------------
png()
dev.copy(png, file= "plot1.png")

hist(data$Global_active_power, col="red", main= "Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()
