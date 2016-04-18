bzclass <- rep("character", 30)

t3 <- read.csv("E:\\gitR\\test\\o3.csv", header=F,  as.is=FALSE, colClasses = bzclass)
t4 <- read.csv("E:\\gitR\\test\\lo4.csv", header=T,  as.is=FALSE, colClasses = rep("character", 2))

t3 <- t3[,c(1,10,30)]

str(t3)
str(t4)

t <- merge(x=t3, y=t4, by.x="V10", by.y="zoneid", all.x=T, all.y=F)
str(t)

write.csv(t, "t3x.csv",  na = "", quote=F, row.names = F) 
