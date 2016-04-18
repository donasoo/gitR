
require(kernlab);
require(DMwR);
require(reshape2);
require(ggplot2);
require(car);
require(scales);

# 初始化
load('E:\\gitR\\model\\data.RData');
# 折参数
fold=6;
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

## 8折交叉验证

# 分折进行提升算法建模预测
for (i in 1:(length(seq)))
{
  t <- seq[i]:(seq[i]+step-1);
  
  pi.test <- allpi[t, c(-23)];
  pi.train <- allpi[-t, c( -23)];
  
  name = paste('第', as.character(i), '折交叉验证');
  
  out <- mmodel(train=pi.train, test=pi.test, name, 0);
  le[i, ] <- out$error;
  pre[(i*step-step+1):(i*step)] <- out$predict;
}
## 8折总体 


## 用训练集作为测试 

# 8折总体误差
le[len+1, ] <- regr.eval(allpi$cpi, pre, train.y = allpi$cpi);
# 用训练集作为测试 
out <- mmodel(train=allpi[, c( -23)], test=allpi[, c( -23)], '训练集作为测试集');
le[len+2, ] <- out$error;


## 拟合和预测结果
result <- data.frame(date=allpi$date, '真值'=allpi$cpi, '拟合值'=as.numeric(out$predict), '分折预测值'=as.numeric(pre));
result$'拟合误差' <- abs(result$'拟合值'-result$'真值');
result$'预测误差' <- abs(result$'拟合值'-result$'真值');
result$'拟合相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
result$'预测相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
#print(result)
write.csv(result, file = 'result-svm.csv');


#预测
outp <- mmodel(train=allpi[, c(-1, -23)], test=pi14[, c( -23)], '外推预测');
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
write.csv(le, file = 'error-svm.csv');


result <- data.frame(date=c(allpi$date, pi14$date), '真值'=c(allpi$cpi, pi14$cpi), '拟合值'=c(as.numeric(out$predict), as.numeric(outp$predict)), '分折预测值'=c(as.numeric(pre), as.numeric(outp$predict)));
result$'拟合误差' <- abs(result$'拟合值'-result$'真值');
result$'预测误差' <- abs(result$'拟合值'-result$'真值');
result$'拟合相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
result$'预测相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';

