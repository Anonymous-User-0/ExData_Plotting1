plot1<- function( ){
## This file creates the first plot of the project
 

## Checking for existence of needed directories
## if (!file.exists("MFiles")){ dir.create("MFiles")}
require(dplyr)
data<-read.table("household_power_consumption.txt",sep=";")
data1<-subset(data,data$V1=="2/1/2007" | data$V1=="2/2/2007")
rm(data)
data1<-tbl_df(data1)
data1<-mutate(data1,date=V1,time=V2,gloactpow=V3,gloreactpow=V4,voltage=V5,gloint=V6,sub1=V7,sub2=V8,sub3=V9)
data1<-select(data1,-(V1:V9))
dataplot1<-select(data1,gloactpow)
dataplot1<-filter(dataplot1,gloactpow!="?")
dataplot1<-lapply(dataplot1,str_trim)
png("plot1.png", width = 480, height = 480)
hist(as.numeric(dataplot1$gloactpow),col="red",xlab="Global Active Power (Kilowatts)",main="Global Active Power",xaxp=c(0,6,3),yaxp=c(0,1200,6))
dev.off()
}
