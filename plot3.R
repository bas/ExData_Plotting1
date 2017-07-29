plot3 <- function() {
  
  ## create the data set
  power <- create_dataset()
  
  ## create the PNG file 
  png(file = "plot3.png", width = 480, height = 480)
  
  ## create the line plot
  with(c, {
    plot(sub_metering_1 ~ as.POSIXct(time), type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
    lines(sub_metering_2 ~ as.POSIXct(time), col = "red")
    lines(sub_metering_3 ~ as.POSIXct(time), col = "blue")
    legend("topright", legend = names(c[7:9]), lty = 1, col = c('black', 'red', 'blue'))
  })

  dev.off()
}

create_dataset <- function() { 
  
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