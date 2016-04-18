
require(kernlab);
require(DMwR);
require(reshape2);
require(ggplot2);
require(car);
require(scales);

minning <- function(mname){
  
  # 初始化
  load('E:\\gitR\\model\\data.RData');
# 折参数
begin =1;
end = nrow(allpi);
step = 11;
seq <- seq(begin, end, step);
len <- length(seq);
sl <- c(-24)

  
  # 结果list
  le <- matrix(0, nrow=len+3, ncol=6);
  pre <- seq(end);
  
  ## 8折交叉验证
  
  # 分折进行提升算法建模预测
  for (i in 1:(length(seq)))
  {
    t <- seq[i]:(seq[i]+step-1);
    
    pi.test <- allpi[t, sl];
    pi.train <- allpi[-t, sl];
    
    name = paste('第', as.character(i), '折交叉验证');
    
    out <- mmodel(train=pi.train, test=pi.test, name, mname, 0);
    le[i, ] <- out$error;
    pre[(i*step-step+1):(i*step)] <- out$predict;
  }

  # 6折总体误差
  le[len+1, ] <- regr.eval(allpi$cpi, pre, train.y = allpi$cpi);
  mplot(allpi, pre, '6折交叉验证', mname)
  # 用训练集作为测试 
  out <- mmodel(train=allpi[, sl], test=allpi[, sl], '估计值与真值', mname);
  le[len+2, ] <- out$error;
  
  
  #预测
  outp <- mmodel(train=allpi[, sl], test=pi14[, sl], '外推预测', mname);
  le[len+3, ] <- outp$error;
  #mplot(pi14[, c( -23)], outp$predict, '外推预测', mname);
  
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
  filename <- paste('.\\', mname, '\\error(', mname, ').csv', sep='');
  write.csv(le, file = filename);
  
  
result <- data.frame(date=c(allpi$date, pi14$date), '真值'=c(allpi$cpi, pi14$cpi), '拟合值'=c(as.numeric(out$predict), as.numeric(outp$predict)), '分折预测值'=c(as.numeric(pre), as.numeric(outp$predict)));
result$'拟合误差' <- abs(result$'拟合值'-result$'真值');
result$'预测误差' <- abs(result$'拟合值'-result$'真值');
result$'拟合相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
result$'预测相对误差' <- abs(result$'拟合值'-result$'真值')/result$'真值';
  filename <- paste('.\\', mname, '\\result(', mname, ').csv', sep='');
  write.csv(result, file = filename);
  
}