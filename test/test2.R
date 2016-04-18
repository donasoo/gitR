library(reshape2)
bzclass <- c(rep("character", 3), rep("numeric", 8))

t2 <- read.csv("E:\\gitR\\test\\t2.csv", header=F,  colClasses = bzclass)
tn <- read.csv("E:\\gitR\\test\\tn.csv", header=T, colClasses=rep("character", 3))
t2$V2 <- as.numeric(t2$V3)
t2 <- t2[order(t2[,1], t2[,2]),]
str(t2)
str(tn)

t2m <- melt(t2, id=c("V1", "V3"))
t2m$variable <- c(t2m$V3, t2m$variable)
t2m <- t2m[order(t2m[,1], t2m[,2]),]
str(t2m)



t <- merge(x=t2, y=tn, by.x="V1", by.y="id", all=T)


t2 <- t2[order(t2[,1], t2[,3]),]
 write.csv(nt, "nt.csv",  na = "")
 
 
 str(t2)
 
 summary(t2)
 
 s <- tapply(t2[,1], as.factor(t2$V2), FUN=length)
 
 as.factor(t2$V2)
 