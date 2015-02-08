plot4<- function(){
## This file creates the fourth plot of the project
## Checking for existence of needed directories
## if (!file.exists("MFiles")){ dir.create("MFiles")}
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
dataplot1<-select(data1,gloactpow,gloreactpow,date,time,sub1,sub2,sub3,voltage)
dataplot1<-mutate(dataplot1,sub3=as.numeric(str_trim(sub3)),sub2=as.numeric(str_trim(sub2)),sub1=as.numeric(str_trim(sub1)),datestr=paste(date,time))

# get rid of non-data
dataplot1<-filter(dataplot1,gloactpow!="?")

#dates to plot
plotdate<-time(lapply(dataplot1$datestr,strptime,"%d/%m/%Y %H:%M:%S"))
png("plot4.png", width = 640, height = 640)
par(mfcol=c(2,2))
## Plot global_active_power by day
dataplot3<-mutate(dataplot1,gloactpow=as.numeric(str_trim(gloactpow)))
plot(dataplot3$gloactpow~plotdate,lwd=2,xlab="",xaxt="n",ylab="Global Active Power (kilowatts)",type="l")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

## Plot Sub_mettering graph
datga1<-cbind(plotdate,dataplot1$sub1)
datga2<-cbind(plotdate,dataplot1$sub2)
datga3<-cbind(plotdate,dataplot1$sub3)
plot(datga3,xlab="",xaxt="n",yaxp=c(0,40,4),ylab="Energy Sub-Mettering",type="l",col="blue",ylim=c(0,40) )
points(datga2,col="red",type="l")
points(datga1,col="black",type="l")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
legend("topleft",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col=c("Black","Red","Blue"),lwd=c(1,1,1))
## Plot Voltage
datga1<-cbind(plotdate,as.numeric(str_trim(dataplot1$voltage)))
plot(datga1,type="l",xlab="Date -- Time",ylab="Voltage",xaxt="n")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
## Plot Global Reactive Power
dataplot4<-mutate(dataplot1,gloreactpow=as.numeric(str_trim(gloreactpow)))
plot(dataplot4$gloreactpow~plotdate,lwd=2,xlab="",xaxt="n",ylab="Global Reactive Power (kilowatts)",type="l")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
dev.off()
}
