#==============================
#计算减少系数
#==============================
reckreduce <- function(t2){
#将数据空值替换为0
t2[is.na(t2)] <- 0

t2$city <- floor(t2$V1/100000000)
t2.d <- t2[t2$V6>0,]

#推算生产单位，直接汇总
stractcrop <- aggregate(x=t2.d[,c(4,5)], by=list(city=as.factor(t2.d$city), stract=as.factor(t2.d$V6)), FUN=sum)
stractcrop$radio <- stractcrop$V5/stractcrop$V4
stractcrop$id <- as.numeric(stractcrop$city)*1000+as.numeric(stractcrop$stract)
stractcrop$annual <- 2014
write.csv(stractcrop, 'stractcrop.csv')
return(stractcrop)

}