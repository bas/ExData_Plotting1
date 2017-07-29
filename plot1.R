plot1 <- function() {
  
  ## create the data set
  power <- create_dataset()
  
  ## create the PNG file 
  png(file = "plot1.png", width = 480, height = 480)
  
  ## create the histogram
  hist(power$global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

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