# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the data
data <- readRDS("summarySCC_PM25.rds")
data_ssc <- readRDS("Source_Classification_Code.rds")

# Filter motor vehicle sources for Baltimore and LA
motor_scc <- data_ssc[grep("Vehicle", data_ssc$EI.Sector), "SCC"]
motor_emi <- data[data$SCC %in% motor_scc & data$fips %in% c("24510", "06037"), ] %>% 
  group_by(fips, year) %>% summarise(total = sum(Emissions))

# Add city labels
motor_emi$fips <- factor(motor_emi$fips, levels = c("24510", "06037"), labels = c("Baltimore", "Los Angeles"))

# Save plot as PNG
png("plot6.png", width = 800, height = 600)

# ggplot visualization
ggplot(motor_emi, aes(factor(year), total, fill = fips)) + 
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Motor Vehicle PM2.5 Emissions: Baltimore vs. LA (1999-2008)") +
  xlab("Year") + ylab("PM2.5 Emissions (Tons)") + 
  theme_minimal()

# Close the device
dev.off()
