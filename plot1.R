
# Load 'summarySCC_PM25' and 'Source_Classification_Code' data frames from the .rds files
summarySCC_PM25 <- readRDS("summarySCC_PM25.rds")
Source_Classification_Code <- readRDS("Source_Classification_Code.rds")


# Answering question 1 :Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each 
# of the years 1999, 2002, 2005, and 2008.

aggregate_total <- aggregate(Emissions ~ year, summarySCC_PM25, sum)
barplot(
  (aggregate_total$Emissions)/10^6,
  names.arg=aggregate_total$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.copy(png,'plot1.png')
dev.off()

