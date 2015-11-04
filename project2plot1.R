#
# Exploratory Data Analysis, Project 2
#
#   Code for Plot 1
#---------------------------------------------


#----------------------
#
# Reading the data
#
#-----------------------

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
NEI<- tbl_df(NEI)


#---------------------------
#
#  Preparing/Cleaning the data
#
#---------------------------

## Only keep emissions and year
NEI <- select(NEI,Emissions,year)

##Groups data by year and finds the total emissions for each year
## Divide by 1,000,000 to convert emissions to millions of tons


total.em <- group_by(NEI,year) %>% summarise(total.em = sum(Emissions)/1000000)

#--------------------------------
#
#   Plotting the Data
#
#---------------------------------

dev.copy(png, file= "plot1.png")

barplot(total.em$total.em, names.arg = total.em$year, ylim = c(0,8), 
        main = "Total PM2.5 Emissions by Year", xlab = "Year", 
        ylab = "PM2.5 Emissions in millions of tons", col = "green3")

dev.off()