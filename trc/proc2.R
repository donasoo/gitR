reg <- "社区$|村委会$|社区居委会$|村民委员会$|村村民委员会$|村社区居委会$|村$|村社区$|社区居民委员会$|村村委会$"
vill_n4 <- vill_n
vill_n4$countycode <- 1000*floor(vill_n4$adcode/1000)
vill_n4$vill <- sub(reg, "", vill_n4$vill)

d14 <- dic14
d14$countycode <- 1000*floor(d14$adcode/1000)
d14 <- d14[(d14$adcode-d14$countycode)>0,]
d14$name <- sub(reg, "", d14$name)

v4c <- merge(vill_n4, d14, by.x='countycode', by.y='countycode', all.x=TRUE)
v4c$adcode_t <- v4c$adcode.y
str(v4c)
v4c <- v4c[,-c(8,9)]
str(v4c)

v4m <- v4c[v4c$vill==v4c$name,]
str(v4m)
v4m <- v4m[!is.na(v4m$name),c('code', 'adcode_t')]
vill_n4 <- merge(vill_n4, v4m, by.x='code', by.y='code', all.x=TRUE)
vill_n4 <- vill_n4[is.na(vill_n4$adcode_t), ]
v4m$adcode <- v4m$code
str(v4m)
vill_m <- rbind(vill_m, v4m)
write.csv(v4m, file='v4m.csv')
write.csv(vill_n4, file='vill_n4.csv')

vill_nf <- vill_n4

vill_nf <- merge(vill_nf, dic14, by.x='county', by.y='name', all.x=TRUE)
str(vill_nf)
d14$countycode <- 1000000*floor(d14$adcode/1000000)
vill_nf <- merge(vill_nf, d14, by.x='adcode.y', by.y='countycode', all.x=TRUE)
str(vill_nf)


write.csv(vill_nf, file='nf.csv')

vill_nm <- vill_nf[vill_nf$vill==vill_nf$name,]
str(vill_nm)
vill_nm$adcode_t <-vill_nm$adcode
vill_nm$adcode <- vill_nm$adcode.x
vill_nm <- vill_nm[,c('code','adcode','adcode_t')]
vill_m <- rbind(vill_m, vill_nm)
vill_n5 <- merge(vill_n4, vill_nm, by.x='code', by.y='code', all.x=TRUE)
vill_n5 <- vill_n5[is.na(vill_n5$adcode_t.y), ]


vill_n5$adcode <- vill_n5$adcode.x
vill_n5 <- vill_n5[, -c(7,8,9,10)]
vill_n5<- merge(vill_n5, vill, by.x='code', by.y='code', all.x=TRUE)
write.csv(vill_n5, file='vill_n5.csv')

