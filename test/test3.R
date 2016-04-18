# 我的
data <- read.csv("E:\\gitR\\test\\O4.csv", header=T,  as.is=TRUE )
str(data)
units <- read.csv("E:\\gitR\\test\\units.csv", header=T,  as.is=TRUE )
str(units)


sd1 <- aggregate(x=data$op, by=list(county=data$county), FUN=length)
sd2 <- merge(x=sd1, y=units, by.x='county', by.y='name', all.x=T)
sd2 <- sd2[order(sd2$code),]
str(sd2)
write.csv(sd2, 'sd2.csv')


data$townid <- ceiling(data$op/1000)
d4 <- data[,c("county", "townid")]
str(d4)
d5 <- unique(d4, incomparables = FALSE)
str(d5)

sd5 <- aggregate(x=d5$townid, by=list(county=d5$county), FUN=length)
sd5 <- merge(x=sd5, y=units, by.x='county', by.y='name', all.x=T)
sd5 <- sd5[order(sd5$code),]
write.csv(sd5, 'sd5.csv')
