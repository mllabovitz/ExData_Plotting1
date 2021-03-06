setwd("/media/markl/Extra Drive 1/ExploratoryDataAnalysis/DataSets/")
data<-read.delim(file="household_power_consumption.txt",sep=";",header=T,na.strings="?",as.is=TRUE,stringsAsFactors=FALSE)

dim(data)
colnames(data)
data[1,]

# create Date time element
attach(data)
dateTime <-as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")
detach(data)

datesCal<-as.Date(data[,1],"%d/%m/%Y")

# Add new data elements
data<-cbind(data,datesCal,dateTime)
colnames(data)[10:11]<-c("CalendarDate","DateTime")

# sub select dates
temp<-(as.character(data[,10]) %in% c("2007-02-01", "2007-02-02"))
sum(temp)

subsetData <- data[temp,]
dim(subsetData)

# check on the presence of missing values according to instructions
sum(as.character(subsetData) == "?")

summary(subsetData)

attach(subsetData) 

setwd("/media/markl/Extra Drive 1/ExploratoryDataAnalysis/Project1/")

# plots

# Plot4
png(filename="plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage")


plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(DateTime,Sub_metering_2,col="red")
lines(DateTime,Sub_metering_3,col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",
       col=c("black","red","blue"),lty=1)

plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

par(mfrow=c(1,1))
dev.off()
