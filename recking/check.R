#==============================
#读入数据并进行必要的预处理
#==============================

#将数据空值替换为0
scheck <- smpcrop
scheck$V51[is.na(scheck$V51)] <- 1
scheck <- scheck[scheck$V49>0,]
scheck[is.na(scheck)] <- 0

scheck.d <- scheck[, 13:25]*scheck$V51;
scheck$city <- floor(scheck$V3/100000000)
scheck_city <- aggregate(x=scheck.d, by=list(city=as.factor(scheck$city)), FUN=sum)

scheck_city[scheck_city$city==3308,"V13"]
write.csv(scheck_city, 'scheck_city14.csv')


checkf <- function(){
  s <- units
  s
}