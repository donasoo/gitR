#xumu

library(tidyverse)
library(stringr)

gbunit <- read_csv('gbunit.csv',  locale=locale(encoding = 'GB18030'))

A308 <- read_csv('A308.csv',  locale=locale(encoding = 'GB18030'))
A308city <- filter(A308, str_sub(code, 5, 6)=='00')
A308county <- filter(A308, str_sub(code, 5, 6)!='00')
A308s <- summarise(group_by(A308county, code=as.integer(code/100)), silk15=sum(silk15, na.rm = T), silk16=sum(silk16, na.rm = T), silk17=sum(silk17, na.rm = T))


A308c <- left_join(A308city, A308s, by='X2')%>% mutate(X4=X4.x-X4.y, X5=X5.x-X5.y, X6=X6.x-X6.y)


A312 <- read_csv('A312.csv', locale=locale(encoding = 'GB18030'))
A312name <- read_csv('A312.csv',n_max=1, col_names = F, locale=locale(encoding = 'GB18030'))

A312city <- filter(A312, str_sub(code, 5, 6)=='00')%>%mutate(X2=as.integer(X2/100000))
A312county <- filter(A312, str_sub(code, 5, 6)!='00')
A312county[is.na(A312county)] <- 0
A312s <- aggregate(x=A312county[,3:14], by=list(city=as.integer(A312county$code/100)), FUN=sum)
A312s.l <- gather(A312s, key=var, value=value, city)
A312s <- spread(A312s.l, var, value)
A312city.l <- gather(select(A312city, -X1, -X3), key=var, value=value, -X2)
A312name <- gather(A312name, key=var, value=value)

A312c <- left_join(A312city.l, A312s.l,  by=c('X2','var')) %>% left_join(A312name, by='var')
A312c2 <- filter(A312c, value.x != value.y) %>% mutate(c=value.x- value.y, x=c>0.1)
A312c3 <- filter(A312c, abs(value.x- value.y) >0.01)


write.csv(A312s, 'A312s.csv')

a3 <- full_join(A312, A308, by='code') 
anti_join(a3, gbunit, by='code')
write.csv(a3, 'a3.csv', row.names = F, na='')


aout <- read_csv('a.csv',  locale=locale(encoding = 'GB18030'))
aout[is.na(aout)] <- 0
aout.county <- filter(aout, str_sub(code, 5,6)!='00')

a3s <- aggregate(x=aout.county[,3:17], by=list(city=as.integer(aout.county$code/100)), FUN=sum)
write.csv(a3s, 'a3s.csv')

a3ss <- aggregate(x=aout.county[,3:17], by=list(code=aout.county$code), FUN=sum)

ga3 <- full_join(gbunit, a3ss, by='code') %>% arrange(index)
write.csv(ga3, 'ga3.csv', na='', row.names = F)

al <- gather(aout, var, value, -parent, -code, -name)
als <- summarise(group_by(al, parent, var), value=sum(value, na.rm = T))
ac <- spread(als, var, value)



ym <- read_csv('ym.csv',  locale=locale(encoding = 'GB18030'))
ym[is.na(ym)] <- 0
ym.county <- filter(ym, str_sub(code, 5,6)!='00')

yms <- aggregate(x=ym.county[,3:8], by=list(code=ym.county$code), FUN=sum)

gym <- full_join(gbunit, yms, by='code') %>% arrange(index)
write.csv(ga3, 'ga3.csv', na='', row.names = F)













al.tatol <- summarise(group_by(al.county,var), value=sum(value, na.rm = T))


