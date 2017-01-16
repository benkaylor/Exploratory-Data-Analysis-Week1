library("data.table")
library("tidyr")

file <- "data/household_power_consumption.txt"

data <- fread(file)

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- readr::parse_datetime(data$DateTime, "%d/%m/%Y %T")

data$Date <- readr::parse_date(data$Date, "%d/%m/%Y")
data$Time <- readr::parse_time(data$Time, "%T")
data$Global_active_power <- readr::parse_number(data$Global_active_power)

data$Sub_metering_1 <- readr::parse_number(data$Sub_metering_1)
data$Sub_metering_2 <- readr::parse_number(data$Sub_metering_2)
data$Sub_metering_3 <- readr::parse_number(data$Sub_metering_3)

data$Voltage <- readr::parse_number(data$Voltage)
data$Global_reactive_power <- readr::parse_number(data$Global_reactive_power)

data.subset <- subset(data, Date >= as.Date("01/02/2007", "%d/%m/%Y") & Date <= as.Date("02/02/2007", "%d/%m/%Y"))

# Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(0,0,0,0))

# Plot 1/4
with(data.subset, 
     plot(DateTime, 
          Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power")
     )

# Plot 2/4
with(data.subset, 
     plot(DateTime, 
          Voltage, 
          type="l", 
          xlab="datetime", 
          ylab="Voltage") 
     )

# Plot 3/4
plot(data.subset$DateTime, 
     data.subset$Sub_metering_1, 
     type="l", 
     col="black", 
     xlab="", 
     ylab="Energy sub metering"
     )
lines(data.subset$DateTime, 
      data.subset$Sub_metering_2, 
      col="red"
      )
lines(data.subset$DateTime, 
      data.subset$Sub_metering_3, 
      col="blue"
      )
legend("topright", 
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, 
       bty="n",
       text.font=2,
       cex=.7 
       )

# Plot 4/4
with(data.subset, 
     plot(DateTime, 
          Global_reactive_power, 
          type="l", 
          xlab="datetime", 
          ylab="Global_reactive_power") 
     )

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()