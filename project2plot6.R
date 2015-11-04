#
# Exploratory Data Analysis, Project 2
#
#   Code for Plot 6
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

SCC <- readRDS("Source_Classification_Code.rds")
SCC <- tbl_df(SCC)


#---------------------------
#
#  Preparing/Cleaning the data
#
#---------------------------

## Filter data for Baltimore city data (fips == "24510"), then select Emissions, type and year columns.
## Filter this result for "ON-ROAD" types only, and keep only the Emissions and year columns.
## Group this result by year, and find the sum of emissions for each year. 


bc.data <- filter(NEI, fips == "24510") %>% select(SCC, Emissions, type, year) %>% 
      filter(type =="ON-ROAD") %>% select(Emissions, year) %>% group_by(year) %>% 
      summarise(total.em = sum(Emissions))

## Add a column for a factor variable that represents the city/county
bc.data<- mutate(bc.data, city = as.factor(rep("bc",nrow(bc.data))))

## Repeat the above for Los Angeles County (fips == "06037")
la.data <- filter(NEI, fips == "06037") %>% select(SCC, Emissions, type, year) %>% 
      filter(type =="ON-ROAD") %>% select(Emissions, year) %>% group_by(year) %>% 
      summarise(total.em = sum(Emissions))

la.data<- mutate(la.data, city = as.factor(rep("la",nrow(la.data))))

data<- rbind(bc.data,la.data)


#--------------------------------
#
#   Plotting the Data
#
#---------------------------------

## Data is plotted using a scatter plot. A linear trend is added to compare the overal emissions trend
## of each city.

dev.copy(png, file= "plot6.png")

ggplot(data, aes(year,total.em, group = city)) + 
      geom_point(size = 5,aes(color = factor(city, labels=c("Baltimore City","Los Angeles")))) + 
      xlab("Year")+ ylab("Total Emissions in Thousands of Tons") + ggtitle("Baltimore City vs. Los Angeles Emissions by Year") +
      geom_smooth(method = "lm",se = FALSE,size = 1, aes(color = factor(city, labels=c("Baltimore City","Los Angeles"))))+
      labs(color = "City")
      

dev.off()