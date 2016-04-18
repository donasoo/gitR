#我的说明
str(smpcrop)
str(smpcrop14)

smpcrop[is.na(smpcrop$V48),'V48'] <- as.numeric(substr(smpcrop[is.na(smpcrop$V48),'V2'], 1, 12))
smpcrop[smpcrop$V48>999999999999,'V48'] <- as.numeric(substr(smpcrop[smpcrop$V48>999999999999,'V2'], 1, 12))

smp <- smpcrop[smpcrop$V49>0,]
smp14 <- smpcrop14[smpcrop14$V49>0,]

smp.d <- smp[, 4:45]
smp.d[is.na(smp.d)] <- 0

smp14.d <- smp14[, 4:45]
smp14.d[is.na(smp14.d)] <- 0

casc <- aggregate(x=smp.d[,c('V4', 'V13')], by=list(city=as.factor(floor(smp$V48/100000000))), FUN=sum)
casc14 <- aggregate(x=smp14.d[,c('V4', 'V13')], by=list(city=as.factor(floor(smp14$V48/100000000))), FUN=sum)
str(casc)
str(casc14)

casc <- merge(x=casc14, y=casc, by.x='city', by.y='city')
casc$sity.x <- casc$V13.x/casc$V4.x*100
casc$sity.y <- casc$V13.y/casc$V4.y*100
casc$sity <- casc$sity.y-casc$sity.x
casc$dsity <- casc$sity/casc$sity.x*100


fz1 <- fzcrop14[,1:2]
fz2 <- fzcrop[,1:2]
fz1$V2 <- toupper(fz1$V2)
fz2$V2 <- toupper(fz2$V2)
fzid <- merge(x=fz1, y=fz2, by.x='V2', by.y='V2', all=F)
write.csv(fzid, 'fzid2.csv')
