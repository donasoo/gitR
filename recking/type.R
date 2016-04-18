
smpcrop <- smpcrop_city
fzcrop <- fzcrop_city
cocrop <- cocrop_city


#合并样本区数据和功能区耕地
crop <- merge(x=smpcrop, y=fzcrop[, 1:2], by.x='city', by.y='city', suffixes = c("",".y"), all.x=TRUE)
#空值替换为0
crop[is.na(crop)] <- 0
#计算功能区耕地比例
crop$w <- 1-crop$V4.y/crop$V4
#样本框种植按比例重新计算
crop[,2:42] <- crop[,2:42]*crop$w



#新设计的部分  1  开始
#生成品种数据
crop_ic <- merge(x=crop, y=clri, by.x='city', by.y='city', suffixes = c("",".y"))
crop_ic$V13 <- round(crop_ic$V13*crop_ic$icradio, 0)
crop_rim <- merge(x=crop, y=clri, by.x='city', by.y='city', suffixes = c("",".y"))
crop_rim$V13 <- round(crop_rim$V13*crop_ic$rimradio, 0)
crop_t <- rbind(crop_ic[,1:43], crop_rim[,1:43])
crop_t[,c(2:10, 12:43)] <- 0
crop_t$type <- ""
crop_t$type[1:11] <- "C套种间作"
crop_t$type[12:22] <- "E周边零星"

crop_lot <- crop[,1:43]
crop_lot$type <- "D调查地块"

crop_fz <- fzcrop
crop_fz$type <- "B功能区"
crop_co <- cocrop
crop_co$type <- "F生产单位"

crop_t2 <- rbind(crop_lot, crop_fz, crop_co)
crop_t2[,2:43] <- round(crop_t2[,2:43], 0)
crop_t2$V13 <- rowSums(crop_t2[,c(12:23)] )
crop_t2$V12 <- crop_t2$V13+crop_t2$V26
crop_t2$V27 <- rowSums(crop_t2[,c(26:35,40,43)] )
crop_t <- rbind(crop_t, crop_t2)


crop_city <- aggregate(x=round(crop_t[,2:43], 0), by=list(city=crop_t$city), FUN=sum)
crop_city[12, 2:43] <- colSums(crop_city[,2:43])
crop_city$type <- "A合计"
crop_type <- aggregate(x=round(crop_t[,2:43], 0), by=list(type=crop_t$type), FUN=sum)
crop_city[13:17, 2:43] <- crop_type[,2:43]
crop_city$type[13:17] <- crop_type$type

crop_t0 <- rbind(crop_t, crop_city)
crop_t0 <- crop_t0[order(crop_t0$type),]
crop_t0 <- crop_t0[order(crop_t0$city, na.last=F),]
colnames(crop_t0) <- c(identifiers, 'type')
tcrop_t0 <- t(crop_t0)
write.csv(tcrop_t0, 'cropt.csv')
#新设计的部分  1  结束
