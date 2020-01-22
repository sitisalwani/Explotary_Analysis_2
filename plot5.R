
# Question 5 : How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


library(dplyr)
vehicle_Source_Classification_Code <- Source_Classification_Code %>%
  filter(grepl('[Vv]ehicle', SCC.Level.Two)) %>%
  select(SCC, SCC.Level.Two)

total_emission_24510_vehicle <- summarySCC_PM25 %>%
  filter(fips == "24510") %>%
  select(SCC, fips, Emissions, year) %>%
  inner_join(vehicle_Source_Classification_Code, by = "SCC") %>%
  group_by(year) %>%
  summarise(Total_Emissions = sum(Emissions, na.rm = TRUE)) %>%
  select(Total_Emissions, year)



baltimore_vehicle_plot <- ggplot(total_emission_24510_vehicle, aes(factor(year), Total_Emissions)) +
  geom_bar(stat = "identity", fill = "dimgray", width = 0.4) +
  labs(x = "Year", y = "Emissions (Tons)", title = "Total Motor Vehicle Related Emissions In Baltimore City From 1999 - 2008") +
  theme(plot.title = element_text(size = 12),
        axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12)) +
  ggsave("plot5.png", width = 30, height = 30, units = "cm")

print(baltimore_vehicle_plot)
dev.copy(png,'plot5.png')
dev.off()

