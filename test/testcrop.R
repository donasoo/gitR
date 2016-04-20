library(ggplot2)
library(reshape2)

#读入样本地块数据
smpclass <- c(rep("character", 2), rep("numeric", 49))
smpcrop <- read.csv('smpcrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=smpclass)
smpcrop$V13 <-rowSums(smpcrop[,c(14:25)], na.rm=TRUE)
smpcrop$V27 <- rowSums(smpcrop[,c(26,28:37,42,45)] , na.rm=TRUE)
smpcrop.d <- smpcrop[, 4:45]/smpcrop[, 4]
mcrop <- melt(smpcrop.d)
mcrop1 <- mcrop[mcrop$variable %in% c("V13","V27"),]
mcrop2 <- mcrop[mcrop$variable==c("V13"),]

# 箱线图
p.box <- ggplot(mcrop1, aes(x = variable, y=value,  fill =variable));
p.box <- p.box + geom_boxplot(notch = TRUE);
p.box <- p.box+labs(x='', y='复种指数', fill='');
p.box <- p.box + scale_fill_discrete(labels = labels);
p.box <- p.box +theme(legend.position="top");
 p.box;

# 提琴图
p.voilinbox <- ggplot(mcrop1, aes(x = variable, y=value,  fill=variable));
p.voilinbox <- p.voilinbox + geom_violin();
p.voilinbox <- p.voilinbox + geom_boxplot(width=.1, position=position_dodge(width=0));
p.voilinbox <- p.voilinbox+labs(x='', y='复种指数', fill='');
p.voilinbox <- p.voilinbox +theme(legend.position="top");
 p.voilinbox;

# voilin jitter
p.voilinjitter <- ggplot(mcrop1, aes(variable,value,color=variable));
p.voilinjitter <- p.voilinjitter + geom_point(position='jitter', shape = 20) + geom_violin(alpha=0.4, size =1)
p.voilinjitter <- p.voilinjitter + labs(x='', y='复种指数', colour='');
p.voilinjitter <- p.voilinjitter + theme(legend.position="top");
 p.voilinjitter;

# 密度图
p.density <- ggplot(mcrop1, aes(value, colour=variable, fill=variable));
p.density <- p.density + geom_density(alpha = 0.3);
p.density <- p.density+labs(x='指数', y='密度', colour='', fill='');
p.density <- p.density +theme(legend.position="top");
p.density