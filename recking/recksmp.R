#========================================
#全部按照样本区推算，不考虑功能区和农业生产单位
#========================================
recksmp <- function(smpcrop, land_t, plough){


#没有行政区划代码的补全
#减少系数为空的替换为1
smpcrop$V51[is.na(smpcrop$V51)] <- 1
#将数据空值替换为0
smpcrop[is.na(smpcrop)] <- 0

smpcrop.d <- smpcrop[, 4:45]


#第一步，将地块数据放大
smpcrop.d <- smpcrop.d*smpcrop$V51

#准备第二步，设计id号为各市标准代码+层号
smpcrop$id <- floor(smpcrop$V3/100000000)*1000+smpcrop$V49
#第二步，分市汇总到层（以id号分组）
smpcrop_stratum <- aggregate(x=smpcrop.d, by=list(id=as.factor(smpcrop$id)), FUN=sum)

#第三步，将分层耕地合并，并乘
smpcrop_stratum <- merge(x=smpcrop_stratum, y=land_t, by.x='id', by.y='id')
smpcrop_stratum$w <- smpcrop_stratum$landt/smpcrop_stratum$V4;
smpcrop_stratum.d <- smpcrop_stratum[,2:43]*smpcrop_stratum$w

#第四步，将汇总到市
smpcrop_city <- aggregate(x=smpcrop_stratum.d, by=list(city=as.factor(smpcrop_stratum$city)), FUN=sum)

#第五步，分市样本区数据与分市耕地数据合并
smpcrop_city <- merge(x=smpcrop_city, y=plough, by.x='city', by.y='city', suffixes = c("",".y"))
smpcrop_city$outsf <- smpcrop_city$outsf*smpcrop_city$V4/smpcrop_city$insf
smpcrop_city$w <- (smpcrop_city$V4+smpcrop_city$outsf+smpcrop_city$plus1+smpcrop_city$plus2)/smpcrop_city$V4
smpcrop_city[, 2:43] <- smpcrop_city[, 2:43]*smpcrop_city$w

#
##四舍五入
#smpcrop_city[,2:43] <- round(smpcrop_city[,2:43], 0)
##重新计算粮食合计
##粮食合计乘以周边零星和套种间作系数
#smpcrop_city$V13 <- rowSums(smpcrop_city[,c(12:23)] )*(1+smpcrop_city$rimradio+smpcrop_city$icradio)
#smpcrop_city$V12 <- rowSums(smpcrop_city[,c(12:24)] )*(1+smpcrop_city$rimradio+smpcrop_city$icradio)
#smpcrop_city$V27 <- rowSums(smpcrop_city[,c(26:35,40,43)] )*(1+smpcrop_city$rimradio+smpcrop_city$icradio)
#
#colnames(smpcrop_city) <- identifiers

write.csv(smpcrop_city, 'citysmpcrop.csv')
return( smpcrop_city[, 1:43])
}
