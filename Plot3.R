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


# create a datetime column from Date and Time
subpower$datetime <- strptime(paste(subpower$Date, subpower$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# create a plot Energy Sub Meters VS dateime
plot(subpower$datetime, subpower$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
with(subpower, lines(datetime, Sub_metering_1))
with(subpower, lines(datetime, Sub_metering_2, col = "red"))
with(subpower, lines(datetime, Sub_metering_3, col = "blue"))

# create legends
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
