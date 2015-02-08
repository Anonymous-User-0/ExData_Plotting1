plot2<- function(){
## This file creates the second plot of the project
require(dplyr)
require(stringr)
data<-read.table("household_power_consumption.txt",sep=";")
data1<-subset(data,data$V1=="2/1/2007" | data$V1=="2/2/2007")
rm(data)
data1<-tbl_df(data1)
data1<-mutate(data1,date=V1,time=V2,gloactpow=V3,gloreactpow=V4,voltage=V5,gloint=V6,sub1=V7,sub2=V8,sub3=V9)
data1<-select(data1,-(V1:V9))
dataplot1<-select(data1,gloactpow,date,time)
dataplot1<-filter(dataplot1,!identical(str_trim(gloactpow),"?"))
dataplot1<-mutate(dataplot1,gloactpow=as.numeric(str_trim(gloactpow)),datestr=paste(date,time))
plotdate<-time(lapply(dataplot1$datestr,strptime,"%d/%m/%Y %H:%M:%S"))
png("plot2.png",width = 480, height = 480)
plot(dataplot1$gloactpow~plotdate,lwd=2,xlab="",xaxt="n",ylab="Global Active Power (kilowatts)",type="l")
axis(1,at=c(0,1250,2500),labels=c("Thu","Fri","Sat"))
dev.off()
}
