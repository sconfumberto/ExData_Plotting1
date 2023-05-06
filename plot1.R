library (dplyr)
library (ggplot2)

# reads the file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data_filtered <- data %>%
  filter (Date %in% c("1/2/2007", "2/2/2007"))

# converts the date as dates
data_filtered <- data_filtered %>%
  mutate (Date = as.Date (Date, format = "%d/%m/%Y"))

#converts "global active power" to numeric
data_filtered <- data_filtered %>%
  mutate (Global_active_power = as.numeric (Global_active_power))

png("plot1.png", width=480, height=480)

#plot 1
ggplot (data_filtered, aes (x = Global_active_power, fill = "red")) +
  geom_histogram (binwidth = 0.4) +
  labs (x = "Global active power (kilowatts)", y = "frequencies") +
  coord_cartesian(xlim = c(0, max(data_filtered$Global_active_power)))

dev.off()
