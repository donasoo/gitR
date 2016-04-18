#测试 绘图
library(ggplot2)
str(mpg)

p <- ggplot(data=mpg, mapping=aes(x=cty, y=hwy))
p + geom_point()

summary(p+geom_point())

p <- ggplot(data=mpg, mapping=aes(x=cty, y=hwy, colour=factor(year)))
p+geom_point()+stat_smooth()

p <- ggplot(data=mpg, mapping=aes(x=cty, y=hwy))
p + geom_point(aes(colour=factor(year), size=displ), alpha=0.5, position="jitter")+
  stat_smooth()+
  scale_color_manual(values = c("blue2", "red4"))+
  scale_size_continuous(range = c(4, 10))+
  coord_cartesian(xlim=c(15,25), ylim=c(10, 40))

p + geom_point(aes(colour=class, size=displ), alpha=0.5, position="jitter")+
  stat_smooth()+
  scale_size_continuous(range = c(4, 10))+
  facet_wrap(~year, ncol=1)+
  opts(title='汽车油耗与型号')+
  labs(x='每加仑城市公路行驶距离', y='每加仑高速公路行驶距离')+
  guides(size=guide_legend(title="排量"), colour=guide_legend(title='车型'), override.aes=list(size=5))


##############  hist 直方图
p <- ggplot(mpg, mapping = aes(x=hwy))
p+geom_histogram(aes(fill=factor(year), y=..density..), alpha=0.3, colour="black")+
  stat_density(geom = 'line', position = "identity", size=1.5, aes(colour=factor(year)))+
  facet_wrap(~year, ncol=1)

##############  bar pie 柱状图 圆饼图
p <- ggplot(mpg, aes(x=class))
p+geom_bar()
class2 <- mpg$class
class2 <- reorder(class2, class2, length)
mpg$class2 <-class2
p <- ggplot(mpg, aes(x=class2))
p+geom_bar(aes(fill=class2))

p <- ggplot(mpg, aes(class2, fill=factor(year)))
p+geom_bar(aes(fill=class2))+facet_wrap(~year)

p <- ggplot(mpg, aes(x=factor(1), fill=factor(class)))
p +  geom_bar(width = 1)
p +  geom_bar(width = 1)+coord_polar(theta = 'y')


## box violin  箱线图  提琴图
p <- ggplot(mpg, aes(x=class, y=hwy, fill=class))
p+geom_boxplot()
p+geom_violin(alpha=0.3, width=0.9)+geom_jitter(shape=21)

## 高密度点图
str(diamonds)
p <- ggplot(diamonds, aes(x=carat, price))
p+geom_point()
p+stat_bin2d(bins = 60)
p+stat_density2d(aes(fill=..level..), geom = 'polygon')+
  coord_cartesian(xlim = c(0, 1.5), ylim = c(0, 6000))+
  scale_fill_continuous(high='red2', low='blue4')

#wind  风速风向
dir <- cut_interval(runif(100,0,360), n=16)
mag <- cut_interval(rgamma(100,15),4)
sample <- data.frame(dir=dir, mag=mag)
p <- ggplot(sample, mapping=aes(x=dir, y=..count.., fill=mag))
p+geom_bar()+coord_polar()












