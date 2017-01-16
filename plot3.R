library("data.table")
library("tidyr")

file <- "data/household_power_consumption.txt"
data <- fread(file)

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- readr::parse_datetime(data$DateTime, "%d/%m/%Y %T")

data$Date <- readr::parse_date(data$Date, "%d/%m/%Y")
data$Time <- readr::parse_time(data$Time, "%T")

data$Sub_metering_1 <- readr::parse_number(data$Sub_metering_1)
data$Sub_metering_2 <- readr::parse_number(data$Sub_metering_2)
data$Sub_metering_3 <- readr::parse_number(data$Sub_metering_3)

data.subset <- subset(data, Date >= as.Date("01/02/2007", "%d/%m/%Y") & Date <= as.Date("02/02/2007", "%d/%m/%Y"))

# Plot 3
plot3 <- plot(data.subset$DateTime, 
              data.subset$Sub_metering_1, 
              type="l", 
              col="black", 
              xlab="", 
              ylab="Energy sub metering"
              )
plot3 <- lines(data.subset$DateTime, 
               data.subset$Sub_metering_2, 
               col="red"
               )
plot3 <- lines(data.subset$DateTime, 
               data.subset$Sub_metering_3, 
               col="blue"
               )
legend("topright",
       lty=1, 
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1", 
                "Sub_metering_2", 
                "Sub_metering_3")
       )


dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()