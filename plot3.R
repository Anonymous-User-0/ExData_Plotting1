plot3<- function(){
## This file creates the third plot of the project
require(dplyr)
require(stringr)
data<-read.table("household_power_consumption.txt",sep=";")
data1<-subset(data,data$V1=="2/1/2007" | data$V1=="2/2/2007")
rm(data)
data1<-tbl_df(data1)
#Changing names for my convenience
data1<-mutate(data1,date=V1,time=V2,gloactpow=V3,gloreactpow=V4,voltage=V5,gloint=V6,sub1=V7,sub2=V8,sub3=V9)
data1<-select(data1,-(V1:V9))
#Choose variables to work with
dataplot1<-select(data1,gloactpow,date,time,sub1,sub2,sub3)
dataplot1<-mutate(dataplot1,sub3=as.numeric(str_trim(sub3)),sub2=as.numeric(str_trim(sub2)),sub1=as.numeric(str_trim(sub1)),datestr=paste(date,time))
plotdate<-time(lapply(dataplot1$datestr,strptime,"%d/%m/%Y %H:%M:%S"))
datga1<-cbind(plotdate,dataplot1$sub1)
datga2<-cbind(plotdate,dataplot1$sub2)
datga3<-cbind(plotdate,dataplot1$sub3)
png("plot3.png", width = 480, height = 480)
plot(datga3,xlab="",xaxt="n",yaxp=c(0,40,4),ylab="Energy Sub-Mettering",type="l",col="blue",ylim=c(0,40) )
points(datga2,col="red",type="l")
points(datga1,col="black",type="l")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
legend("topright",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col=c("Black","Red","Blue"),lwd=c(1,1,1))
##
dev.off()
}
