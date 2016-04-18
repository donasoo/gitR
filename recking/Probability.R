#test 测试
x <- smpcrop[,c(4,13:25)]
x[is.na(x)] <- 0
x$V13 <- rowSums(x[,3:14], na.rm=TRUE)
x <- x$V13/x$V4
x[is.na(x)] <- 0
hi <- 0.1:0.1:1
hist(x, freq = FALSE, col = "gray")
lines(density(x), col="red", lwd=2)
