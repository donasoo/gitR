

require(nnet);
require(DMwR);
require(reshape2);
require(ggplot2);
require(car);
require(scales);




mplot <- function(test, pre, name)
{
  result <- data.frame(date=test$date, '预测值'=as.numeric(pre), '真值'=test$cpi);
  lresult <- melt(result, id='date');
  
  # 折线图
  p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
  p <- p+geom_line(size = 1);
  p <- p+scale_shape_manual(values=c(1, 19));
  p <- p+geom_point(size = 2.5);
  p <- p+labs(x='月份', y='指数', colour='', shape='');
  p <- p + ggtitle(paste(name, '对比图'));
  p <- p +theme(legend.position="top");
  p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
  p
  ggsave(file=paste('m-', name, '对比图(bpnn).png'), plot=p, width=5, height=4, dpi=100);
  ggsave(file=paste('l-', name, '对比图(bpnn).png'), plot=p, width=9, height=7.5, dpi=100);
  
  cat(paste(name, '\n'));
  # 点图
  plot(pre ~ test$cpi, main=paste(name, '对比点图'), xlab='真值', ylab='预测值')
  abline(0, 1, lty = 2)
  dev.copy(png,filename=paste('m-', name, '对比点图(bpnn).png'), width=500, height=400, bg="white");
  dev.off();
  dev.copy(png,filename=paste('l-', name, '对比点图(bpnn).png'), width=1000, height=700, bg="white");
  dev.off();
  print(p)
}





# 做一次nn的函数
do <- function(train, test, name)
{
  model <- nnet(cpi~., train, size = 2 , decay = 2, maxit = 300,  linout = T, trace = F)

  prd <- predict(model, test);
  
  mplot(test, prd, name);
   
  # 保存误差
  error <- regr.eval(test$cpi, prd, train.y = train$cpi);
  
  cat('误差\n')
  print(error)
  
  out <- list('error'=error, 'predict'=prd)
  return (out);
}



load('E:\\gitR\\model\\data.RData');
# 折参数
begin =1;
end = nrow(allpi);
step = 11;
seq <- seq(begin, end, step);
len <- length(seq);

set.seed(3127);

# 结果list
lp <- matrix(0, nrow=8, ncol=8);
le <- matrix(0, nrow=len+3, ncol=6);
pre <- seq(end);



## 分折交叉验证


# 分折进行提升算法建模预测
for (i in 1:(length(seq)))
{
  t <- seq[i]:(seq[i]+step-1);
  
  pi.test <- allpi[t, c(-23)];
  pi.train <- allpi[-t, c(-1, -23)];
  
  name = paste('第', as.character(i), '折交叉验证');

  out <- do(train=pi.train, test=pi.test, name);
  le[i, ] <- out$error;
  
  
  pre[(i*step-step+1):(i*step)] <- out$predict;
  
}

## 分折总体 

  mplot(allpi, pre, '分折总体');  

## 用训练集作为测试 
# 分折总体误差
le[len+1, ] <- regr.eval(allpi$cpi, pre, train.y = allpi$cpi);
# 用训练集作为测试 
out <- do(train=allpi[, c(-1, -23)], test=allpi[, c( -23)], '训练集作为测试集');
le[len+2, ] <- out$error;


#预测
outp <- do(train=allpi[, c(-1, -23)], test=pi14[, c( -23)], '外推预测');
le[len+3, ] <- outp$error;
mplot(pi14[, c( -23)], outp$predict, '外推预测');


## 总体误差
names <- seq(len+3);
for(i in 1:len){
    name <- paste('第', i, '折', seq='');
    names[i]=name;
  }
names[(len+1):(len+3)] <- c('测试集总体', '训练集总体', '外推预测');
rownames(le) <- names;
colnames(le) <- names(out$error)
print(le)
write.csv(le, file = 'error-bpnn.csv');


## 拟合和预测结果
result <- data.frame(date=c(allpi$date, pi14$date), '真值'=c(allpi$cpi, pi14$cpi), '拟合值'=c(as.numeric(out$predict), as.numeric(outp$predict)), '分折预测值'=c(as.numeric(pre), as.numeric(outp$predict)));
result$'拟合误差' <- abs(result$'拟合值'-result$'真值');
result$'预测误差' <- abs(result$'拟合值'-result$'真值');
result$'拟合相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
result$'预测相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
#print(result)
write.csv(result, file = 'result-bpnn.csv');


