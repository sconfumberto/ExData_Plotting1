library (dplyr)
library (ggplot2)
library (data.table)

# reads the file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# filters for the two days required
data_filtered <- data %>%
  filter (Date %in% c("1/2/2007", "2/2/2007"))

# creates a "datetime" column which can be used for the plot
datetime <- paste(data_filtered$Date, data_filtered$Time)

datetime <- as.POSIXct(datetime, format = "%d/%m/%Y %H:%M:%S")

data_filtered$datetime <- datetime

#converts "global active power" to numeric
data_filtered <- data_filtered %>%
  mutate (Global_active_power = as.numeric (Global_active_power))

png("plot2.png", width=480, height=480)

#plot 2
ggplot (data_filtered, aes (x = datetime, y= Global_active_power)) +
  geom_line () +
  scale_x_datetime(breaks = "1 day", date_labels = "%a")

dev.off()