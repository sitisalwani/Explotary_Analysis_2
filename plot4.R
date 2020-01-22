
# Question 4 : Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?

# Subset coal combustion related NEI data
combustion_related <- grepl("comb", Source_Classification_Code$SCC.Level.One, ignore.case=TRUE)
coal_related <- grepl("coal", Source_Classification_Code$SCC.Level.Four, ignore.case=TRUE) 
coal_combustion <- (combustion_related & coal_related)
combustion_Source_Classification_Code <- Source_Classification_Code[coal_combustion,]$SCC
combustion_summarySCC_PM25 <- summarySCC_PM25[summarySCC_PM25$SCC %in% combustion_Source_Classification_Code,]

# Note: The SCC levels go from generic to specific. We assume that coal combustion related Source_Classification_Code records are those 
# where SCC.Level.One contains the subctring 'comb' and SCC.Level.Four contains the substring 'coal'.

library(ggplot2)

emission_changed_coal <- ggplot(combustion_summarySCC_PM25,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(emission_changed_coal)
dev.copy(png,'plot4.png')
dev.off()