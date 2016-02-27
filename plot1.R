# Data loading
# This section of code would ideally be shared by all plots, however as per 
# assignment instructions is included in each of the files

# Read the file from csv, convert columns into correct data types on import
# with the exception of dates / times which we'll do later

d <- read.csv("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?",
              colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric",
                             "numeric", "numeric", "numeric")
              )

# Convert the date
d$Date <- as.Date(d$Date, "%d/%m/%Y")

# Restrict to between 2007-02-01 and 2007-02-01
d<- subset(d,Date >= '2007-02-01' & Date <='2007-02-02')

# Create a datetime field - note we have already converted the date
# so we use the date format native to R
d$DateTime <- strptime(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")

# Create the png graphics device, set size and transparency

png(file = "plot1.png", width = 480, height = 480, bg = "transparent")

# Plot histogram of global active power

hist(d$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# Close the graphics device

dev.off()