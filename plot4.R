plot4 <- function() {
  
  ## create the data set
  power <- create_dataset()
  
  ## create the PNG file 
  png(file = "plot4.png", width = 480, height = 480)

  ## create four graphs
  par(mfrow=c(2,2))
  
  ## create the plots
  with(c, {
    plot(global_active_power ~ as.POSIXct(time), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

    plot(voltage ~ as.POSIXct(time), type = "l", xlab = "", ylab = "Voltage")
    
    plot(sub_metering_1 ~ as.POSIXct(time), type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
    lines(sub_metering_2 ~ as.POSIXct(time), col = "red")
    lines(sub_metering_3 ~ as.POSIXct(time), col = "blue")
    legend("topright", legend = names(c[7:9]), lty = 1, col = c('black', 'red', 'blue'))
    
    plot(global_reactive_power ~ as.POSIXct(time), type = "l", xlab = "", ylab = "Global Reactive Power")
    
    
  })

  dev.off()
}

create_dataset <- function() { 
  
  if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
    unzip("household_power_consumption.zip", exdir = "./")
  }
  
  ## read the data set
  c <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na = "?")
  
  ## convert the date and time values
  c$Time <- strptime(paste(c$Date, c$Time, sep = " "), format="%d/%m/%Y %H:%M:%S")
  c$Date <- as.Date(c$Date, format = "%d/%m/%Y")
  
  ## create a subset of the data
  c <- c[c$Date >= "2007-02-01" & c$Date <= "2007-02-02",]
  
  ## create descriptive names
  names(c) <- tolower(names(c))
  
  ## return the data
  return(c)
}