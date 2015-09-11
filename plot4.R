# Plot 4 - 4 plots: Global Active Power, Voltage, submetering and reactive power
# ASSUMPTION: household_power_consumtion.txt has been downloaded
#             from the specified URL and it resides in a subfolder
#             called *data*
# The script will execute if you simply source('plot4.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot4.run=F)`, which will disable the
# automatic running of the functions

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


# since the data reading code is common to all functions,
# I've put it in a file that is called by all 4 plotX.R files
source('dataRunner.R')

# set `options(plot4.run=T, plot4.test=T)` to run with a smaller test data
conditionalRun(plot4, optionPrefix = 'plot4')

