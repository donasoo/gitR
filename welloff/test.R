filename <- 'e:/gitR/welloff/first.xlsx';
data=read.xlsx(file=filename, sheetIndex=1, startRow=2, header=FALSE)
prefix <- 'e:/gitR/welloff/'
suffix <- '.xls'
for(index in 3301:3311){
  filename <- paste(prefix, index, sep='')
  filename <- paste(filename, suffix, sep='')
  data1=read.xlsx(file=filename, sheetIndex=1, startRow=5, header=FALSE)
  data <- rbind(data, data1)
}

data2 <- data[!is.na(data$X3), ]
data2 <- data[data2$X3 > 0, ]