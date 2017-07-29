plot2 <- function() {
  
  ## create the data set
  power <- create_dataset()
  
  ## create the PNG file 
  png(file = "plot2.png", width = 480, height = 480)
  
  ## create the line plot
  with(c, plot(global_active_power ~ as.POSIXct(time), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

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