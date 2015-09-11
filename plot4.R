# Plot 4 - 4 plots: Global Active Power, Voltage, submetering and reactive power
# ASSUMPTION: household_power_consumtion.txt has been downloaded
#             from the specified URL and it resides in a subfolder
#             called *data*
# The script will execute if you simply source('plot4.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot4.run=F)`, which will disable the
# automatic running of the functions

# reads data from a file, optionally subsetting it
# Eg: readData('data/power.txt', c('1/2/2007', '2/2/2007'))

readData <- function(fname, date.subset = NA) {
    if (!file.exists(fname)) {
        return(NA)
    }

    power.data <- read.table(fname, header = T, sep=";", na.strings = '?')
    if (!is.na(date.subset)) {
        power.data <- power.data[power.data$Date %in% date.subset, ]
    }
    # add a column that represents the Date + Time obtained from the two columns: Date and Time
    power.data$DateTime <- strptime(paste(power.data$Date, power.data$Time), format="%d/%m/%Y %T")
    return(power.data)
}

# plot the Global_active_power as a histogram to outFile
# set outFile to NA to plot to screen instead

plot4 <- function(data, outFile = 'plot4.png') {
    # from the forums - dev.copy at the end seems to truncate the legend
    # opening the device here first, plotting, then closing seems to do the trick
    if (!is.na(outFile)) {
        # dev.copy(png, file = outFile)
        png(filename = outFile)
    }
    par(mfrow = c(2,2))
    # 1 - Global Active Power / date
    plot(
        x = data$DateTime,
        y = data$Global_active_power,
        type = "l",
        xlab = '',
        ylab = 'Global Active Power'
    )
    # 2 - Voltage
    plot(
        x = data$DateTime,
        y = data$Voltage,
        type = "l",
        xlab = 'datetime',
        ylab = 'Voltage'
    )
    # 3 - Energy sub metering
    plot(
        x = data$DateTime,
        y = data$Sub_metering_1,
        type = "l",
        col = 'black',
        xlab = '',
        ylab = 'Energy sub metering',
        lty = 1
    )
    lines(x = data$DateTime, y = data$Sub_metering_2, col = 'red')
    lines(x = data$DateTime, y = data$Sub_metering_3, col = 'blue')
    legend(
        'topright',
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_4'),
        col = c('black', 'red', 'blue'),
        lty = 1,
        bty = 'n'  ## no box around the legend
    )

    # 4 - Global Reactive Power
    with(data,
        plot(
            x = DateTime,
            y = Global_reactive_power,
            type = "l",
            xlab = 'datetime'
        )
    )

    if (!is.na(outFile)) {
        # dev.copy(png, file = outFile)
        # png(filename = outFile)
        dev.off()
    }
}

if (getOption('plot4.run', default=T)) {
    dfile <- './data/household_power_consumption.txt'
    outFile <- 'plot4.png'
    isTest <- getOption('plot4.test', default=F)
    if (isTest) {
        dfile <- './data/short_power.txt' # short_power is a smaller version
        outFile <- NA  # NA = plot to screen
    }

    powdata <- readData(dfile, date.subset = c('1/2/2007', '2/2/2007'))
    plot4(powdata, outFile = outFile)
    if (isTest) { print(summary(powdata)) }
}
