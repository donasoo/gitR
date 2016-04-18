#读取本年当季种植数据
#存在crop.RData中
#分为 cocrop fzcrop smpcrop
#具体格式见《格式.xls》
cropConvert <- function(smp, co, fz, out){

load("convert.RData")
#读入样本地块数据
smpclass <- c(rep("character", 3), rep("numeric", 42), rep("character", 6))
smpcrop <- read.csv(paste(smp,'.csv', sep=''), header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=smpclass)
smpcrop <- smpcrop[,-12]
colnames(smpcrop) <- name
smpcrop$c0 <- rowSums(smpcrop[,13:24])
smpcrop$v10 <- rowSums(smpcrop[,c('v101', 'v102', 'v103', 'v104')])
smpcrop$v11 <- rowSums(smpcrop[,c('v111', 'v112')])
smpcrop$v10 <- rowSums(smpcrop[,c(27:36,41,44)])
#读入功能区数据
fzclass <- c(rep("character", 3), rep("numeric", 42), rep("character", 5))
fzcrop <- read.csv(paste(fz,'.csv', sep=''), header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=fzclass)
fzcrop <- fzcrop[,-12]
fzcrop$z6 <-""
colnames(fzcrop) <- name
fzcrop$c0 <- rowSums(fzcrop[,13:24])
fzcrop$v10 <- rowSums(fzcrop[,c('v101', 'v102', 'v103', 'v104')])
fzcrop$v11 <- rowSums(fzcrop[,c('v111', 'v112')])
fzcrop$v10 <- rowSums(fzcrop[,c(27:36,41,44)])
#读入生产单位数据
coclass <- c(rep("character", 3), rep("numeric", 42), rep("character", 3))
cocrop <- read.csv(paste(co,'.csv', sep=''), header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=coclass)
cocrop <- cocrop[,-12]
cocrop$z4 <-""
cocrop$z5 <-""
cocrop$z6 <-""
colnames(cocrop) <- name
cocrop$c0 <- rowSums(cocrop[,13:24])
cocrop$v10 <- rowSums(cocrop[,c('v101', 'v102', 'v103', 'v104')])
cocrop$v11 <- rowSums(cocrop[,c('v111', 'v112')])
cocrop$v10 <- rowSums(cocrop[,c(27:36,41,44)])

save(cocrop, fzcrop, smpcrop, file = paste(out,'.RData', sep=''))

}