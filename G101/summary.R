library(tidyverse)
library(stringr)

data.o <- read_csv('G101.33.00.csv', skip=1, col_names = F)
data.o <- read_csv('G101.45.00.csv', skip=1, col_names = F)



names <- c('ACODE', 'ANAME', 'D001', 'D009', 'D011', 'D010', 'D006', 'D012', 
           paste('Z', 1:12, sep=''), 
           paste('D0', 13:99, sep=''), 
           paste('D', 100:120, sep=''),
           'APROS')
colnames(data.o) <- names;

data.1 <- select(data.o, ACODE, ANAME, starts_with('D'))
data.2 <- select(data.1, -D001, -D009, -D011, -D010, -D006, -D012)


datal.2 <- gather(data.2, index, value, -ACODE, -ANAME)

datas.2 <- group_by(datal.2, index)
sdata.2 <- summarise(datas.2, sum=sum(value, na.rm=T), len=n(), max=max(value, na.rm=T), min=min(value, na.rm=T))

sdata.21 <- left_join(sdata.2, datal.2, by=c('index'='index', 'max'='value'))
sdata.22 <- left_join(sdata.21, datal.2, suffix=c('.max', '.min'), by=c('index'='index', 'min'='value'))

sdata.23 <- summarise(group_by(sdata.22, index), 
                      sum=first(sum), len=first(len), max=first(max), min=first(min),
                      ACODE.max=first(ACODE.max), ANAME.max=first(ANAME.max),
                      ACODE.min=first(ACODE.min), ANAME.min=first(ANAME.min))

write_csv(sdata.23, 's23.45.csv' )


data.3 <- select(data.1,  ACODE, ANAME, D001, D006, D009,  D010, D011,  D012)
datal.3 <- gather(data.3, index, value, -ACODE, - ANAME) %>% mutate(value=as.factor(value))
sdata.3 <- as.data.frame(table(datal.3$index, datal.3$value))

sdata.4 <- filter(sdata.3,  !(Var1 %in% c('D009', 'D010', 'D011', 'D012') & Var2!=1))
sdata.4 <- filter(sdata.4,  !(Var1 =='D006' & Var2 %in% 4:5))

write_csv(arrange(sdata.4, Var1, Var2), 's4.45.csv' )
