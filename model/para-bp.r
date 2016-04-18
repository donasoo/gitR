
require(nnet);
require(DMwR);
require(reshape2);
require(ggplot2);
require(car);
require(scales);

# 做一次nn的函数
do <- function(train, test, name, para)
{
  set.seed(3721)
  #model <- randomForest(cpi ~ ., data =train, mtry=para[1], ntree=para[2]);
  model <- ksvm(cpi~., data=train, kernel='anovadot', type='eps-svr', epsilon=para[1], C=para[2]);
  prd <- predict(model, test);
  er <- regr.eval(test$cpi, prd, train.y = train$cpi, stats='nmse');
  #er <- nmse(prd, test$cpi)
  
  out <- list(pre=prd, nmse=er);
  return (out);
}

dofold <- function(para)
{

# 折参数
begin =1;
end = nrow(allpi);
step = 11;
seq <- seq(begin, end, step);
len <- length(seq);
  pre <- seq(end);
  for (i in 1:len)
  {
  t <- seq[i]:(seq[i]+step-1);

  pi.test <- allpi[t, c(-23)];
  pi.train <- allpi[-t, c(-1, -23)];
  
  name = paste('第', as.character(i), '折交叉验证');

  out <- do(train=pi.train, test=pi.test, name, para);

  pre[(i*step-step+1):(i*step)] <- out$pre;
}
  er <- regr.eval(allpi$cpi, pre, train.y = allpi$cpi, stats='nmse');

  out <- list(nmse=er);
  return (out)

}

p1 <- seq(0.01, 0.1, by=0.01)
p2 <- seq(5, 50, by=5);
para <- merge(p1, p2)
lp <- nrow(para);

para[, 3] <- 0;
para[, 4] <- 0;
colnames(para) <- c('x', 'y', 'z', 'nmse');
para <- as.matrix(para);
lp <- nrow(para);

for(i in 1:lp){

  print(para[i, ]);
  #out <- do(allpi, allpi, '', para[i, ]);
  out <- dofold(para[i, ]);
  para[i, 4]=out$nmse;

}

para <- as.data.frame(para)
para <- as.data.frame(para)
write.csv(para, '.\\svm\\交叉验证参数(svm).csv')


py <- seq(0, 50, by=10);
px <- seq(0,0.1,0.02)
p <- ggplot(data = para, aes(x=x, y=y,  size=nmse))
p <- p + theme_bw();
p <- p + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p <- p + theme(panel.grid.major.x=element_blank())
p <- p + theme(legend.position=c(0.85,0.84));
p <- p + theme(legend.key=element_rect(colour=NA, fill=NA));
p <- p + geom_point() + labs(x='epsilon', y='C', size='');
p <- p + scale_x_continuous(breaks = px)
p <- p + scale_y_continuous(breaks = py)
print(p)
 
 ggsave(file='.\\svm\\m-交叉验证参数(svm).png', plot=p, width=3, height=4, dpi=100);
 ggsave(file='.\\svm\\l-交叉验证参数(svm).png', plot=p, width=9, height=7.5, dpi=100);
 
