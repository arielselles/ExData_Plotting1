## plot2
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

png("plot2.png", width = 480, height = 480, units = "px")

plot(hpcDs2Days$timestamp,
    hpcDs2Days$Global_active_power,
    type = "l",
    col = "black",
    xlab = "",
    ylab = "Global Active Power (kilowats)"
)

dev.off()
