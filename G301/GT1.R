# 读入综合报表指标、单位和代码
filename <- 'G301-2.csv';
g1 <- read.csv(file = filename, header = TRUE, stringsAsFactors = FALSE);

#读入各市综合报表，并合并
for( city in 3301:3311){
  
  filename <- paste(as.character(city), '.csv', sep="");
  rcdata <- read.csv(file = filename, header = TRUE, stringsAsFactors = FALSE);
  rcdata <- rcdata[, c(-1, -2)];
  colnames(rcdata)[1]='id';
  rcdata <- rcdata[!is.na(rcdata$id),];
  g1 <- merge(g1, rcdata, by.x='id', by.y='id');
}

files <- c('APV.csv', 
           'farmland.csv', 
           'machinery.csv', 
           'protected agriculture.csv', 
           'farm chemicals.csv', 
           'irrigation.csv', 
           'area planted.csv', 
           'certified seed.csv',  
           'PRODUCTION.csv', 
           'aquatic product.csv');

#读入字典库
filename <- 'dic.csv';
dic <- read.csv(file = filename, header = TRUE, stringsAsFactors = TRUE);
g2 <- dic;
len <- length(files)


# 各农业专业数据，并合并
for(i in 1:len){
  filename <- files[i];
  print(filename);
  rcdata <- read.csv(file = filename, header = TRUE, stringsAsFactors = TRUE, skip=1);
  names <- colnames(rcdata);
  rcdata <- aggregate(rcdata[, -1], list(county = rcdata$county), sum, na.rm=TRUE);
  colnames(rcdata) <- names;
  g2 <- merge(g2, rcdata, by.x='county', by.y='county');

}

# 执行单位转化
#  国土 耕地数据，从亩到公顷
g2$C34 <- g2$C34/15;

#  水利，灌溉面积从千公顷到公顷
g2$C40 <- g2$C40*1000;

#  农机， 农业机械总动力，从千瓦，到万千瓦
g2$C36 <- g2$C36/10000;

#  农机， 机收面积， 从千公顷， 到公顷
g2$C42 <- g2$C42*1000;


#读入G101县卡指标配置
filename <- 'G101config.csv';
gc101 <- read.csv(file = filename, header = TRUE, stringsAsFactors = FALSE);

g12 <- merge(gc101, g1, , by.x='id', by.y='id');

ptn <- '[-—-－#VALUE!:：]';
for(i in 8:ncol(g12)){
  
  g12[, i] <- gsub(ptn, '', g12[, i]);
}

write.csv(g12, 'g12.csv');

filename <- 'g12.csv';
g12 <- read.csv(file = filename, header = TRUE, stringsAsFactors = FALSE);
str(g12)
