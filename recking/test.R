data<-read.table(file="clipboard",sep="\t",header=T)
typename<-read.table(file="clipboard",sep="\t",header=T)
data <- merge(data, typename, by.x='type', by.y='type')
str(data)
head(data)
p <- ggplot(data, aes(x=distance, y=radio, colour=as.factor(type)));
p <- p+geom_point(size = 5)
label <- c('滴滴高奖','滴滴平奖', '滴滴无奖', '优步平奖', '优步高奖')
week <- c('日','一','二','三','四','五','六')
p<- p+scale_colour_manual(values=rainbow(), labels = label);
p + scale_color_discrete(labels=label)
p <- p+labs(x='距离', y='每公里总收入', colour='类型');
p




p <- p + stat_smooth()