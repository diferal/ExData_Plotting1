# Program assumes that current working directory is the one, where "household_power_consumption.txt" file is saved.
# If it is not the case, change you working directory with setwd()

# Testing the presence of "household_power_consumption.txt" file in working directory
flag <- sum(dir() == "household_power_consumption.txt")
if (flag<1) {print("Data file household_power_consumption.txt hasn't been found in your working directory.")
             print("Please, set your working directory accordingly")}

# Reading data
whole.data <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", header = TRUE) # load data assuming you have enough memory
# Selecting subset of data from 1/2/2007 to 2/2/2007 
ind1 <- min(which((whole.data$Date == '1/2/2007') == TRUE))
ind2 <- max(which((whole.data$Date == '2/2/2007') == TRUE))
data <- whole.data[ind1:ind2,]
rm(whole.data) # remove redundant data from workspace in order to save space in memory
data[,3:9] <- sapply(data[,3:9], as.numeric) # convert columns 3:9 to numerical format

# create plot3.png
png(filename = "plot3.png", width = 480, height = 480) # if one wants to create figure on a screen, (s)he need to comment this line
x <- paste(data$Date, data$Time)
datetime <- strptime(x, "%d/%m/%Y %H:%M:%S") # convert date/time to POSIXlt format
plot(datetime, data$Sub_metering_1, type ='n', xlab = "", ylab = "Energy sub metering")
points(datetime, data$Sub_metering_1, type ='l')
points(datetime, data$Sub_metering_2, type ='l', col = 'red')
points(datetime, data$Sub_metering_3, type ='l', col = 'blue')
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty = c(1,1,1), col = c('black','red','blue'))
dev.off()