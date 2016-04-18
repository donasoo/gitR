Vdata <- read.csv("E:\\gitR\\test\\report.csv", header=T,  as.is=TRUE )
str(data)
sdata1 <- aggregate(x=data$mount, by=list(as.factor(data$city), as.factor(data$grade)), FUN=sum);
sdata1
s1 <- dcast(sdata1, Group.1 ~ Group.2)  
sdata2 <- aggregate(x=data$mount, by=list(as.factor(data$city), as.factor(data$grade)), FUN=length);
s2 <- dcast(sdata2, Group.1 ~ Group.2)  
s <- merge(s1, s2, by.x="Group.1", by.y="Group.1")
s[is.na(s)] <- 0
s$x <- rowSums(s[,2:4])
s$y <- rowSums(s[,5:7])
s[12, 2:9] <- colSums(s[,2:9])

rownames(s) <- c("1","5","4","7","B","2","8","6","A","3","9","0")
s <- s[order(rownames(s)), ]
colnames(s) <- c("0","5","6","7","1","2","3","8","4")
s <- s[, order(colnames(s))]


write.csv(s, "s.csv")
