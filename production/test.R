
library(reshape2)
library(xtable)
#本文件计算全年各市及全省粮食产量和增幅

##第一部分，读取所需数据


area <- read.csv(file='E:\\gitR\\production\\area.csv', header = TRUE, stringsAsFactors=FALSE)
area[is.na(area)] <- 0
area[,5:16]  <- round(area[,5:16] , digits=0)



yield <- read.csv('E:\\gitR\\production\\yield.csv', header = TRUE, stringsAsFactors=FALSE)
yield[is.na(yield)] <- 0
yield[,5:16]  <- round(yield[,5:16] , digits=1)



gross <- read.csv('E:\\gitR\\production\\gross.csv', header = TRUE, stringsAsFactors=FALSE)
gross[is.na(gross)] <- 0


yield14 <- read.csv('E:\\gitR\\production\\yield2014.csv', header = TRUE, stringsAsFactors=FALSE)
yield14[is.na(yield14)] <- 0

cityarea <- read.csv('E:\\gitR\\production\\cityarea.csv', header = TRUE, stringsAsFactors=FALSE)
cityarea[is.na(cityarea)] <- 0
cityarea[,3:14]  <- round(cityarea[,3:14] , digits=0)

##第二部分，计算产量

#新建产量数据框
production <- area;
production[,5:16] <- round(area[,5:16]*yield[,5:16], digits=0)


city.area <- aggregate(x=area[,5:16], by=list(city=as.factor(area$city), season=as.factor(area$season)), FUN=sum)


city.prod <- aggregate(x=production[,5:16], by=list(city=as.factor(production$city), season=as.factor(production$season)), FUN=sum)


#新建市级产量数据框，市级
cityprod <- cityarea
cityprod[,3:14] <- round(city.prod[,3:14]/city.area[,3:14]*cityarea[,3:14]/1000, digits=0)
cityprod[is.na(cityprod)] <- 0


#计算各品种合计数
cityprod$V0 <- rowSums(cityprod[,3:14])
str(cityprod)
cityarea$V0 <- rowSums(cityarea[,3:14])
str(cityarea)


##第三部分，汇总数据

x <- aggregate(x=cityarea[,3:15], by=list(city=as.factor(cityarea$city)), FUN=sum)
x$season <- 'Q0'
cityarea <- rbind(cityarea, x)
x <- aggregate(x=cityarea[,3:15], by=list(season=as.factor(cityarea$season)), FUN=sum)
x$city <- 3300
cityarea <- rbind(cityarea, x)

x <- aggregate(x=cityprod[,3:15], by=list(city=as.factor(cityprod$city)), FUN=sum)
x$season <- 'Q0'
cityprod <- rbind(cityprod, x)
x <- aggregate(x=cityprod[,3:15], by=list(season=as.factor(cityprod$season)), FUN=sum)
x$city <- 3300
cityprod <- rbind(cityprod, x)



##第四部分，计算增幅

citydata <- merge(x=cityarea[,c('city','season','V0')],y=cityprod[,c('city','season','V0')], by=c('city','season'), suffixes = c(".a",".p"))
citydata <- merge(x=citydata, y=yield14[,c('city','season','V0')], by=c('city','season'), suffixes = c("",".y14"))
citydata <- merge(x=citydata, y=gross[,c('city','season','V0')], by=c('city','season'), suffixes = c("",".ag"))
citydata$V0.pg <- round((citydata$V0.ag+100)*citydata$V0.p/citydata$V0.a/citydata$V0*1000-100, digits=1)
citydata$V0.y <- round(x=citydata$V0.p/citydata$V0.a*1000, digits = 1)
citydata$V0.yg <- round(x=citydata$V0.y/citydata$V0*100-100, digits = 1)
citydata$V0.ag <- round(x=citydata$V0.ag, digits = 1)
citydata[,order(colnames(citydata))]

dispdata <- citydata
colnames(dispdata) <- c('市', '报期', '上期单产', '播种面积', '增幅', '产量', '增幅', '单产', '增幅')
print.xtable(xtable(dispdata), type="html")

x <- melt(citydata)
x1 <- x[x$variable %in% c('V0.a', 'V0.ag'),]
d1 <- dcast(x1, city ~ variable+season)
colnames(d1) <- c('市', '全年', '春', '夏', '秋', '全年增幅', '春增幅', '夏增幅', '秋增幅')
print.xtable(xtable(d1), type="html")

x1 <- x[x$variable %in% c('V0.y', 'V0.yg'),]
d2 <- dcast(x1, city ~ variable+season)
colnames(d2) <- c('市', '全年', '春', '夏', '秋', '全年增幅', '春增幅', '夏增幅', '秋增幅')
print.xtable(xtable(d2), type="html")

x1 <- x[x$variable %in% c('V0.p', 'V0.pg'),]
d3 <- dcast(x1, city ~ variable+season)
colnames(d3) <- c('市', '全年', '春', '夏', '秋', '全年增幅', '春增幅', '夏增幅', '秋增幅')
print.xtable(xtable(d3), type="html")

