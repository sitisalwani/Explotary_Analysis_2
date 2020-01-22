
# Question 6 : Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips=="06037"). Which city has seen greater changes over time in 
# motor vehicle emissions?

# Comparing emissions from motor vehicle sources in Baltimore City (fips=="24510") with emissions from motor 
# vehicle sources in Los Angeles County, California (fips=="06037")

library(dplyr)

vehicles_Source_Classification_Code <- Source_Classification_Code %>% 
  filter(grepl('[Vv]ehicle', SCC.Level.Two)) %>%
  select(SCC, SCC.Level.Two)

total_emission_two_location <- summarySCC_PM25 %>%
  filter(fips == "24510" | fips == "06037") %>%
  select(fips, SCC, Emissions, year) %>%
  inner_join(vehicles_Source_Classification_Code, by = "SCC") %>%
  group_by(fips, year) %>%
  summarise(Total_Emissions = sum(Emissions, na.rm = TRUE)) %>%
  select(Total_Emissions, fips, year)


total_emission_two_location$fips <- gsub("24510", "Baltimore City", total_emission_two_location$fips)
total_emission_two_location$fips <- gsub("06037", "Los Angeles County", total_emission_two_location$fips)


plotting_two_location <- ggplot(total_emission_two_location, aes(x = factor(year), y = Total_Emissions, fill = fips)) +
  geom_bar(stat = "identity", fill = "dimgray", width = 0.7) +
  facet_grid(.~fips) + 
  labs(x = "Year", y = "Emissions (Tons)", title = "Comparison of Motor Vehicle Related Emissions Between Baltimore City and Los Angeles From 1999 - 2008") +
  theme(plot.title = element_text(size = 14),
        axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12),
        strip.text.x = element_text(size = 12)) +
  theme_minimal() + 
  ggsave("plot6.png", width = 30, height = 30, units = "cm")

print(plotting_two_location)