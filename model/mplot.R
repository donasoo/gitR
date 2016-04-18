
mplot <- function(test, pre, pngname, mname)
{
ybreaks <- seq(60, 160, 20)
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
  p
  filename <- paste('.\\', mname, '\\m-', pngname, '对比图(', mname, ').png', sep='')
  ggsave(filename, plot=p, width=5, height=4, dpi=100);
  filename <- paste('.\\', mname, '\\l-', pngname, '对比图(', mname, ').png', sep='')
  ggsave(filename, plot=p, width=9, height=7.5, dpi=100);
  
  # 黑白折线图
p <- ggplot(lresult, aes(x=date, y=value, linetype=variable));
p <- p + theme_bw();
p <- p + theme(panel.grid.major.y=element_line(colour="grey",linetype="dashed",size=0.2))
p <- p + theme(panel.grid.major.x=element_blank())
p <- p + theme(legend.position=c(0.85,0.77));
p <- p + theme(legend.key=element_rect(colour=NA, fill=NA));
p <- p + geom_line(size = 0.6);
p <- p + labs(x='年度', y='指数',  linetype='');
  filename <- paste('.\\', mname, '\\m-', pngname, '对比图黑白(', mname, ').png', sep='')
  ggsave(filename, plot=p, width=5, height=4, dpi=100);
  filename <- paste('.\\', mname, '\\l-', pngname, '对比图黑白(', mname, ').png', sep='')
  ggsave(filename, plot=p, width=9, height=7.5, dpi=100);
  
  cat(paste(pngname, '\n'));
  # 点图
  plot(pre ~ test$cpi, main=paste(pngname, '对比点图'), xlab='真值', ylab='预测值')
  abline(0, 1, lty = 2)
  filename <- paste('.\\', mname, '\\m-', pngname, '对比点图(', mname, ').png', sep='')
  dev.copy(png,filename=filename, width=500, height=400, bg="white");
  dev.off();
  filename <- paste('.\\', mname, '\\l-', pngname, '对比点图(', mname, ').png', sep='')
  dev.copy(png,filename=filename, width=1000, height=700, bg="white");
  dev.off();
  print(p)
}