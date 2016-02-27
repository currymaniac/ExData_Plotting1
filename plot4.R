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
# Note, this could be done during read, but is not required for the assignment
d<- subset(d,Date >= '2007-02-01' & Date <='2007-02-02')

# Create a datetime field - note we have already converted the date
# so we use the date format native to R
d$DateTime <- strptime(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")

# End of data loading

# Create the png graphics device, set size and transparency
png(file = "plot4.png", width = 480, height = 480, bg = "transparent")

# Plot 4
# Configure layout to have two rows and columns
# Lower the right to let the plots have more room - the top could also be lowered if desired
par(mfrow=c(2,2), mar=c(4,4,4,2));

# Using mfrow, the plots will be created in the top row left to right, 
# then in the second row, left to right

# Global active power
plot(d$DateTime, d$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Voltage
plot(d$DateTime, d$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Sub metering
plot(d$DateTime, d$Sub_metering_1, type = "l", col="black", ylab = "Energy sub metering", xlab="")
points(d$DateTime, d$Sub_metering_2, type = "l", col="red")
points(d$DateTime, d$Sub_metering_3, type = "l", col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red", "blue"), 
       lty = 1,
       bty="n"
)

# Global reactive power
plot(d$DateTime, d$Global_reactive_power, type="l", ylab="Gloabl_reactive_power", xlab="datetime")

# Close the graphics device
dev.off()