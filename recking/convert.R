cropConvert <- function(year, season){

load("convert.RData")
season <-'Q1'
#读入样本地块数据
smpclass <- c(rep("character", 3), rep("numeric", 42), rep("character", 6))
smpcrop <- read.csv('smpcrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=smpclass)
smpcrop <- smpcrop[,-12]
colnames(smpcrop) <- name
str(smpcrop)
smpcrop$c0 <- rowSums(smpcrop[,13:24])
smpcrop$v10 <- rowSums(smpcrop[,c('v101', 'v102', 'v103', 'v104')])
smpcrop$v11 <- rowSums(smpcrop[,c('v111', 'v112')])
smpcrop$v10 <- rowSums(smpcrop[,c(27:36,41,44)])
smpcrop$season <- season
#读入功能区数据
fzclass <- c(rep("character", 3), rep("numeric", 42), rep("character", 5))
fzcrop <- read.csv('fzcrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=fzclass)
fzcrop <- fzcrop[,-12]
fzcrop$z6 <-""
colnames(fzcrop) <- name
str(fzcrop)
fzcrop$c0 <- rowSums(fzcrop[,13:24])
fzcrop$v10 <- rowSums(fzcrop[,c('v101', 'v102', 'v103', 'v104')])
fzcrop$v11 <- rowSums(fzcrop[,c('v111', 'v112')])
fzcrop$v10 <- rowSums(fzcrop[,c(27:36,41,44)])
fzcrop$season <- season
#读入生产单位数据
coclass <- c(rep("character", 3), rep("numeric", 42), rep("character", 3))
cocrop <- read.csv('cocrop.csv', header = FALSE, stringsAsFactors=FALSE, skip=1, colClasses=coclass)
cocrop <- cocrop[,-12]
cocrop$z4 <-""
cocrop$z5 <-""
cocrop$z6 <-""
colnames(cocrop) <- name
str(cocrop)
cocrop$c0 <- rowSums(cocrop[,13:24])
cocrop$v10 <- rowSums(cocrop[,c('v101', 'v102', 'v103', 'v104')])
cocrop$v11 <- rowSums(cocrop[,c('v111', 'v112')])
cocrop$v10 <- rowSums(cocrop[,c(27:36,41,44)])
cocrop$season <- season
name <-read.table("clipboard")
name <- name[,1]
name <- as.character(name)

if( is.element('cocrop2016', ls())){
  cocrop2016 <- rbind(cocrop2016, cocrop)
  fzcrop2016 <- rbind(fzcrop2016, fzcrop)
  smpcrop2016 <- rbind(smpcrop2016, smpcrop)
}else{
  cocrop2016 <- cocrop
  fzcrop2016 <- fzcrop
  smpcrop2016 <- smpcrop
}

save(cocrop2016, fzcrop2016, smpcrop2016, file = "crop2016.RData")

}