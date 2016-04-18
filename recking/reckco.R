#推算生产单位数据

reckco <- function(cocrop){
cocrop[is.na(cocrop)] <- 0

#将数据空值替换为0
cocrop.d <- cocrop[, 4:45]


#推算生产单位，直接汇总
citycocrop <- aggregate(x=cocrop.d, by=list(city=as.factor(floor(cocrop$V3/100000000))), FUN=sum)

##四舍五入
#citycocrop[,2:43] <- round(citycocrop[,2:43], 0)
##重新计算粮食合计
#citycocrop$V13 <- rowSums(citycocrop[,c(12:23)] )
#citycocrop$V12 <- rowSums(citycocrop[,c(12:24)] )
#citycocrop$V27 <- rowSums(citycocrop[,c(26:35,40,43)] )
#


write.csv(citycocrop, 'citycocrop.csv')
return(citycocrop)

}