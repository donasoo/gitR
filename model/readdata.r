require(ggplot2)
require(reshape2)
require(scales)

# 读取所有数据
# 读取所有数据
# 读取所有数据
cpi <- read.csv(file = 'cpi.csv', header = TRUE, stringsAsFactors = FALSE);
yypi <- read.csv(file = 'yypi.csv', header = TRUE, stringsAsFactors = FALSE);
ywpi <- read.csv(file = 'ywpi.csv', header = TRUE, skip = 1, stringsAsFactors = FALSE);
kqpi <- read.csv(file = 'kqpi.csv', header = TRUE, stringsAsFactors = FALSE);
kqpspi <- read.csv(file = 'kqpspi.csv', header = TRUE, skip = 1, stringsAsFactors = FALSE);
kqetpi <- read.csv(file = 'kqetpi.csv', header = TRUE, skip = 1, stringsAsFactors = FALSE);
pinames <- read.csv(file = 'pinames.csv', header = TRUE, stringsAsFactors = FALSE);
tbpi <- read.csv(file = 'tbpi.csv', header = TRUE, skip = 1, stringsAsFactors = FALSE);

#cpi 选择, 定基为3， 同比为2
cpi <- cpi[, c(1, 2)];
colnames(cpi) <- c('date', 'cpi');

# 日期转换
cpi$date <- as.Date(cpi$date);
yypi$date <- as.Date(yypi$date);
ywpi$date <- as.Date(ywpi$date);
kqpi$date <- as.Date(kqpi$date);
kqpspi$date <- as.Date(kqpspi$date);
kqetpi$date <- as.Date(kqetpi$date);
tbpi$date <- as.Date(tbpi$date);

# 保留日期月份
cpi$date <- format(cpi$date, '%Y-%m');
yypi$date <- format(yypi$date, '%Y-%m');
ywpi$date <- format(ywpi$date, '%Y-%m');
kqpi$date <- format(kqpi$date, '%Y-%m');
kqpspi$date <- format(kqpspi$date, '%Y-%m');
kqetpi$date <- format(kqetpi$date, '%Y-%m');
tbpi$date <- format(tbpi$date, '%Y-%m');

# 柯桥总指数汇总到月度
kqpi <- aggregate(kqpi, list(kqpi$date), median);
kqpi$group <- paste(kqpi$Group.1, '-01', sep = '');
kqpi$date <- as.Date(kqpi$group);
kqpi$date <- format(kqpi$date, '%Y-%m');
kqpi <- kqpi[, c(-1, -4)];

# 余姚指数汇总到月度
yypi <- aggregate(yypi, list(yypi$date), median);
yypi$group <- paste(yypi$Group.1, '-01', sep = '');
yypi$date <- as.Date(yypi$group);
yypi$date <- format(yypi$date, '%Y-%m');
yypi <- yypi[, c(-1, -4)];

# 数据合并
inc=FALSE;
temp <- merge(cpi, yypi, by.x = 'date', by.y = 'date', all=inc)
temp <- merge(temp, ywpi, by.x = 'date', by.y = 'date', all=inc)
temp <- merge(temp, kqpi, by.x = 'date', by.y = 'date', all=inc)
temp <- merge(temp, kqpspi, by.x = 'date', by.y = 'date', all=inc)
temp <- merge(temp, kqetpi, by.x = 'date', by.y = 'date', all=inc)
allpi <- merge(temp, tbpi, by.x = 'date', by.y = 'date', all=inc)

smr <- summary(allpi);
write.csv(smr, file='.\\summary\\summary0.csv')
write.csv(allpi, file='.\\summary\\allpi0.csv')

# 统一基期和标准化
sl <- c(3:7, 14:16, 18:22);
allpi[, sl] <- allpi[, sl]/10;
#for (i in 2:23)
#{
#  allpi[, i] <- allpi[, i]/allpi[1, i]*100;
#}




# 再次处理成时间类型
allpi$date <- paste(allpi$date, '-01', sep = '');
allpi$date <- as.Date(allpi$date);
rownames(allpi) <- format(allpi$date, '%Y-%m');

# 数据保存
write.csv(allpi, file = '.\\summary\\allpi.csv');

# 整理名称
id <- colnames(allpi);
id <- as.data.frame(id);
pinames <- merge(id, pinames, by.x='id', by.y='id', sort=FALSE);
rownames(pinames) <- pinames$id;

smr <- summary(allpi);
write.csv(smr, file='.\\summary\\summary.csv')
write.csv(allpi, file='.\\summary\\allpi.csv')

# 保留14年数据作为外推测试,TRUE为同比，FALSE为环比
yoy <- TRUE
if(yoy){
	pi14 <- allpi[68:71, ];
	all <- allpi;
	allpi <- allpi[2:67, ];
}else{
	temppi <- allpi[2:nrow(allpi),]
	for(i in 2:23){
		temppi[, i] <- 100+diff(allpi[, i]) 
	}
	pi14 <- temppi[67:70, ];
	all <- temppi;
	allpi <- temppi[1:66, ];
}

# 日期标签
datebreaks <-seq(as.Date("2007-06-01"),as.Date("2014-06-01"),by="6 month");
breaks14 <-seq(as.Date("2014-01-01"),as.Date("2014-07-01"),by="1 month");

# 4种总指数
use <- c('date', 'cpi', 'ywcpi', 'kqpi', 'yypi', 'tbpi');
labels <- pinames[use[-1], 3];
usepi <- allpi[, use];

# 烧熔成长类型
five =FALSE
if (five){
  allpi <- usepi;
}
lusepi <- melt(usepi, id = 'date');
lallpi <- melt(allpi, id = 'date');



save.image('data.RData');