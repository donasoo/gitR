plsrplot <- function(test, pre, pngname, mname, model){
  
  result <- data.frame(date=test$date, '预测值'=as.numeric(pre), '真值'=test$cpi);
  lresult <- melt(result, id='date');
  
  # 折线图
  p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
  p <- p+geom_line(size = 1);
  p <- p+scale_shape_manual(values=c(1, 19));
  p <- p+geom_point(size = 2.5);
  p <- p+labs(x='月份', y='指数', colour='', shape='');
  p <- p + ggtitle(paste(pngname, '对比图'));
  p <- p +theme(legend.position="top");
  p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));

  filename <- paste('.\\', mname, '\\m-', pngname, '对比图(plsr).png', sep='')
  ggsave(file=filename, plot=p, width=5, height=4, dpi=100);
  filename <- paste('.\\', mname, '\\l-', pngname, '对比图(plsr).png', sep='')
  ggsave(file=filename, plot=p, width=9, height=7.5, dpi=100);
  
  
  # 黑白折线图
  p <- ggplot(lresult, aes(x=date, y=value, linetype=variable, shape = variable));
  p <- p+geom_line(size = 0.5);
  p <- p+scale_shape_manual(values=c(1, 19));
  p <- p+geom_point(size = 1.5);
  p <- p+labs(x='月份', y='指数', linetype='', shape='');
  p <- p + ggtitle(paste(pngname, '对比图'));
  p <- p +theme(legend.position="top");
  p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));

  filename <- paste('.\\', mname, '\\m-', pngname, '对比图黑白(plsr).png', sep='')
  ggsave(file=filename, plot=p, width=5, height=4, dpi=100);
  filename <- paste('.\\', mname, '\\l-', pngname, '对比图黑白(plsr).png', sep='')
  ggsave(file=filename, plot=p, width=9, height=7.5, dpi=100);
  
  # 点图
  plot(model, comps = 5, asp = 1, newdata= test, line = TRUE, main = paste(pngname, '对比点图'), xlab='真值', ylab='预测值') ;
  filename <- paste('.\\', mname, '\\m-', pngname, '对比点图(plsr).png', sep='')
  dev.copy(png,filename, width=500, height=400, bg="white");
  dev.off();
  filename <- paste('.\\', mname, '\\l-', pngname, '对比点图(plsr).png', sep='')
  dev.copy(png,filename, width=1000, height=700, bg="white");
  dev.off();
  # 计分图
  scoreplot(model, comps = 1:5, newdata= test , main='计分图') ;
  filename <- paste('.\\', mname, '\\m-', pngname, '计分图(plsr).png', sep='')
  dev.copy(png,filename, width=500, height=400, bg="white");
  dev.off();
  filename <- paste('.\\', mname, '\\l-', pngname, '计分图(plsr).png', sep='')
  dev.copy(png,filename, width=1000, height=700, bg="white");
  dev.off();
  # 相关图, 
  corrplot(model, comps = 1:5, newdata= test , main='相关图') ;
  filename <- paste('.\\', mname, '\\m-', pngname, '相关图(plsr).png', sep='')
  dev.copy(png,filename, width=500, height=400, bg="white");
  dev.off();
  filename <- paste('.\\', mname, '\\m-', pngname, '相关图(plsr).png', sep='')
  dev.copy(png,filename, width=1000, height=700, bg="white");
  dev.off();
  
  cat(pngname);
  # 误差图
  plot(model, plottype='validation', newdata= test,main = paste(pngname, '误差图'), xlab='成分数', ylab='预测均方根误差' ) ;
  filename <- paste('.\\', mname, '\\m-', pngname, '误差图(plsr).png', sep='')
  dev.copy(png,filename, width=500, height=400, bg="white");
  dev.off();
  filename <- paste('.\\', mname, '\\l-', pngname, '误差图(plsr).png', sep='')
  dev.copy(png,filename, width=1000, height=700, bg="white");
  dev.off();
  
}