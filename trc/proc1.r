require(reshape2)
# 与14年标准行政区划代码合并
vill_c<- merge(vill, dic14, by.x='adcode', by.y='adcode', all.x=TRUE)
str(vill_c)

# 取出匹配的部分
vill_m <- vill_c[!is.na(vill_c$name),]
vill_m$adcode_t=vill_m$adcode
vill_m <- vill_m[,c('adcode', 'adcode_t', 'code')]
str(vill_m)

# 取出没有匹配的部分
vill_n <- vill_c[is.na(vill_c$name),]
str(vill_n)

#处理14年变更文件为对应关系
md14$index <- rep(seq(nrow(md14)/2),each=2)
md14[md14$mdstate=='变更后','mdstate'] <- 't'
md14[md14$mdstate=='变更前','mdstate'] <- 'o'
x <- melt(md14, id=c('index', 'mdstate'))
x$variable <- paste(x$variable, x$mdstate, sep='_')
md14x <- dcast(x, index~variable)
md14x <- merge(md14x, dic14, by.x='mdcode_t', by.y='adcode', all.x=TRUE)
md14x <- md14x[!is.na(md14x$name),]
write.csv(md14x, file='out_md14.csv')
str(md14x)

#在14年变更文件中匹配
vill_nc <- merge(vill_n, md14x, by.x='adcode', by.y='mdcode_o', all.x=TRUE)
str(vill_nc)

# 取出匹配的部分
vill_ncm <- vill_nc[!is.na(vill_nc$mdcode_t),]
str(vill_ncm)
vill_ncm$adcode_t=vill_ncm$mdcode_t
vill_ncm <- vill_ncm[,c('adcode', 'adcode_t', 'code')]
vill_m <- rbind(vill_m, vill_ncm)
str(vill_m)

# 取出没有匹配的部分
vill_n <- vill_nc[is.na(vill_nc$mdcode_t),c('code', 'adcode')]
str(vill_n)

#处理13年变更文件为对应关系
md13$index <- rep(seq(nrow(md13)/2),each=2)
md13[md13$mdstate=='变更后','mdstate'] <- 't'
md13[md13$mdstate=='变更前','mdstate'] <- 'o'
x <- melt(md13, id=c('index', 'mdstate'))
x$variable <- paste(x$variable, x$mdstate, sep='_')
md13x <- dcast(x, index~variable)
md13x <- merge(md13x, dic14, by.x='mdcode_t', by.y='adcode', all.x=TRUE)
md13x <- md13x[!is.na(md13x$name),]
write.csv(md13x, file='out_md13.csv')
str(md13x)

#在13年变更文件中匹配
vill_nc <- merge(vill_n, md13x, by.x='adcode', by.y='mdcode_o', all.x=TRUE)
str(vill_nc)

# 取出匹配的部分
vill_ncm <- vill_nc[!is.na(vill_nc$mdcode_t),]
str(vill_ncm)
vill_ncm$adcode_t=vill_ncm$mdcode_t
vill_ncm <- vill_ncm[,c('adcode', 'adcode_t', 'code')]
vill_m <- rbind(vill_m, vill_ncm)
str(vill_m)

# 取出没有匹配的部分
vill_n <- vill_nc[is.na(vill_nc$mdcode_t),c('adcode', 'code')]
str(vill_n)


#在12年变更文件中匹配
vill_nc <- merge(vill_n, md12, by.x='adcode', by.y='mdcode', all.x=TRUE)
str(vill_nc)

# 取出匹配的部分
vill_ncm <- vill_nc[!is.na(vill_nc$mdname),]
str(vill_ncm)

#按名字取匹配
vill_ncm2 <- merge(vill_ncm, md12, by.x='mdname', by.y='mdname', all.x=TRUE);
vill_ncm2 <- vill_ncm2[,-2]
str(vill_ncm2)

#按变更代码匹配
vill_ncm2 <- merge(vill_ncm2, dic12, by.x='mdcode', by.y='adcode', all.x=TRUE);
vill_ncm2 <- vill_ncm2[!is.na(vill_ncm2$name),]
str(vill_ncm2)
vill_ncm2$adcode <- vill_ncm2$code
vill_ncm2$adcode_t <- vill_ncm2$mdcode
vill_ncm2 <- vill_ncm2[,c('adcode', 'adcode_t', 'code')]
vill_m <- rbind(vill_m, vill_ncm2)
write.csv(vill_ncm2, file='out.csv')

# 取出没有匹配的部分
vill_c <- merge(vill, vill_m, by.x='code', by.y='code', all.x=TRUE);
vill_n <- vill_c[is.na(vill_c$adcode_t),]
vill_n$adcode <- vill_n$adcode.x
vill_n <- vill_n[,c('code','adcode')]
str(vill_n)

#在11年变更文件中匹配
vill_nc <- merge(vill_n, md11, by.x='adcode', by.y='mdcode', all.x=TRUE)
str(vill_nc)

# 取出匹配的部分
vill_ncm <- vill_nc[!is.na(vill_nc$mdname),]
str(vill_ncm)

#按名字取匹配
vill_ncm2 <- merge(vill_ncm, md11, by.x='mdname', by.y='mdname', all.x=TRUE);
vill_ncm2 <- vill_ncm2[,-2]
str(vill_ncm2)

#按变更代码匹配
vill_ncm2 <- merge(vill_ncm2, dic11, by.x='mdcode', by.y='adcode', all.x=TRUE);
vill_ncm2 <- vill_ncm2[!is.na(vill_ncm2$name),]
str(vill_ncm2)
vill_ncm2$adcode <- vill_ncm2$code
vill_ncm2$adcode_t <- vill_ncm2$mdcode
vill_ncm2 <- vill_ncm2[,c('adcode', 'adcode_t', 'code')]
vill_m <- rbind(vill_m, vill_ncm2)
str(vill_m)
write.csv(vill_m, file='vill_m.csv')


#试验最终匹配结果
vill_c <- merge(vill_m, dic14, by.x='adcode_t', by.y='adcode', all.x=TRUE);
vill_cm <- vill_c[!is.na(vill_c$name),]
str(vill_cm)

# 取出没有匹配的部分
vill_c <- merge(vill, vill_m, by.x='code', by.y='code', all.x=TRUE);
vill_n <- vill_c[is.na(vill_c$adcode_t),]
vill_n$adcode <- vill_n$adcode.x
vill_n <- vill_n[,-c(7,8,9)]
str(vill_n)
write.csv(vill_n, file='vill_n.csv')

