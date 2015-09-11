# Plot 1 - Global active power
# The script will execute if you simply source('plot1.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot1.run=F)`, which will disable the
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
    return(power.data)
}

# plot the Global_active_power as a histogram to outFile
# set outFile to NA to plot to screen instead

plotData <- function(data, outFile = 'plot1.png') {
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

if (getOption('plot1.run', default=T)) {
    dfile <- './data/household_power_consumption.txt'
    outFile <- 'plot1.png'
    isTest <- getOption('plot1.test', default=F)
    if (isTest) {
        dfile <- './data/short_power.txt' # short_power is a smaller version
        outFile <- NA  # NA = plot to screen
    }

    powdata <- readData(dfile, date.subset = c('1/2/2007', '2/2/2007'))
    plotData(powdata, outFile = outFile)
    if (isTest) { print(summary(powdata)) }
}
