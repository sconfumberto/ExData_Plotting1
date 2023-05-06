library (dplyr)
library (ggplot2)
library (data.table)
library (gridExtra)

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

#converts "global reactive power" to numeric
data_filtered <- data_filtered %>%
  mutate (Global_reactive_power = as.numeric (Global_reactive_power))

#converts sub 1 and sub 2 to numeric
data_filtered <- data_filtered %>%
  mutate (Sub_metering_1 = as.numeric (Sub_metering_1))

data_filtered <- data_filtered %>%
  mutate (Sub_metering_2 = as.numeric (Sub_metering_2))

#converts voltage to numeric
data_filtered <- data_filtered %>%
  mutate (Voltage = as.numeric (Voltage))

png("plot4.png", width=480, height=480)

#mini-plot 1
p1 <- ggplot (data_filtered, aes (x = datetime, y= Global_active_power)) +
  geom_line () +
  scale_x_datetime(breaks = "1 day", date_labels = "%a")

#mini-plot 2
p2 <- ggplot (data_filtered, aes (x = datetime, y= Voltage)) +
  geom_line () +
  scale_x_datetime(breaks = "1 day", date_labels = "%a")

#mini-plot 3
p3 <- ggplot(data_filtered, aes(x = datetime, y = Sub_metering_1)) +
  geom_line(aes(y = Sub_metering_1, color = "Sub_metering_1")) +
  geom_line(aes(y = Sub_metering_2, color = "Sub_metering_2")) +
  geom_line(aes(y = Sub_metering_3, color = "Sub_metering_3")) +
  scale_x_datetime(breaks = "1 day", date_labels = "%a") +
  scale_color_manual(name = "Variables", 
                     values = c("Sub_metering_1" = "black", 
                                "Sub_metering_2" = "red", 
                                "Sub_metering_3" = "blue")) +
  labs(x = "Datetime", y = "Energy sub metering", color = "Variables")

#mini-plot 4
p4 <- ggplot (data_filtered, aes (x = datetime, y= Global_reactive_power)) +
  geom_line () +
  scale_x_datetime(breaks = "1 day", date_labels = "%a")

#combines the 4 mini-plots
grid.arrange(p1, p2, p3, p4, ncol = 2)

dev.off()