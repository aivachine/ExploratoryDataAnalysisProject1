##########################################################
# Coursera Exploratory Data Analysis Project 1
# Anton Ivachine
# 03/04/2016
# plot4.R
##########################################################

### Data Loading and Preprocessing ###

# Set working directory
# mentioned folder must be created firstly!
#setwd("C:/Users/ai/Documents/Courses/Exploratory Data Analysis/Course project")

# Set variables
dataDir <- "./data"
zipFile <- "./data/Dataset.zip"
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFile <- "./data/household_power_consumption.txt"

# Create /data directory if not exists download the archive
if(!file.exists(dataDir)){dir.create(dataDir)}

# Skips the download step if the archive is already downloaded and unzipped
if (!file.exists(dataFile)) {
  download.file(zipUrl, destfile = zipFile)
  unzip(zipFile, exdir=dataDir)
  file.remove(zipFile)
}

# Make sure your computer has enough memory to read this dataset (149581752 bytes)
# memory.limit(size = NA) # Windows only

# Reading the file
data <- read.table(dataFile, header=TRUE, sep=";", colClasses=c(rep("character",2), rep("numeric",7)), na.strings ="?")

# Subset the dataset. We will only be using data from the dates 2007-02-01 and 2007-02-02
data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Convert the variable 'Date' to data format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Join Date and Time
data$Datestamp <- strptime(paste(data$Date, data$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S")


### Building and saving the plot ###

# Open the graphics device for PNG format and generate the plot
png(file=paste(dataDir,"/","plot4.png",sep=""), height=480, width=480)

# Setting the matrix of 4 plots
par(mfcol = c(2, 2))

# Plot A
plot(data$Datestamp,data$Global_active_power,type = "l",xlab = "",ylab = "Global Active Power")

# Plot B
plot(data$Datestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$Datestamp,data$Sub_metering_2,col="red")
lines(data$Datestamp,data$Sub_metering_3,col="blue")
legend("topright", lwd=1.7, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

# Plot C
plot(data$Datestamp,data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot D
plot(data$Datestamp,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close the png file device
print("Current open device is:")
dev.off()

cat("File 'Plot4.png' was saved to", dataDir)

# Remove ALL objects and clearing memory
#rm(list=ls()) 

