# Plot 2 - Global Active Power by Date
# ASSUMPTION: household_power_consumtion.txt has been downloaded
#             from the specified URL and it resides in a subfolder
#             called *data*
# The script will execute if you simply source('plot2.R')
# if you want to use it as a module (for example see README.Rmd)
# first set `options(plot2.run=F)`, which will disable the
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

plot2 <- function(data, outFile = 'plot2.png') {
    plot(
        x = data$DateTime,
        y = data$Global_active_power,
        type = "l",
        xlab = '',
        ylab = 'Global Active Power (kilowatts)',
    )
    if (!is.na(outFile)) {
        dev.copy(png, file = outFile)
        dev.off()
    }
}

if (getOption('plot2.run', default=T)) {
    dfile <- './data/household_power_consumption.txt'
    outFile <- 'plot2.png'
    isTest <- getOption('plot2.test', default=F)
    if (isTest) {
        dfile <- './data/short_power.txt' # short_power is a smaller version
        outFile <- NA  # NA = plot to screen
    }

    powdata <- readData(dfile, date.subset = c('1/2/2007', '2/2/2007'))
    plot2(powdata, outFile = outFile)
    if (isTest) { print(summary(powdata)) }
}
