#
# Exploratory Data Analysis, Project 2
#
#   Code for Plot 3
#---------------------------------------------


#----------------------
#
# Reading the data
#
#-----------------------

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI<- tbl_df(NEI)


#---------------------------
#
#  Preparing/Cleaning the data
#
#---------------------------

## Filter data for Baltimore city data (fips == "24510"), then select Emissions, year and type columns.
## Group by type, then year; find the total emissions for each group.
NEI<- filter(NEI, fips == "24510") %>% select(Emissions, year, type) %>% 
      group_by(type,year) %>% summarise(total.em = sum(Emissions))



#--------------------------------
#
#   Plotting the Data
#
#---------------------------------

##Plots data in a scatter plot and adds a linear trend line using "geom_smooth" to show the general trend
## for each type.

dev.copy(png, file= "plot3.png")

ggplot(NEI, aes(year,total.em, group = type)) + 
      geom_point(size = 5,aes(color = type)) + 
      xlab("Year")+ ylab("Total Emissions in Tons") + ggtitle("Total Emissions per Year For Baltimore City by Type") +
      geom_smooth(method = "lm",se = FALSE,size = 1, aes(color = type))

dev.off()