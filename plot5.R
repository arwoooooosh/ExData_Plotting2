# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the data
data <- readRDS("summarySCC_PM25.rds")
data_ssc <- readRDS("Source_Classification_Code.rds")

# Filter motor vehicle sources
motor_scc <- data_ssc[grep("Vehicle", data_ssc$EI.Sector), "SCC"]
motor_emi <- data[data$SCC %in% motor_scc & data$fips == "24510", ] %>% 
  group_by(year) %>% summarise(total = sum(Emissions))

# Save plot as PNG
png("plot5.png", width = 800, height = 600)

# ggplot visualization
ggplot(motor_emi, aes(factor(year), total)) + 
  geom_bar(stat = "identity", fill = "green") +
  ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore City (1999-2008)") +
  xlab("Year") + ylab("PM2.5 Emissions (Tons)") + 
  theme_minimal()

# Close the device
dev.off()
