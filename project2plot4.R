#
# Exploratory Data Analysis, Project 2
#
#   Code for Plot 4
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

#Keep only the following columns from NEI: SCC, Emissions and year
data1 <- select(NEI, SCC, Emissions, year)

##Filter the SCC data, only keeping data with instances of both "Coal" AND "Comb" in the "Short.Name" variable.
data2<- filter(SCC, Short.Name %in% intersect(grep("Coal",SCC$Short.Name, value = T),grep("Comb", SCC$Short.Name, value = T)))

## Merges Data by matching SCC's from each dataset. Since data have been filtered with "Coal" and "Comb",
## only emissions from coal combustion related sources will be included.
## Then, only Emissions and year columns are kept; the data is then grouped by year, and the total emissions for each year
## are calculated in hunderd thousands of tons (divide by 100,000).

data<- merge(data1, data2) %>% select(Emissions,year) %>% group_by(year) %>% summarise(total.em = sum(Emissions)/100000)

#--------------------------------
#
#   Plotting the Data
#
#---------------------------------

dev.copy(png, file= "plot4.png")

barplot(data$total.em, names.arg = data$year, ylim = c(0,6), 
        main = "Total Coal Combustion-related \n Emissions by Year", xlab = "Year", 
        ylab = "Coal Comb. Emissions in hundred thousands of tons", col = "green3")

dev.off()