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


# runs the given function based on an option
# options(plot4.run=T, plot4.test=T)
# conditionalRun(plot4, 'plot4')
conditionalRun <- function(plotFunction, optionPrefix) {
    opt.run = paste(optionPrefix, 'run', sep = '.')
    opt.test = paste(optionPrefix, 'test', sep = '.')
    opt.file = paste(optionPrefix, 'png', sep = '.')
    if (getOption(opt.run, default=T)) {
        dfile <- './data/household_power_consumption.txt'
        outFile <- opt.file
        isTest <- getOption(opt.test, default=F)
        if (isTest) {
            dfile <- './data/short_power.txt' # short_power is a smaller version
            outFile <- NA  # NA = plot to screen
        }

        powdata <- readData(dfile, date.subset = c('1/2/2007', '2/2/2007'))
        plotFunction(powdata, outFile = outFile)
        # if (isTest) { print(summary(powdata)) }
    }
}