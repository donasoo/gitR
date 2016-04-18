fnfum <- function(fnfum1, fnfum2)
{
# 读入公式1
#fnfum1 <-'fump1'
#fnfum2 <- 'fump2'
fum1 <- read.csv(paste(fnfum1,'.csv', sep=''), header = TRUE, stringsAsFactors=FALSE)
str(fum1)
fum1$fum11 <- substr(fum1$fum1, 1, 3)
fum1$fum12 <- substr(fum1$fum1, 5, nchar(fum1$fum1))
fum1 <- fum1[, c('fum11', 'fum12')]
fum2 <- read.csv(paste(fnfum2,'.csv', sep=''), header = TRUE, stringsAsFactors=FALSE)
fum2$rowid <- 1:nrow(fum2)
str(fum2)
fum <-merge(fum1, fum2)
str(fum)
head(fum)
fum$fum <- paste(fum$fum11, as.character(fum$rowid), sep='')
str(fum)
fum$fum <- paste(fum$fum, fum$fum12, sep='')
str(fum)
fum$fum <- paste(fum$fum, fum$fum2, sep='')
fumout <- fum[, 'fum']
write.csv(fum, 'fum.csv')
write(fumout, 'fumout.txt')
}