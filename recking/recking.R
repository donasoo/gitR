#最终推算
recking <- function(smpcrop, fzcrop, cocrop, clri){

#合并样本区数据和功能区耕地
crop <- merge(x=smpcrop, y=fzcrop[, 1:2], by.x='city', by.y='city', suffixes = c("",".y"), all.x=TRUE)
#空值替换为0
crop[is.na(crop)] <- 0
#计算功能区耕地比例
crop$w <- 1-crop$V4.y/crop$V4
#样本框种植按比例重新计算
crop[,2:42] <- crop[,2:42]*crop$w


#原来注释掉的部分  0  开始
#重新计算粮食合计
#粮食合计乘以周边零星和套种间作系数
crop <- merge(x=crop, y=clri, by.x='city', by.y='city', suffixes = c("",".y"))
crop$V13 <- rowSums(crop[,c(12:23)] )*(1+crop$rimradio+crop$icradio)



#连接样本种植、功能区、单位三种数据
crop <- rbind(crop[,1:43], fzcrop, cocrop)
#四舍五入
crop[,2:43] <- round(crop[,2:43], 0)
#重新计算粮食合计
crop[12:33, 'V13'] <- rowSums(crop[12:33,12:23] )
crop$V12 <- crop$V13+crop$V26
crop$V27 <- rowSums(crop[,c(26:35,40,43)] )

write.csv(crop, 'croptype.csv')

#原来注释掉的部分  0 结束

#汇总到市
citycrop <- aggregate(x=round(crop[,2:43], 0), by=list(city=crop$city), FUN=sum)

citycrop[12, 2:43] <- colSums(citycrop[, 2:43])
write.csv(citycrop, 'citycrop.csv')

crop <- merge(x=smpcrop[,c('city', 'V4', 'V13')], y=fzcrop[,c('city', 'V4', 'V13')], by.x='city', by.y='city', suffixes = c(".smp",".fz"), all.x=TRUE)
crop <- merge(x=crop, y=cocrop[,c('city', 'V4', 'V13')], by.x='city', by.y='city', suffixes = c("",".co"), all.x=TRUE)
crop[is.na(crop)] <- 0
crop$crop <- (1-crop$V4.fz/crop$V4.smp)*crop$V13.smp+crop$V13.fz+crop$V13
crop[, 2:8] <- round(crop[, 2:8], 0)
crop[12,2:8] <- colSums(crop[,2:8])

crop$rsmp <- round(crop$V13.smp/crop$V4.smp*100, 2)
crop$rfz <- round(crop$V13.fz/crop$V4.fz*100, 2)
crop$rco <- round(crop$V13/crop$V4*100, 2)
write.csv(crop, 'citycrop_all.csv')


return(citycrop)
}