# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the data
data <- readRDS("summarySCC_PM25.rds")
data_ssc <- readRDS("Source_Classification_Code.rds")

# Filter coal combustion-related sources
coal_scc <- data_ssc[grep("Coal", data_ssc$EI.Sector), "SCC"]
coal_emi <- data[data$SCC %in% coal_scc, ] %>% group_by(year) %>% summarise(total = sum(Emissions))

# Save plot as PNG
png("plot4.png", width = 800, height = 600)

# ggplot visualization
ggplot(coal_emi, aes(factor(year), total / 1000)) + 
  geom_bar(stat = "identity", fill = "brown") +
  ggtitle("Coal Combustion PM2.5 Emissions in the US (1999-2008)") +
  xlab("Year") + ylab("PM2.5 Emissions (Kilotons)") + 
  theme_minimal()

# Close the device
dev.off()
