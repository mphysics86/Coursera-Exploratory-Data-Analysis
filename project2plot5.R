#
# Exploratory Data Analysis, Project 2
#
#   Code for Plot 5
#---------------------------------------------


#----------------------
#
# Reading the data
#
#-----------------------

library(dplyr)

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
data <- filter(NEI, fips == "24510") %>% select(SCC, Emissions, type, year) %>% 
      filter(type =="ON-ROAD") %>% select(Emissions, year) %>% group_by(year) %>% 
      summarise(total.em = sum(Emissions))


#--------------------------------
#
#   Plotting the Data
#
#---------------------------------

dev.copy(png, file= "plot5.png")

barplot(data$total.em, names.arg = data$year, ylim = c(0,350), 
        main = "Baltimore City Motor Vehicle Emissions by Year", xlab = "Year", 
        ylab = "Motor Vehicle Emissions in tons", col = "green3")

dev.off()