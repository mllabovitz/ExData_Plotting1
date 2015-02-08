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
# Plot1

png(filename="plot1.png",width = 480, height = 480)
hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()