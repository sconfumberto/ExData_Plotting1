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

#converts sub 1 and sub 2 to numeric
data_filtered <- data_filtered %>%
  mutate (Sub_metering_1 = as.numeric (Sub_metering_1))

data_filtered <- data_filtered %>%
  mutate (Sub_metering_2 = as.numeric (Sub_metering_2))

png("plot3.png", width=480, height=480)

# plot 3
ggplot(data_filtered, aes(x = datetime, y = Sub_metering_1)) +
  geom_line(aes(y = Sub_metering_1, color = "Sub_metering_1")) +
  geom_line(aes(y = Sub_metering_2, color = "Sub_metering_2")) +
  geom_line(aes(y = Sub_metering_3, color = "Sub_metering_3")) +
  scale_x_datetime(breaks = "1 day", date_labels = "%a") +
  scale_color_manual(name = "Variables", 
                     values = c("Sub_metering_1" = "black", 
                                "Sub_metering_2" = "red", 
                                "Sub_metering_3" = "blue")) +
  labs(x = "Datetime", y = "Energy sub metering", color = "Variables")

dev.off()
