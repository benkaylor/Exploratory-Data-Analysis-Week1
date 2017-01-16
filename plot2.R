library("data.table")
library("tidyr")

file <- "data/household_power_consumption.txt"
data <- fread(file)

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- readr::parse_datetime(data$DateTime, "%d/%m/%Y %T")

data$Date <- readr::parse_date(data$Date, "%d/%m/%Y")
data$Time <- readr::parse_time(data$Time, "%T")
data$Global_active_power <- readr::parse_number(data$Global_active_power)

data.subset <- subset(data, Date >= as.Date("01/02/2007", "%d/%m/%Y") & Date <= as.Date("02/02/2007", "%d/%m/%Y"))


# Plot 2
plot2<-with(data.subset, 
            plot(DateTime, 
                 Global_active_power, 
                 type="l", 
                 xlab="", 
                 ylab="Global Active Power (kilowatts)")
            )


dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()