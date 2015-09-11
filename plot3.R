# Plot 3 - Energy sub metering by date
# ASSUMPTION: household_power_consumtion.txt has been downloaded
#             from the specified URL and it resides in a subfolder
#             called *data*
# The script will execute if you simply source('plot3.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot3.run=F)`, which will disable the
# automatic running of the functions


# plot the Global_active_power as a histogram to outFile
# set outFile to NA to plot to screen instead

plot3 <- function(data, outFile = 'plot3.png') {
    # setting mfrow to ensure that if you run this after plot4
    # it doesn't display in a 2x2 grid
    par(mfrow=c(1,1))
    # from the forums - dev.copy at the end seems to truncate the legend
    # opening the device here first, plotting, then closing seems to do the trick
    if (!is.na(outFile)) {
        # dev.copy(png, file = outFile)
        png(filename = outFile)
    }
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
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
        col = c('black', 'red', 'blue'),
        lty = 1
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

# set `options(plot3.run=T, plot3.test=T)` to run with a smaller test data
conditionalRun(plot3, optionPrefix = 'plot3')