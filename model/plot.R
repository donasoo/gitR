require(car)
require(corrgram)
require(ggplot2)

list.plot <- list();

# 折线图
p.serial <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p.serial <- p.serial+geom_line(size = 1);
p.serial <- p.serial+scale_shape_manual(values=c(1, 4, 17, 19, 8), labels = labels);
p.serial <- p.serial+geom_point(size  = 2);
p.serial <- p.serial + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) + 
  theme(axis.text.x =element_text(angle=30,hjust=1));
p.serial <- p.serial + labs(x='月份', y='指数', colour='', shape='');
p.serial <- p.serial + scale_colour_hue(labels = labels);
p.serial <- p.serial +theme(legend.position="top");
ggsave(file='.\\summary\\m-4个总指数序列图.png', plot=p.serial, width=5, height=4, dpi=100);
ggsave(file='.\\summary\\l-4个总指数序列图.png', plot=p.serial, width=9, height=7.5, dpi=100);
list.plot[[1]] <- p.serial;
p.serial
# 黑白折线图
p.serialb <- ggplot(lusepi, aes(x=date, y=value, shape = variable, linetype=variable));
p.serialb <- p.serialb+geom_line(size = 0.5);
p.serialb <- p.serialb+scale_shape_manual(values=c(1, 4, 17, 19, 8), labels = labels);
p.serialb <- p.serialb+geom_point(size  = 1.5);
p.serialb <- p.serialb + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) + 
  theme(axis.text.x =element_text(angle=30,hjust=1));
p.serialb <- p.serialb + labs(x='月份', y='指数', colour='', shape='', linetype='');
p.serialb <- p.serialb + scale_colour_hue(labels = labels);
p.serialb <- p.serialb + scale_linetype(labels = labels);
p.serialb <- p.serialb +theme(legend.position="top");
ggsave(file='.\\summary\\m-4个总指数序列图黑白.png', plot=p.serialb, width=5, height=4, dpi=100);
ggsave(file='.\\summary\\l-4个总指数序列图黑白.png', plot=p.serialb, width=9, height=7.5, dpi=100);
list.plot[[1]] <- p.serialb;

# 箱线图
p.box <- ggplot(lusepi, aes(x = variable, y=value,  fill =variable));
p.box <- p.box + geom_boxplot(notch = TRUE);
p.box <- p.box+labs(x='', y='指数', fill='');
p.box <- p.box + scale_fill_discrete(labels = labels);
p.box <- p.box + scale_x_discrete(labels = labels);
p.box <- p.box +theme(legend.position="top");
ggsave(file='.\\summary\\m-4个总指数箱图.png', plot=p.box, width=5, height=4, dpi=100);
ggsave(file='.\\summary\\l-4个总指数箱图.png', plot=p.box, width=9, height=7.5, dpi=100);
list.plot[[2]] <- p.box;

# 提琴图
p.voilinbox <- ggplot(lusepi, aes(x = variable, y=value,  fill=variable));
p.voilinbox <- p.voilinbox + geom_violin();
p.voilinbox <- p.voilinbox + geom_boxplot(width=.1, position=position_dodge(width=0));
p.voilinbox <- p.voilinbox+labs(x='', y='指数', fill='');
p.voilinbox <- p.voilinbox + scale_fill_discrete(labels = labels);
p.voilinbox <- p.voilinbox + scale_x_discrete(labels = labels);
p.voilinbox <- p.voilinbox +theme(legend.position="top");
ggsave(file='.\\summary\\m-4个总指数提琴箱图.png', plot=p.voilinbox, width=5, height=4, dpi=100);
ggsave(file='.\\summary\\l-4个总指数提琴箱图.png', plot=p.voilinbox, width=9, height=7.5, dpi=100);
list.plot[[3]] <- p.voilinbox;

# voilin jitter
p.voilinjitter <- ggplot(lusepi, aes(variable,value,color=variable));
p.voilinjitter <- p.voilinjitter + geom_point(position='jitter', shape = 20) + geom_violin(alpha=0.4, size =1)
p.voilinjitter <- p.voilinjitter + labs(x='', y='指数', colour='');
p.voilinjitter <- p.voilinjitter + scale_colour_discrete(labels = labels) + scale_x_discrete(labels = labels);
p.voilinjitter <- p.voilinjitter + theme(legend.position="top");
ggsave(file='.\\summary\\m-4个总指数提琴点图.png', plot=p.voilinjitter, width=5, height=4, dpi=100);
ggsave(file='.\\summary\\l-4个总指数提琴点图.png', plot=p.voilinjitter, width=9, height=7.5, dpi=100);
list.plot[[7]] <- p.voilinjitter;

# 密度图
p.density <- ggplot(lusepi, aes(value, colour=variable, fill=variable));
p.density <- p.density + geom_density(alpha = 0.3);
p.density <- p.density+labs(x='指数', y='密度', colour='', fill='');
p.density <- p.density + scale_colour_hue(labels = labels);
p.density <- p.density + scale_fill_discrete(labels = labels);
p.density <- p.density +theme(legend.position="top");
ggsave(file='.\\summary\\m-4个总指数密度图.png', plot=p.density, width=5, height=4, dpi=100);
ggsave(file='.\\summary\\l-4个总指数密度图.png', plot=p.density, width=9, height=7.5, dpi=100);
list.plot[[4]] <- p.density;


# 分布检验图
for (i in 2:(length(allpi)))
{
	par(mfrow=c(1,2));
	hist(allpi[, i], prob=TRUE, breaks=16, xlab='指数', ylab='密度', main='');
	lines(density(allpi[, i]));
	rug(jitter(allpi[, i]));
	qqPlot(allpi[, i], main='', xlab='', ylab='指数');
	par(mfrow=c(1, 1));
	title <- paste(pinames[colnames(allpi)[i], 2], '分布检验图');
	title(title);
	dev.copy(png,filename=paste('.\\summary\\m-', title, '.png'), width=500, height=400, bg="white");
	dev.off();
	dev.copy(png,filename=paste('.\\summary\\l-', title, '.png'), width=1000, height=700, bg="white");
	dev.off();
}

# 相关图
corrgram(usepi,labels=pinames[use[-1], 3], lower.panel=panel.pts,upper.panel=panel.conf,diag.panel=panel.density);
dev.copy(png,filename='.\\summary\\m-4总指数相关图（点字）.png', width=500, height=500, bg="white");
dev.off();
dev.copy(png,filename='.\\summary\\l-4总指数相关图（点字）.png', width=800, height=800, bg="white");
dev.off();
corrgram(allpi,labels=pinames[-1, 3], lower.panel=panel.pts,upper.panel=panel.conf,diag.panel=panel.density);
dev.copy(png,filename='.\\summary\\m-全部指数相关图（点字）.png', width=500, height=500, bg="white");
dev.off();
dev.copy(png,filename='.\\summary\\l-全部指数相关图（点字）.png', width=800, height=800, bg="white");
dev.off();
corrgram(usepi,labels=pinames[use[-1], 3], lower.panel=panel.shade,upper.panel=panel.pie,text.panel=panel.txt);
dev.copy(png,filename='.\\summary\\m-4总指数相关图（色饼）.png', width=500, height=500, bg="white");
dev.off();
dev.copy(png,filename='.\\summary\\l-4总指数相关图（色饼）.png', width=800, height=800, bg="white");
dev.off();
corrgram(allpi,labels=pinames[-1, 3], lower.panel=panel.shade,upper.panel=panel.pie,text.panel=panel.txt);
dev.copy(png,filename='.\\summary\\m-全部指数相关图（色饼）.png', width=500, height=500, bg="white");
dev.off();
dev.copy(png,filename='.\\summary\\l-全部指数相关图（色饼）.png', width=800, height=800, bg="white");
dev.off();


