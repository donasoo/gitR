require(nnet);
require(DMwR);

decay <- seq(0, 10, by=2);
ld <- length(decay)
maxit <- seq(100, 1000, by=100)
lx <- length(maxit)
train=allpi[, c(-1, -23)]

mx <- matrix(data=0, nrow=lx*ld, ncol=3)
head(mx)

for(i in 1:ld)
{
  for(j in 1:lx)
  {
    model <- nnet(cpi~., train, size = 10, decay = decay[i], maxit = maxit[j], linout = T, trace = F)
    pk <- predict(model, train)
    e <- regr.eval(train$cpi, pk, train.y = train$cpi);
    mx[(i-1)*lx+j, ] <- c(decay[i], maxit[j], e[5])
    print(paste('total:', ld, lx, 'now', i, j))
  }
}


colnames(mx) <- c('decay', 'maxit', 'nmse')
mx <- as.data.frame(mx)

p <- ggplot(data = mx, aes(x=maxit, y=decay, size=nmse))
p <- p + geom_point() + labs(x='maxit值', y='decay值', size='误差');
p <- p + scale_x_continuous(breaks = maxit)
p <- p + scale_y_continuous(breaks = decay)
print(p)
ggsave(file='m-参数(bpnn).png', plot=p, width=5, height=4, dpi=100);
ggsave(file='l-参数(bpnn).png', plot=p, width=9, height=7.5, dpi=100);

