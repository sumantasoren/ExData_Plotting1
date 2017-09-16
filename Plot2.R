# read the file
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# create a subset
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# convert Global_active_power to numeric
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))

# create a datetime column from Date and Time
subpower$datetime <- strptime(paste(subpower$Date, subpower$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# create a plot Global Active Power VS dateime
plot(subpower$datetime, subpower$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# add a title
title(main="Global Active Power Vs Time")

# Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
