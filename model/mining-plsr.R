# data mining with plsr V1.0  Author:Guan 2014-07-28
# 提升法用于指数的数据挖掘

# 所需的包
require(pls);
require(DMwR);

# 做一次plsr的函数
doplsr <- function(train, test, name)
{
  model.plsr <- plsr(cpi ~ ., data =train, ncomp=5, validation = "LOO");
  
  pre.plsr <- predict(model.plsr, ncomp=5, newdata=test);
  
  result <- data.frame(date=test$date, '预测值'=as.numeric(pre.plsr), '真值'=test$cpi);
  lresult <- melt(result, id='date');
  
  # 折线图
  p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
  p <- p+geom_line(size = 1);
  p <- p+scale_shape_manual(values=c(1, 20));
  p <- p+geom_point(size = 2);
  p <- p+labs(x='月份', y='指数', colour='', shape='');
  p <- p + ggtitle(paste(name, '对比图'));
  p <- p +theme(legend.position="top");
  p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
  ggsave(file=paste('m-', name, '对比图(plsr).png'), plot=p, width=5, height=4, dpi=100);
  ggsave(file=paste('l-', name, '对比图(plsr).png'), plot=p, width=9, height=7.5, dpi=100);
  p;
  
  # 点图
  plot(model.plsr, comps = 5, asp = 1, newdata= test, line = TRUE, main = paste(name, '对比点图'), xlab='真值', ylab='预测值') ;
  dev.copy(png,filename=paste('m-', name, '对比点图(plsr).png'), width=500, height=400, bg="white");
  dev.off();
  dev.copy(png,filename=paste('l-', name, '对比点图(plsr).png'), width=1000, height=700, bg="white");
  dev.off();
    # 计分图
  scoreplot(model.plsr, comps = 1:5, newdata= test ) ;
  dev.copy(png,filename=paste('m-', name, '计分图(plsr).png'), width=500, height=400, bg="white");
  dev.off();
  dev.copy(png,filename=paste('l-', name, '计分图(plsr).png'), width=1000, height=700, bg="white");
  dev.off();
    # 相关图
  corrplot(model.plsr, comps = 1:5, newdata= test ) ;
  dev.copy(png,filename=paste('m-', name, '相关图(plsr).png'), width=500, height=400, bg="white");
  dev.off();
  dev.copy(png,filename=paste('l-', name, '相关图(plsr).png'), width=1000, height=700, bg="white");
  dev.off();
    # 误差图
  plot(model.plsr, plottype='validation', newdata= test,main = paste(name, '误差图'), xlab='成分数', ylab='预测均方根误差' ) ;
  dev.copy(png,filename=paste('m-', name, '误差图(plsr).png'), width=500, height=400, bg="white");
  dev.off();
  dev.copy(png,filename=paste('l-', name, '误差图(plsr).png'), width=1000, height=700, bg="white");
  dev.off();
  # 保存误差
  error <- regr.eval(test$cpi, pre.plsr, train.y = train$cpi);
  return (error);
}

# 折参数
begin =1;
end = 64;
step = 8;
seq <- seq(begin, end, step);

# 结果list
lp <- list();
le <- list();


# 分折进行提升算法建模预测
for (i in 1:(length(seq)))
{
  t <- seq[i]:(seq[i]+step-1);
  
  pi.test <- allpi[t, c(-23)];
  pi.train <- allpi[-t, c(-1, -23)];
  
  name = paste('第', as.character(i), '折交叉验证');
  le[[length(le)+1]] <- doplsr(train=pi.train, test=pi.test, name);
}

le[['traintest']] <- doplsr(train=allpi[, c(-1, -23)], test=allpi[, c( -23)], '训练集作为测试集');

write.csv(le, file = 'inner-plsr-eval.csv');