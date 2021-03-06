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

#draw plot 2
plot2Data = select_data
#plot2Data$day = weekdays (as.Date(plot2Data$Date))
png (file = "plot2.png", width=480, height=480)
op= par (oma = c (3,4,2,2))
par (op)
plot (plot2Data$DateTime, plot2Data$Global_active_power, type = "s", xlab="", ylab="Global Active Power (killowatts)")
dev.off()