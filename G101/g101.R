# g101 data dp

library(tidyverse)

gzvar <- read_csv('g101var.csv', locale=locale(encoding = 'GB18030'))

gzd <- read_csv('G101.33.00.csv', col_names = F, skip =1, locale=locale(encoding = 'GB18030'))
colnames(gzd) <- gzvar$varid


gzd <- mutate(gzd,
              Z01=as.factor(Z01),
              Z02=as.factor(Z02),
              Z03=as.factor(Z03),
              Z04=as.factor(Z04),
              Z05=as.factor(Z05),
              Z06=as.factor(Z06),
              Z00=str_sub(as.character(Z00), 1, 9),
              code=Z00)

varnames <- gzvar
allplotdata <- gzd
plotcol <- c('Z00', 'Z07', 'Z01', 'Z19')
zoneid <- '331082'
plotsingle(zoneid, plotcol)
