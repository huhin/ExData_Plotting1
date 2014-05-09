##Exploratory Data Analysis
========================================================
# read data from 1/2/2007 to 2/2/2007
lines <- grep('^[1-2]/2/2007', 
              readLines('household_power_consumption.txt'))
select_data_colname = read.table ("household_power_consumption.txt", 
                                  head=TRUE, sep=";", nrows = 1)
select_data = read.table ("household_power_consumption.txt", 
                          sep=";", skip = lines[1]-1, nrows = length(lines))
#conbine $Date and $Time into $DateTime with paste, convert into "date" class
#by using strptime
names (select_data) = names (select_data_colname)
select_data$DateTime = paste (select_data$Date, select_data$Time, sep= " ")
select_data$DateTime = strptime (select_data$DateTime, "%d/%m/%Y %H: %M :%S")
class (select_data$DateTime)

#draw plot 4
plot2Data = select_data
png (file = "plot4.png", width=480, height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with (plot2Data, {
  plot (plot2Data$DateTime, plot2Data$Global_active_power, type = "s", xlab="", ylab="Global Active Power")
  plot (plot2Data$DateTime, plot2Data$Voltage, type = "s", xlab = "datetime", ylab="Voltage")
  plot (DateTime,Sub_metering_1, type = "s", xlab="", ylab="Energy sub metering")
  with (plot2Data, lines (DateTime, Sub_metering_1, col="black"))
  with (plot2Data, lines (DateTime, Sub_metering_2, col="red"))
  with (plot2Data, lines (DateTime, Sub_metering_3, col="blue"))
  legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=1)
  plot (plot2Data$DateTime, plot2Data$Global_reactive_power, type = "s", xlab ="datetime", ylab="Global_reactive_power")
})
dev.off()