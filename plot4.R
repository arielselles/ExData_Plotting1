## plot4
#
# Loads data for plotting (if needed), dates from Feb 1st 2007 to Feb 2nd 2007
#   both days included, and plots a plot-line of the Global Active Powder
#   variable.

# It's required that the origin data source is stored at the file disk system,
#   at the working directory.

# Data set is stored in hpcDs2Days

if (!exists("hpcDs2Days")) {
    hpcDs <- read.table(
        "household_power_consumption.txt",
        sep = ";",
        header = T,
        na.strings = "?",
        stringsAsFactors = F
    )
    
    hpcDs$timestamp <-
        strptime(paste(hpcDs$Date, hpcDs$Time), format = "%d/%m/%Y %H:%M:%S")
    
    
    hpcDs2Days <-
        subset(
            hpcDs,
            timestamp >= strptime("2007-02-01", format = "%Y-%m-%d") &
                timestamp < strptime("2007-02-03", format = "%Y-%m-%d")
        )
}

png("plot4.png", width = 480, height = 480, units = "px")

# A 2x2 dashboard
par(mfrow = c(2,2), 
    oma = c(0, 0, 0, 0),
    mar = c(2, 2.9, 2, 2),
    mgp = c(1.8, 0.5, 0))

# Top-left: Global Active Power
plot(hpcDs2Days$timestamp,
    hpcDs2Days$Global_active_power,
    type = "l",
    col = "black",
    xlab = "",
    ylab = "Global Active Power (kilowats)"
)

#Top-right: Voltage
plot(hpcDs2Days$timestamp,
     hpcDs2Days$Voltage,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Voltage"
)

#Bottom-left: Energy sub metering
plot(hpcDs2Days$timestamp,
     hpcDs2Days$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering"
)

points(hpcDs2Days$timestamp, hpcDs2Days$Sub_metering_1, type="l", col="black")
points(hpcDs2Days$timestamp, hpcDs2Days$Sub_metering_2, type="l", col="red")
points(hpcDs2Days$timestamp, hpcDs2Days$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=2, legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))


# Bottom-right: Global_reactive_power
plot(hpcDs2Days$timestamp,
     hpcDs2Days$Global_reactive_power,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Global_reactive_power"
)

dev.off()
