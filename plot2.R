
# Questions 2 : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

baltimore_summarySCC_PM25 <- summarySCC_PM25[summarySCC_PM25$fips=="24510",]
aggregate_total_baltimore <- aggregate(Emissions ~ year, baltimore_summarySCC_PM25,sum)

barplot(
  aggregate_total_baltimore$Emissions,
  names.arg=aggregate_total_baltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From All Baltimore City Sources"
)
dev.copy(png,'plot2.png')
dev.off()
