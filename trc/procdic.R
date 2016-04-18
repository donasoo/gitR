#  读入14年字典库
dic14 <- read.csv('dic14.csv', header = TRUE, stringsAsFactors=FALSE, colClasses=c(rep("character",2)))
str(dic14)

sdic14 <- dic14
sdic14$code1 <- paste(substr(sdic14$adcode, 1, 4), '00000000', sep='')
sdic14$code2 <- paste(substr(sdic14$adcode, 1, 6), '000000', sep='')
sdic14$code3 <- paste(substr(sdic14$adcode, 1, 9), '000', sep='')
sdic14$code4 <- sdic14$adcode

sdic14 <- merge(sdic14, dic14, by.x='code1', by.y="adcode", all.x=TRUE)
colnames(sdic14)[ncol(sdic14)] <- 'name1'
str(sdic14)
sdic14 <- merge(sdic14, dic14, by.x='code2', by.y="adcode", all.x=TRUE)
colnames(sdic14)[ncol(sdic14)] <- 'name2'
str(sdic14)
sdic14 <- merge(sdic14, dic14, by.x='code3', by.y="adcode", all.x=TRUE)
colnames(sdic14)[ncol(sdic14)] <- 'name3'
str(sdic14)
sdic14 <- merge(sdic14, dic14, by.x='code4', by.y="adcode", all.x=TRUE)
colnames(sdic14)[ncol(sdic14)] <- 'name4'
colnames(sdic14)[colnames(sdic14) == 'name.x'] <- 'name'
str(sdic14)
sdic14$class <- 'vill'
sdic14[sdic14$name == sdic14$name3, 'class']='town'
sdic14[sdic14$name == sdic14$name2, 'class']='county'
sdic14[sdic14$name == sdic14$name1, 'class']='city'
sdic14[sdic14$class == 'city', c('name2', 'name3', 'name4')]=''
sdic14[sdic14$class == 'county', c('name3', 'name4')]=''
sdic14[sdic14$class == 'town', 'name4']=''
write.csv(sdic14, file='sdic14.csv')

