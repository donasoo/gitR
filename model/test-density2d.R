require(kernlab);
require(DMwR);


p1 <- seq(0.005, 0.1, by=0.005);
p2 <- seq(1, 51, by=5)
para <- merge(p1, p2)
lp <- nrow(para);
para[, 3]=0;
d=allpi[, ]

mx <- matrix(data=0, nrow=lc*leps, ncol=3)
head(mx)

for(i in 1:lc)
{
  for(j in 1:leps)
  {
    model <- ksvm(cpi~., data=d, kernel='anovadot', type='eps-svr', C=c[i], epsilon=eps[j])
    pk <- predict(model, d)
    e <- regr.eval(d$cpi, pk, train.y = d$cpi);
    mx[(i-1)*leps+j, ] <- c(c[i], eps[j], e[5])
    print(paste(i, j))
  }
}


colnames(mx) <- c('c', 'eps', 'nmse')
mx <- as.data.frame(mx)

p <- ggplot(data = mx, aes(x=c, y=eps, size=nmse))
p <- p + geom_point() + labs(x='C值', y='epsilon值', size='误差');
p
