
#  读入
vm6 <- read.csv('vm6.csv', header = TRUE, stringsAsFactors=FALSE, colClasses=c(rep("character",6)))
vm6 <- vm6[vm6$code != vm6$adcode_t,]
str(vm6)

#  读入地块
dlot <- read.csv('33_lot.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, col.names=c('pid', 'id', 'name', 'adid'), colClasses=c(rep("character",4)))
str(dlot)

dlot[is.na(dlot$adid),'adid'] <- substr(dlot[is.na(dlot$adid),'id'], 1, 12)

dlot2 <- merge(dlot, vm6, by.x='adid', by.y='code',  all.x=FALSE)
dlot2[dlot2$adid != dlot2$adcode_t,]
str(dlot2)

write.csv(dlot2, 'dlot2.csv')

#  读入生产单位
dunit <- read.csv('33_unit.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, col.names=c('pid', 'id', 'adid'), colClasses=c(rep("character",3)))
str(dunit)

#  读入功能区
dfz <- read.csv('33_zone.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, col.names=c('pid', 'id', 'adid'), colClasses=c(rep("character",3)))
str(dfz)
dunit <- dfz

# 先和14年最终结果匹配
du <- merge(dunit, sdic14, by.x='adid', by.y='adcode', all.x=FALSE)
du <- du[, -c(4:8, 13)]
du$adcode_t <- du$adid
str(du)
du1 <- merge(dunit, vm6, by.x='adid', by.y='code', all.x=FALSE)
str(du1)
du <- rbind(du, du1)
str(du)
du1 <- merge(dunit, du[, c(3,8)], by.x='id', by.y='id', all.x=TRUE)
du1 <- du1[is.na(du1$adcode_t),-4]
vm6$codex <- paste(substr(vm6$code, 1,9), '000', sep='')
vm6 <-vm6[!duplicated(vm6$codex), ]

du2 <- merge(du1, vm6, by.x='adid', by.y='codex', all.x=FALSE, all.y=FALSE)
du2 <- du2[, -4];
str(du2)
du <- rbind(du, du2)
str(du)
write.csv(du, 'dz.csv')


