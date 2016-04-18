#==============================
#读入数据并进行必要的预处理
#==============================

#读入核实表（table2.csv）数据
t2class <- c(rep("numeric", 2), "character", rep("numeric", 3))
t2 <- read.csv('table2.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=t2class)

#读入样本地块数据
smpclass <- c(rep("character", 2), rep("numeric", 49))
smpcrop <- read.csv('smpcrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=smpclass)



#上年样本区数据
smpcrop_1 <- read.csv('smpcrop-1.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=smpclass)

#读入功能区数据
fzclass <- c(rep("character", 2), rep("numeric", 46), rep("character", 2))
fzcrop <- read.csv('fzcrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=fzclass)
#fzcrop <- seasonfilter(fzcrop, 3)
fzcrop_1 <- read.csv('fzcrop-1.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=fzclass)
#fzland <- read.csv('fzland14.csv', header = TRUE, stringsAsFactors=FALSE)
#读入生产单位数据
coclass <- c(rep("character", 2), rep("numeric", 46))
cocrop <- read.csv('cocrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=coclass)
#cocrop <- seasonfilter(cocrop, 3)
cocrop_1 <- read.csv('cocrop-1.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=coclass)

#三种种植数据的粮食部分按照夏季重新加总
#读入市级耕地数据
plough <- read.csv('plough.csv', header = TRUE, stringsAsFactors=FALSE)


#读入减少系数（逐年各市分层）
reduce <- read.csv('reduce.csv', header = TRUE, stringsAsFactors=FALSE)

#读入方案初耕地数（各市分层）
land_0 <- read.csv('land_0.csv', header = TRUE, stringsAsFactors=FALSE)

#读入核实系数（各市分层）
verify <- read.csv('verify.csv', header = TRUE, stringsAsFactors=FALSE)

#读入套种间作和周边零星系数（分市）
clri <- read.csv('clri.csv', header = TRUE, stringsAsFactors=FALSE)
clri[is.na(clri)] <- 0


#读入品种名称
identifiers <- read.csv('identifiers.csv', header = FALSE, stringsAsFactors=FALSE)
identifiers <- identifiers[,1]

units <- read.csv('units.csv', header = FALSE, stringsAsFactors=FALSE)
units <- units[, 1]
