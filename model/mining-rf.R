
require(randomForest);
require(DMwR);
require(reshape2);
require(ggplot2);
require(car);
require(scales);


# 做一次rf的函数
dorf <- function(train, test, name, parameter)
{ 
  set.seed(3721)
  model.rf <- randomForest(cpi ~ ., data =train, mtry=parameter[1], ntree=parameter[2]);
  
  pre.rf <- predict(model.rf,  newdata=test);
  nmse <- regr.eval(test$cpi, pre.rf, train.y = train$cpi, stats='nmse');
  
  r <- list(pre=pre.rf, nmse=nmse)
  return (r);
  
}


# 折参数

sl <- c(-23)

set.seed(3127);

# 结果list
lp <- matrix(0, nrow=8, ncol=8);
le <- matrix(0, nrow=len+3, ncol=6);



# 分折进行提升算法建模预测
fold <- function(parameter){
  begin =1;
  end = nrow(allpi);
  step = 11;
  seq <- seq(begin, end, step);
  len <- length(seq);
le <- matrix(0, nrow=len+3, ncol=6);
pre <- seq(end);
for (i in 1:(length(seq)))
{
  t <- seq[i]:(seq[i]+step-1);
  
  pi.test <- allpi[t, c(-23)];
  pi.train <- allpi[-t, sl];
  
  name = paste('第', as.character(i), '折交叉验证');
  
  out <- dorf(train=pi.train, test=pi.test, name, parameter);
  
  pre[(i*step-step+1):(i*step)] <- out$pre;
  
}
nmse <- regr.eval(allpi$cpi, pre, train.y = allpi$cpi, stats='nmse');
return (nmse)
}

mt <- seq(10, 100, 10);
nt <- seq(100, 1000, 100);
para <- merge(mt, nt);
para[, 3] =0;
para <- as.matrix(para)
colnames(para) <- c('mtry', 'ntree', 'nmse')
lp =nrow(para);
for(i in 1:lp){
  print(para[i, ])
  out <- dorf(allpi[, -23], pi14, '', para[i, ])
  para[i, 3] <- out$nmse
}

para <- as.data.frame(para)
p <- ggplot(data = para, aes(x=mtry, y=ntree, size=nmse))
p <- p + geom_point() + labs(x='随机采样变量数', y='树个数', size='nmse');
p <- p + scale_x_continuous(breaks = mt)
p <- p + scale_y_continuous(breaks = nt)
print(p)
write.csv(para, 'parameter-pre(rf).csv')
ggsave(file='m-预测参数选择图(rf).png', plot=p, width=5, height=4, dpi=100);
ggsave(file='l-预测参数选择图(rf).png', plot=p, width=9, height=7.5, dpi=100);

