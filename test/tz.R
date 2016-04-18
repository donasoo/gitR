bc <- c(rep("character", 3), rep("numeric", 8))
t2 <- read.csv("E:\\gitR\\test\\t21.csv", header=T,  as.is=FALSE, colClasses = bc)
tn <- read.csv("E:\\gitR\\test\\tn.csv", header=T,  as.is=FALSE, colClasses = rep("character", 3))

str(t2)
str(tn)

t <- merge(x=t2, y=tn, by="id", all=T)
t<- t[is.na(t$depen), ]
t$d40 <- rowSums(t[,7:10], na.rm=T)
t$d60 <- t$d8
str(t)

write.csv(t, "t.csv",  na = "", quote=F, row.names = F)


nid <- unique(t$id)
write.csv(nid, "nid.csv",  na = "", quote=F, row.names = F)
