# data mining with boosting V1.0  Author:Guan 2014-07-25
# 提升法用于指数的数据挖掘

# 所需的包
require(mboost);
require(DMwR);
require(reshape2)



# 做一次boost的函数
doboost <- function(train, test, name)
{
  model.boost <- mboost(cpi ~ ., data =train);

  pre.boost <- predict(model.boost, test);

  result <- data.frame(date=test$date, '预测值'=pre.boost, '真值'=test$cpi);
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
  ggsave(file=paste('m-', name, '对比图(boost).png'), plot=p, width=5, height=4, dpi=100);
  ggsave(file=paste('l-', name, '对比图(boost).png'), plot=p, width=9, height=7.5, dpi=100);

  # 点图
  plot(pre.boost ~ test$cpi, main = paste(name, '对比点图'), xlab='真值', ylab='预测值');
  dev.copy(png,filename=paste('m-', name, '对比点图(boost).png'), width=500, height=400, bg="white");
  dev.off();
  dev.copy(png,filename=paste('l-', name, '对比点图(boost).png'), width=1000, height=700, bg="white");
  dev.off();
  # 保存误差
  error <- regr.eval(test$cpi, pre.boost, train.y = train$cpi);
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
  le[[length(le)+1]] <- doboost(train=pi.train, test=pi.test, name);
}

le[['traintest']] <- doboost(train=allpi[, c(-1, -23)], test=allpi[, c( -23)], '训练集作为测试集');

write.csv(le, file = 'inner-boost-eval.csv');