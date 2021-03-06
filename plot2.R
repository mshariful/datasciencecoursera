rm(list=ls())

setwd("C:\\Users\\Shariful\\Documents\\GitHub\\courses\\04_ExploratoryAnalysis\\Data\\exdata_data_household_power_consumption")


# Read the data by using read.table
data<-read.table('household_power_consumption.txt', header=T,sep=";",na.strings = "?")

# Look into the data structure
str(data)

head(data)

#We note that the date variable is a factor rather than a date. Thus we
#  convert it into a date
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

# Covert Time as character variable
data$Time<-as.character(data$Time)

# Subset the data
Sub_data<-subset(data,Date==as.Date('2007-02-01') | Date==as.Date('2007-02-02'))


# Paste Date and Time together
date_tm<-paste(Sub_data$Date,Sub_data$Time)

# Use strpime
DateTime<-strptime(date_tm, "%Y-%m-%d %H:%M:%S") 

# plot
png(filename = "plot2.png",width = 480, height = 480,units = "px")
plot(DateTime,Sub_data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()


