#读入样本地块播种面积数据
bzclass <- c(rep("character", 2), rep("numeric", 64))
bzidentifiers <- read.csv('bzidentifiers.csv', header = FALSE, stringsAsFactors=FALSE)
bzidentifiers <- bzidentifiers[,1]
bzcrop <- read.csv('bzcrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=bzclass)
bzcrop14 <- read.csv('bzcrop14.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=bzclass)
 
xcrop.d <- bzcrop[, 4:61]
xcrop.d[is.na(xcrop.d)] <- 0
bzcrop$zone <- substr(bzcrop$V2, 1, 14)

xcropd <- aggregate(x=xcrop.d, by=list(zone=as.factor(bzcrop$zone)), FUN=sum)

colnames(xcropd) <- bzidentifiers

write.csv(xcropd, 'bzzone.csv',na = "", quote=F )

