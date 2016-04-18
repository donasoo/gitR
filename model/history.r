t
source('E:/gitR/model/mining.R')
source('E:/gitR/model/mining.R')
source('E:/gitR/model/mining.R')
source('E:/gitR/model/mining.R')
p
source('E:/gitR/model/mining.R')
p
str(allpi)
source('E:/gitR/model/mining.R')
p
seq(1, 53, 12)
seq(64, 1, 12)
seq(64, 1, -12)
head(usepi)
seq(8, 64, 12)
usepi
seq(8, 64, 12)
seq(1, 64, 12)
seq(4, 64, 12)
seq(1, 64, 8)
eval <- regr.eval(tpi$cpi, pre.forest, train.y = xpi$cpi);
str(eval)
title(paste('第', 'as', "we"))
paste('第', 'as', "we")
str
str(p)
list(p=p)
l[ <- list(p=p)
lp <- list(p=p)
lp$p
lp <- list(as.character(5)=p)
lp <- list(paste('l'+as.character(5))=p)
lp <- list(paste('l',as.character(5))=p)
lp <- list(paste('okok'=p)
lp <- list('okok'=p)
lp <- list('okok'=p)
lp
paste('l',as.character(5)
)
paste('l',as.character(5), sep='')
lp <- list(paste('l',as.character(5), sep='')=p)
paste('l',as.character(5), sep='')
lp <- list(paste('l',as.character(5), sep='')=p)
name <- paste('l',as.character(5), sep='')
lp <- list(name=p)
lp
lp[1]
lp[2]
list()
l <- list()
l
l[1] <- p
l <- list(NULL, NULL)
l
l[1] <- p
l[[1]] <- p
l
l <- list()
l[[1]] <- p
l
str(l)
l[[2]] <- p
l
l
l[[2]] <- p2
l
seq(1, 64, 8)
a <- seq(1, 64, 8)
dim(a)
length(a)
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
le
write.csv(le, file='le.csv')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
lp
lp[[4]]
le
lp[[5]]
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
source.with.encoding('E:/gitR/model/mining.R', encoding='UTF-8')
lp
tpi <- allpi[, c(-23)];
xpi <- allpi[, c(-23)];
model.forest <- randomForest(cpi ~ ., data =xpi);
pre.forest <- predict(model.forest, tpi);
result <- data.frame(date=tpi$date, '预测值'=pre.forest, '真值'=tpi$cpi);
lresult <- melt(result, id='date');
# 折线图
p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line();
p <- p+geom_point();
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + ggtitle(paste('第', as.character(i), '折交叉验证对比图'));
p <- p +theme(legend.position="top");
p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
lp[[i]] <- p;
plot(pre.forest~ tpi$cpi, main = paste('第', as.character(i), '折交叉验证点图'), xlab='真值', ylab='预测值');
tpi <- allpi[, c(-23)];
xpi <- allpi[, c(-23)];
model.forest <- randomForest(cpi ~ ., data =xpi);
pre.forest <- predict(model.forest, tpi);
result <- data.frame(date=tpi$date, '预测值'=pre.forest, '真值'=tpi$cpi);
lresult <- melt(result, id='date');
# 折线图
p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line();
p <- p+geom_point();
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p +theme(legend.position="top");
p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
lp[[i]] <- p;
plot(pre.forest~ tpi$cpi,  xlab='真值', ylab='预测值');
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
lsplot
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
lsplot
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
labels
p5
p5
lsplot
tpi <- allpi[, c(-23)];
xpi <- allpi[, c(-23)];
model.forest <- randomForest(cpi ~ ., data =xpi);
pre.forest <- predict(model.forest, tpi);
result <- data.frame(date=tpi$date, '预测值'=pre.forest, '真值'=tpi$cpi);
lresult <- melt(result, id='date');
# 折线图
p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line();
p <- p+geom_point();
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p +theme(legend.position="top");
p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
lp[[i]] <- p;
plot(pre.forest~ tpi$cpi,  xlab='真值', ylab='预测值');
regr.eval(tpi$cpi, pre.forest, train.y = xpi$cpi);
le <- regr.eval(tpi$cpi, pre.forest, train.y = xpi$cpi);
write.csv(le, file = 'rf-eval.csv');
install.package('C50')
install.packages('C50')
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p+geom_line(size = .5)
p+geom_line(size = .8)
p <- p+geom_line(size = .8)
p <- p+geom_line(size = 1)
p
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1);
p <- p+geom_point();
p <- p + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) +
theme(axis.text.x =element_text(angle=30,hjust=1));
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + scale_colour_hue(labels = labels);
p <- p + scale_shape(labels = labels);
p <- p +theme(legend.position="top");
p
p+geom_point(size = 1);
p+geom_point(size = 2);
p+geom_point(size = 5);
p+geom_point(size = 3);
p+scale_shape_manual(values=c(1:4))
p+scale_shape_manual(values=c(1, 2, 3, 5))
p+scale_shape_manual(values=c(1, 2, 3, 6))
p+scale_shape_manual(values=c(1, 2, 3, 7))
p+scale_shape_manual(values=c(1, 2, 3, 8))
p+scale_shape_manual(values=c(1, 2, 3, 9))
p+scale_shape_manual(values=c(1, 2, 3, 10))
p+scale_shape_manual(values=c(1, 4, 17, 20))
p+scale_shape_manual(values=c(1, 4, 17, 19))
p+geom_point(size = 3);
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1.2);
p <- p+geom_point(size  = 3);
p <- p+scale_shape_manual(values=c(1, 4, 17, 19));
p <- p + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) +
theme(axis.text.x =element_text(angle=30,hjust=1));
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + scale_colour_hue(labels = labels);
p <- p + scale_shape(labels = labels);
p <- p +theme(legend.position="top");
p
p+scale_shape_manual(values=c(1, 4, 17, 19));
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1.2);
p <- p+scale_shape_manual(values=c(1, 4, 17, 19));
p <- p+geom_point(size  = 3);
p <- p + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) +
theme(axis.text.x =element_text(angle=30,hjust=1));
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + scale_colour_hue(labels = labels);
#p <- p + scale_shape(labels = labels);
p <- p +theme(legend.position="top");
p
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1.2);
p <- p+scale_shape_manual(values=c(1, 4, 17, 19));
p <- p+geom_point(size  = 3);
p <- p + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) +
theme(axis.text.x =element_text(angle=30,hjust=1));
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + scale_colour_hue(labels = labels);
p <- p +theme(legend.position="top");
p
p <- p + scale_shape(labels = labels);
p + scale_shape(labels = labels)
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1.2);
p
p+scale_shape_manual(values=c(1, 4, 17, 19));
p
p <- p+geom_point(size  = 3)
p
p+scale_shape_manual(values=c(1, 4, 17, 19))
p + scale_shape(labels = labels)
p + scale_shape(labels = labels, values=c(1, 4, 17, 19))
p+scale_shape_manual(values=c(1, 4, 17, 19), labels=labels)
p <- ggplot(lusepi, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1.2);
p <- p+scale_shape_manual(values=c(1, 4, 17, 19), labels = labels);
p <- p+geom_point(size  = 3);
p <- p + scale_x_date(breaks=datebreaks, labels = date_format('%y%b')) +
theme(axis.text.x =element_text(angle=30,hjust=1));
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + scale_colour_hue(labels = labels);
p <- p +theme(legend.position="top");
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1);
p <- p+geom_point(size = 3);
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + ggtitle(paste('第', as.character(i), '折交叉验证对比图'));
p <- p +theme(legend.position="top");
p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
p
p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1);
p <- p+scale_shape_manual(values=c(1, 8));
p <- p+geom_point(size = 3);
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + ggtitle(paste('第', as.character(i), '折交叉验证对比图'));
p <- p +theme(legend.position="top");
p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
p
p+scale_shape_manual(values=c(19, 8));
p+scale_shape_manual(values=c(19, 1));
source.with.encoding('E:/gitR/model/mining-rf.R', encoding='UTF-8')
lp
lp
lp
tpi <- allpi[, c(-23)];
xpi <- allpi[, c(-23)];
model.forest <- randomForest(cpi ~ ., data =xpi);
pre.forest <- predict(model.forest, tpi);
result <- data.frame(date=tpi$date, '预测值'=pre.forest, '真值'=tpi$cpi);
lresult <- melt(result, id='date');
# 折线图
p <- ggplot(lresult, aes(x=date, y=value, colour=variable, shape = variable));
p <- p+geom_line(size = 1);
p <- p+scale_shape_manual(values=c(1, 19));
p <- p+geom_point(size = 3);
p <- p+labs(x='月份', y='指数', colour='', shape='');
p <- p + ggtitle(paste('第', as.character(i), '折交叉验证对比图'));
p <- p +theme(legend.position="top");
p <- p + scale_x_date(labels = date_format('%y%b')) + theme(axis.text.x =element_text(angle=30,hjust=1));
lp[[i]] <- p;
plot(pre.forest~ tpi$cpi, main = paste('第', as.character(i), '折交叉验证点图'), xlab='真值', ylab='预测值');
p
p <- p + ggtitle(paste(''));
p
p <- ggplot(lusepi,aes(variable,value,color=variable))
p + geom_point(position='jitter')+
geom_violin(alpha=0.4)
p <- ggplot(lusepi,aes(variable,value,color=variable))
p + geom_point(position='jitter')+
geom_violin(alpha=0.4, size =1)
p3 <- ggplot(lusepi, aes(x = variable, y=value,  fill=variable));
p3 <- p3 + geom_violin();
p3 <- p3 + geom_boxplot(width=.1, position=position_dodge(width=0), fill = NULL);
p3 <- p3+labs(x='', y='指数', fill='');
p3 <- p3 + scale_fill_discrete(labels = labels);
p3 <- p3 + scale_x_discrete(labels = labels);
p3 <- p3 +theme(legend.position="top");
p3
p3 <- ggplot(lusepi, aes(x = variable, y=value,  fill=variable));
p3 <- p3 + geom_violin();
p3 <- p3 + geom_boxplot(width=.1, position=position_dodge(width=0), colour = variable);
p3 <- p3+labs(x='', y='指数', fill='');
p3 <- p3 + scale_fill_discrete(labels = labels);
p3 <- p3 + scale_x_discrete(labels = labels);
p3 <- p3 +theme(legend.position="top");
p3
p3 + geom_boxplot(colour = variable)
p3 + geom_boxplot(position=position_dodge(width=0), colour = variable);
p3 <- ggplot(lusepi, aes(x = variable, y=value,  fill=variable));
p3 <- p3 + geom_violin();
p3 <- p3 + geom_boxplot(width=.1, position=position_dodge(width=0));
p3 <- p3+labs(x='', y='指数', fill='');
p3 <- p3 + scale_fill_discrete(labels = labels);
p3 <- p3 + scale_x_discrete(labels = labels);
p3 <- p3 +theme(legend.position="top");
p3
p <- ggplot(lusepi, aes(variable,value,color=variable));
> p + geom_point(position='jitter') + geom_violin(alpha=0.4, size =1).
p <- ggplot(lusepi, aes(variable,value,color=variable));
> p + geom_point(position='jitter') + geom_violin(alpha=0.4, size =1)
p <- ggplot(lusepi, aes(variable,value,color=variable));
p <- p + geom_point(position='jitter') + geom_violin(alpha=0.4, size =1)
p
p + scale_x_discrete(labels = labels);
p+labs(x='', y='指数', fill='')
p <- p+labs(x='', y='指数', fill='');
p
p <- p + scale_x_discrete(labels = labels);
p
p <- p + scale_fill_discrete(labels = labels);
p
p <- p + scale_colour_discrete(labels = labels);
p
p <- p+labs(x='', y='指数', colour='');
p
p +theme(legend.position="top");
p <- ggplot(lusepi, aes(variable,value,color=variable));
p <- p + geom_point(position='jitter') + geom_violin(alpha=0.4, size =1)
p <- p+labs(x='', y='指数', colour='');
p <- p + scale_colour_discrete(labels = labels);
p <- p +theme(legend.position="top");
p
p <- ggplot(lusepi, aes(variable,value,color=variable));
p <- p + geom_point(position='jitter') + geom_violin(alpha=0.4, size =1)
p <- p+labs(x='', y='指数', colour='');
p <- p + scale_colour_discrete(labels = labels);
p <- p +theme(legend.position="top");
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
p <- p + scale_x_discrete(labels = labels);
p
p <- ggplot(lusepi, aes(variable,value,color=variable));
p <- p + geom_point(position='jitter') + geom_violin(alpha=0.4, size =1)
p <- p+labs(x='', y='指数', colour='');
p <- p + scale_colour_discrete(labels = labels);
p <- p + scale_x_discrete(labels = labels);
p <- p +theme(legend.position="top");
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p
source.with.encoding('E:/gitR/model/plot.R', encoding='UTF-8')
p7
p3 <- p3 + geom_boxplot(width=.1, position=position_dodge(width=0), colour= variable);
require(C50)
data(churn)
model.c <- C5.0(churn~.,data=train)
pre <- predict(model.c,test[,-20])
res.c[,,i] <- as.matrix(table(pre,test[ ,20]))
head(churn)
head(churnTrain)
model.c <- C5.0(churn~.,data=churnTrain)
pre <- predict(model.c, churnTest)
head(pre)
as.matrix(table(pre,churnTest[ ,20]))
table(pre,churnTest[ ,20])
a <- table(pre,churnTest[ ,20])
source.with.encoding('E:/gitR/model/readdata.r', encoding='UTF-8')
model.c <- C5.0(cpi~.,data=allpi)
model.tree=rpart(cpi ~ ., data = allpi)
library(rpart)
model.tree=rpart(cpi ~ ., data = allpi)
pre.tree <- predict(model.tree, allpi)
plot(pre.tree~allpi$cpi)
install.packages('mboost')
lm(cpi ~., data =allpi[, -23])
model.boost <- lm(cpi ~., data =allpi[, -23])
coef(model.boost)
bsfm
mod <- mboost(DEXfat ~ btree(age) + bols(waistcirc) + bbs(hipcirc),
data = bodyfat)
library(mboost)
mod <- mboost(DEXfat ~ btree(age) + bols(waistcirc) + bbs(hipcirc),
data = bodyfat)
data("bodyfat", package = "TH.data")
mstop(model.boost)
mb <- mboost(cpi ~., data =allpi[, -23])
mb <- mboost(cpi ~., data =allpi[, c(-1,-23)])
mstop(mb)
predict(mb, allpi[, c(-1,-23)])
pmb <- predict(mb, allpi[, c(-1,-23)])
plot(allpi$cpi~pmb)
library(tseries)
install.packages('tseries')
library(tseries)
adf.test(allpi$cpi)
? adf.test
x <- rnorm(1000)  # no unit-root
adf.test(x)
y <- diffinv(x)
adf.test(y)
plot(y)
plot(x)
plot(allpi$cpi)
plot(y)
y <- diffinv(x)
plot(y)
y <- diffinv(allpi$cpi)
plot(y)
x <- 1:100
plot(x)
y <- diffinv(x)
plot(y)
install.packages('pls')
p <- plsr(cpi~., ncomp= 5, data=allpi[, -23])
require(pls)
p <- plsr(cpi~., ncomp= 5, data=allpi[, -23])
p
str(p)
p$coefficients
loading.weights(p)
summary(p)
p <- plsr(cpi~.,  data=allpi[, -23])
summary(p)
plot(p)
plot(p, plottype = "coef", comps = 1:2, labels = "names", main = "Coefficient plot")
plot(p,  line = TRUE)
predict(p.model, allpi[, -23])
predict(p$model, allpi[, -23])
? predict
p$model
p <- plsr(cpi~.,  data=allpi[, -23], validation ='CV')
p
plot(p)
p <- plsr(cpi~.,  data=allpi[, -23], validation ='LOO')
plot(p)
p <- plsr(cpi~.,  data=allpi[, -23])
plot(p)
predict(p, ncomp=5, allpi[, -23])
pre <- predict(p, ncomp=5, allpi[, -23])
plot(pre, allpi$cpi)
plot(p)
pre <- predict(p, ncomp=5, allpi[, -23], 'CV')
pre <- predict(p, ncomp=5, allpi[, -23], validation='CV')
p <- plsr(cpi~.,  data=allpi[, -23], validation='CV')
plot(p)
summary(p)
R2(p)
plot(R2(p),legendpos = "topright")
plot(R2(p))
MSEP(p)
RMSEP(p)
msc(p)
mvr(p)
preplot(p)
scoreplot(p)
score(p)
scor(p)
scores(p)
plot(RMSEP(p))
RMSEP(p)
1.49/1.51
10488/1.511
1.488/1.511
detach("package:C50", unload=TRUE)
library("C50", lib.loc="d:/Program Files/R/R-3.1.0/library")
model.boost <- mboost(cpi~., data=allpi[, -23])
model.boost <- mboost(cpi~., data=allpi[, c(-1, -23)])
model.boost <- mboost(cpi~., data=allpi[, -23])
predict(model.boost data=allpi[, c(-1, -23)])
predict(model.boost,  data=allpi[, c(-1, -23)])
predict.boost <- predict(model.boost,  data=allpi[, c(-1, -23)])
plot(predict.boost~allpi$cpi)
savehistory("E:/gitR/model/history.r")
