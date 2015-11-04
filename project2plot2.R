#
# Exploratory Data Analysis, Project 2
#
#   Code for Plot 2
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

## Filter data for Baltimore city data (fips == "24510"), then select Emissions and year columns
NEI <- filter(NEI, fips == "24510") %>% select(Emissions, year)


##Groups data by year and finds the total emissions for each year
## Divide by 1,000 to convert emissions to thousands of tons
data <- group_by(NEI,year) %>% summarise(total.em = sum(Emissions)/1000)

#--------------------------------
#
#   Plotting the Data
#
#---------------------------------

##Plots total emissions each year for Baltimore City in a scatter plot.
## A trend line is added to show the overall emissions trend from 1998 to 2008

dev.copy(png, file= "plot2.png")

ggplot(data, aes(year,total.em)) + 
      geom_point(size = 5,color = "green3") + ylim(0,4)+      
      xlab("Year")+ ylab("Total Emissions in thousands of Tons") + ggtitle("Total Emissions per Year For Baltimore City") +
      geom_smooth(method = "lm",se = FALSE,size = 1, color = "green3")

dev.off()