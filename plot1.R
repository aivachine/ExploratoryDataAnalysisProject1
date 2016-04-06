##########################################################
# Coursera Exploratory Data Analysis Project 1
# 03/04/2016
# plot1.R
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


### Building and saving the plot ###

# Generate the histogram of the given data values
hist(data$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# Saving to file
dev.copy(png, file=paste(dataDir,"/","plot1.png",sep=""), height=480, width=480)

# Close the png file device
print("Current open device is:")
dev.off()

cat("File 'Plot1.png' was saved to", dataDir)

# Remove ALL objects and clearing memory
#rm(list=ls()) 

