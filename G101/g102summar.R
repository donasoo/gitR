#G102 村卡汇总表生成

library(tidyverse)

g101abb <- function(grade){
  
  gradenum <- gradelist[grade]
  
  name <- c('code', str_c('C0', 1:9), str_c('C', 10:24))
  gd2 <- select(gd, X1, num_range("X", 8:31))
  colnames(gd2) <- name
  gd2l <- gather(gd2, var, value, -code) %>% mutate(zone=as.integer(code/10^gradenum)) 
  gd2s <- summarise(group_by(gd2l, zone, var, value), nvar=n())
  gd2ss <- spread(gd2s, value, nvar)
  gd2sl <- gather(gd2ss, value, nvar, -zone, -var) %>% mutate(varstr=paste(var, value, sep='_'))
  gd2sl$varstr <- str_replace(gd2sl$varstr, '<NA>', 'NA')
  gd2sls <- spread(select(ungroup(gd2sl), zone, varstr, nvar), varstr, nvar)
  
  return(gd2sls)
}

g101num <- function(grade){
  
  gradenum <- gradelist[grade]
  
  name <- c('code', str_c('C0', 25:99), str_c('C', 100:102))
  gd2 <- select(gd, X1, num_range("X", 46:123))
  colnames(gd2) <- name
  gd2l <- gather(gd2, var, value, -code) %>% mutate(zone=as.integer(code/10^gradenum)) 
  gd2s <- summarise(group_by(filter(gd2l, is.na(value)), zone, var, group="1n_na"), value=n())
  gd2s <- gd2s%>%bind_rows(summarise(group_by(filter(gd2l, !is.na(value)), zone, var, group="2n_notna"), value=n()))
  gd2s <- gd2s%>%bind_rows(summarise(group_by(filter(gd2l, value<0.005), zone, var, group="3n_eq0"), value=n()))
  gd2s <- gd2s%>%bind_rows(summarise(group_by(gd2l, zone, var, group="4sum"), value=sum(value, na.rm = T)))
  gd2s <- gd2s%>%bind_rows(summarise(group_by(gd2l, zone, var, group="5mean"), value=mean(value, na.rm = T)))
  gd2s <- gd2s%>%bind_rows(summarise(group_by(gd2l, zone, var, group="6median"), value=median(value, na.rm = T)))
  gd2s <- gd2s%>%bind_rows(summarise(group_by(gd2l, zone, var, group="7max"), value=max(value, na.rm = T)))
  gd2s <- gd2s%>%bind_rows(summarise(group_by(filter(gd2l, value>0), zone, var, group="8min"), value=min(value, na.rm = T)))
  
  gd2s <- ungroup(gd2s)
  gd2ss <- spread(gd2s, group, value)
  gd2ssl <- gather(gd2ss,group,value, -zone, -var) %>% 
    mutate(vargroup=paste(vargroup=paste(var, group, sep = "_"))) %>%
    select(zone, vargroup, value)
  
  gd2sss <- spread(gd2ssl, vargroup, value)
  
  return(gd2sss)
}

g101cnd <- function(){
  name <- c('code', 'CUN', 'XIANG', 'SHENG', 'SHI','XIAN'  ,'charger')
  gd30 <- select(gd, num_range("X", 1:6), X32)
  colnames(gd30) <- name
  
  gd3s <- data_frame()
  for(grade in gradename){
    gradenum <- gradelist[grade]
    gd3 <- select(gd30, code, name=grade, charger)
    gd3 <- mutate(gd3, zone=as.integer(code/10^gradenum), charger=as.integer(!is.na(charger)))
    gd3s <- gd3s %>% bind_rows(summarise(group_by(gd3, zone), name=first(name),nc0=n(), nc1=sum(charger)))
  }
  gd3s <- mutate(gd3s, time=format(Sys.time(), "%Y年 %b %d日 %a %H:%M:%S "), deal=zone)
  gd3s[is.na(gd3s$name),'name'] <- '空'
  return(gd3s)
}



gd <- read_csv('G102.33.00.csv', skip=1, col_names = F,  locale=locale(encoding = 'GB18030') )
gd <- filter(gd, !is.na(X32))
gradename <- c('XIANG', 'SHENG', 'SHI','XIAN')
gradelist <- c(3,10,8,6)
names(gradelist) <- gradename
gd3s <- g101cnd()
gd4 <- data_frame()
gd5 <- data_frame()
for(zone in gradename){
  gd4 <- bind_rows(gd4, g101abb(zone))
  gd5 <- bind_rows(gd5, g101num(zone))
}

gd4 <- do.call(data.frame,lapply(gd4, function(x) replace(x, is.nan(x),NA)))
gd4 <- do.call(data.frame,lapply(gd4, function(x) replace(x, is.infinite(x),NA)))

gd5 <- do.call(data.frame,lapply(gd5, function(x) replace(x, is.nan(x),NA)))
gd5 <- do.call(data.frame,lapply(gd5, function(x) replace(x, is.infinite(x),NA)))

write.csv(left_join(gd3s, gd4, by='zone') , 'gd_abb.csv', na='', row.names = F)
write.csv(left_join(gd3s, gd5, by='zone'), 'gd_num.csv', na='', row.names=F)

