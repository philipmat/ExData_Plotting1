# Plot 1 - Global active power
# ASSUMPTION: household_power_consumtion.txt has been downloaded
#             from the specified URL and it resides in a subfolder
#             called *data*
# The script will execute if you simply source('plot1.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot1.run=F)`, which will disable the
# automatic running of the functions

# plot the Global_active_power as a histogram to outFile
# set outFile to NA to plot to screen instead

plot1 <- function(data, outFile = 'plot1.png') {
    # setting mfrow to ensure that if you run this after plot4
    # it doesn't display in a 2x2 grid
    par(mfrow=c(1,1))
    hist(
        data$Global_active_power,
        col = 'red',
        main = 'Global Active Power',
        xlab = 'Global Active Power (kilowatts)',
        ylab = 'Frequency'
    )
    if (!is.na(outFile)) {
        dev.copy(png, file = outFile)
        dev.off()
    }
}

# since the data reading code is common to all functions,
# I've put it in a file that is called by all 4 plotX.R files
source('dataRunner.R')

# set `options(plot1.run=T, plot1.test=T)` to run with a smaller test data
conditionalRun(plot1, optionPrefix = 'plot1')