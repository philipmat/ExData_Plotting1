# Plot 2 - Global Active Power by Date
# ASSUMPTION: household_power_consumtion.txt has been downloaded
#             from the specified URL and it resides in a subfolder
#             called *data*
# The script will execute if you simply source('plot2.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot2.run=F)`, which will disable the
# automatic running of the functions


# plot the Global_active_power as a histogram to outFile
# set outFile to NA to plot to screen instead

plot2 <- function(data, outFile = 'plot2.png') {
    # setting mfrow to ensure that if you run this after plot4
    # it doesn't display in a 2x2 grid
    par(mfrow=c(1,1))
    plot(
        x = data$DateTime,
        y = data$Global_active_power,
        type = "l",
        xlab = '',
        ylab = 'Global Active Power (kilowatts)'
    )
    if (!is.na(outFile)) {
        dev.copy(png, file = outFile)
        dev.off()
    }
}

# since the data reading code is common to all functions,
# I've put it in a file that is called by all 4 plotX.R files
source('dataRunner.R')

# set `options(plot2.run=T, plot2.test=T)` to run with a smaller test data
conditionalRun(plot2, optionPrefix = 'plot2')