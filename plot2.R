# Load necessary library
library(dplyr)

# Load the data
data <- readRDS("summarySCC_PM25.rds")

# Filter for Baltimore City and summarize emissions
emi_balt <- data %>% filter(fips == "24510") %>% group_by(year) %>%
  summarise(total = sum(Emissions))

# Save plot as PNG
png("plot2.png", width = 800, height = 600)

# Base plot
barplot(emi_balt$total, 
        main = "PM2.5 Emissions in Baltimore City (1999-2008)", 
        xlab = "Year", ylab = "PM2.5 Emissions (Tons)", 
        names.arg = emi_balt$year, col = "red", ylim = c(0, 3600))

# Close the device
dev.off()
