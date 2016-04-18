# 读入综合报表处理结果
filename <- 'g12.csv';
g12 <- read.csv(file = filename, header = TRUE, stringsAsFactors = FALSE);
str(g12)

# 需要乘以10000的指标
rowid <- c(5,9,10,11,82,90,91,92,110,112)
g12[g12$G101id %in% rowid, 9:92] <- g12[g12$G101id %in% rowid, 9:92 ]*10000;
# 读入区划数据


filename <- 'administration.csv';
admin <- read.csv(file = filename, header = TRUE, stringsAsFactors = FALSE, skip = 1);
admin[is.na(admin)] <- 0

g13 <- t(as.matrix(g12[, 9:92]))
g13 <- as.data.frame(g13)
colnames(g13) <- paste('C', g12$G101id, sep='')
g13$county <- as.factor(rownames(g13))
str(g13)
g30 <- merge(g2, g13, by.x='county', by.y='county')
g31 <- merge(g30, admin, by.x='countyid', by.y='countyid')


g32 <- g31[, c(-1, -2)]
index <- as.numeric(sub('C', '', colnames(g32)))
g32<-  g32[, order(index)]
g32 <- cbind(g31[,1:2], g32)

# 小数位
need <- c(1, 6,7,8,34,36,103,116,137,138,139)
need <- need+2
g32[,need] <- round(g32[,need], 2)
g32[,-c(1,2,need)] <- round(g32[,-c(1,2,need)], 0)


write.csv(g32, 'g32.csv', na='')
