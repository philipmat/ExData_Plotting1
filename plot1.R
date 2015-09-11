# Plot 1 - Global active power

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

if (getOption('plot1.test', default=F)) {
    dfile <- './data/short_power.txt'
    powdata <- readData(dfile, date.subset = c('1/2/2007', '2/2/2007'))
    print(summary(powdata))
    plotData(powdata, outFile = NA)
}
if (getOption('plot1.run', default=T)) {
    dfile <- './data/short_power.txt'
    powdata <- readData(dfile)
    plotData(powdata, outFile = NA)
    ## print(summary(powdata))
}
