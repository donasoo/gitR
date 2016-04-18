#========================================
#推算功能区
#========================================

reckfz <- function(fzcrop, fzland=0){
#烟叶替换指标设置为0
fzcrop$V34 <-0
fzcrop[is.na(fzcrop)] <- 0
#功能区汇总到市
#将数据空值替换为0
fzcrop.d <- fzcrop[, 4:45]
fzcrop.d$V13=rowSums(fzcrop.d[,c(11:22)] )
fzcrop.d$V12=fzcrop.d$V13+fzcrop.d$V26
fzcrop.d$V27=rowSums(fzcrop.d[,c(25:34,39,42)])
cityfzcrop <- aggregate(x=fzcrop.d, by=list(city=as.factor(floor(fzcrop$V3/100000000))), FUN=sum)
countfz <- aggregate(x=fzcrop$V3, by=list(city=as.factor(floor(fzcrop$V3/100000000))), FUN=length)
write.csv(countfz, 'countfz.csv')
if (fzland != 0){
	cityfzcrop <- merge(x=cityfzcrop, y=fzland, by.x='city', by.y='city')
	cityfzcrop$w <- cityfzcrop$fzland/cityfzcrop$V4;
	cityfzcrop[,2:43] <- cityfzcrop[,2:43]*cityfzcrop$w
	cityfzcrop <- cityfzcrop[, 1:43]
}

#四舍五入
cityfzcrop[,2:43] <- round(cityfzcrop[,2:43], 0)
#重新计算粮食合计
cityfzcrop$V13 <- rowSums(cityfzcrop[,c(12:23)] )
cityfzcrop$V12 <- rowSums(cityfzcrop[,c(12:24)] )
cityfzcrop$V27 <- rowSums(cityfzcrop[,c(26:35,40,43)] )



write.csv(cityfzcrop, 'cityfzcrop.csv')
return(cityfzcrop)
}