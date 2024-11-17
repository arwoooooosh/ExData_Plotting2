# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the data
data <- readRDS("summarySCC_PM25.rds")

# Filter and group data by source type
emi_balt_t <- data %>% filter(fips == "24510") %>% group_by(type, year) %>%
  summarise(total = sum(Emissions))

# Save plot as PNG
png("plot3.png", width = 800, height = 600)

# ggplot visualization
ggplot(emi_balt_t, aes(factor(year), total, fill = type)) + 
  geom_bar(stat = "identity") + facet_wrap(~type) +
  ggtitle("PM2.5 Emissions by Source Type in Baltimore City (1999-2008)") +
  xlab("Year") + ylab("PM2.5 Emissions (Tons)") + 
  theme_minimal()

# Close the device
dev.off()
