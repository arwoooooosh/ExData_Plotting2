# Load necessary library
library(dplyr)

# Load the data
data <- readRDS("summarySCC_PM25.rds")

# Summarize total emissions by year
emi_year <- data %>% group_by(year) %>% summarise(total = sum(Emissions))

# Save plot as PNG
png("plot1.png", width = 800, height = 600)

# Base plot
barplot(emi_year$total / 1000, 
        main = "Total PM2.5 Emissions in the US (1999-2008)", 
        xlab = "Year", ylab = "PM2.5 Emissions (Kilotons)", 
        names.arg = emi_year$year, col = "blue", ylim = c(0, 8300))

# Close the device
dev.off()
