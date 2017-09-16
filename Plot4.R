# read the file
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# create a subset
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# convert Global_active_power to numeric
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))

# convert the Sub_metering_1, Sub_metering_2, Sub_metering_3 to numeric
subpower$Sub_metering_1 <- as.numeric(as.character(subpower$Sub_metering_1))
subpower$Sub_metering_2 <- as.numeric(as.character(subpower$Sub_metering_2))
subpower$Sub_metering_3 <- as.numeric(as.character(subpower$Sub_metering_3))

# convert Voltage to numeric
subpower$Voltage <- as.numeric(as.character(subpower$Voltage))

# convert Global_reactive_power to numeric
subpower$Global_reactive_power <- as.numeric(as.character(subpower$Global_reactive_power))

# create a datetime column from Date and Time
subpower$datetime <- strptime(paste(subpower$Date, subpower$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# set graph parameters
par(mfrow=c(2,2))

# create plots
with(subpower, {
# 1
  plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
# 2
  plot(datetime, Voltage, type ="l", xlab = "datetime", ylab = "Voltage")
# 3
  plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  with(subpower, lines(datetime, Sub_metering_1))
  with(subpower, lines(datetime, Sub_metering_2, col = "red"))
  with(subpower, lines(datetime, Sub_metering_3, col = "blue"))
  legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 4
  plot(datetime, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
})


# Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
