# check

library(tidyverse)
library(stringr)
library(cowplot)

varname <- read_csv('varname.csv',   locale=locale(encoding = 'GB18030') ) 
gd <- read_csv('G102.33.00.csv', skip=1, col_names = F,  locale=locale(encoding = 'GB18030'))
gdl <- gather(filter(gd, !is.na(X32)), col, value, -X1)%>%
  left_join(varname, by='col') %>%
  filter(!is.na(var))%>%
  select(code=X1, var,  value) %>%
  mutate(value=as.numeric(value))

gd2 <- spread(gdl, var, value) %>%
  mutate(XA27=C027/C026*100,
         XA28=C027/C026*100,
         XA29=C027/C026*100,
         XA30=C027/C026*100,
         XA31=C027/C026*100,
         XA32=C027/C026*100,
         XA33=C027/C026*100,
         XA34=C027/C026*100,
	       XB01=C041/C035*100,
         XB02=C036/C035*100,
         XB03=C044/C038*100,
         XB04=C044/C041,
         XB05=C045/C044*100,
         XC01=C047/C046*100,
         XC02=C046/C025/15*100,
         XD11=C047/(C048+C051)*100,
         XG01=C076*666.67/C035,
         XJ01=C086/C075,
         XJ02=C091/(C055+C087)*100,
         XK01=C092/C044*100)

alldata <- gather(gd2, var, value, -code) %>%
  left_join(varname, by='var') %>%
  select(-col) %>%
  filter(is.finite(value))

vars <-  unique(alldata$var) %>%sort()
zones <- unique(str_sub(alldata$code, 1, 6)) %>%sort()

plotsingle <- function(zoneid, varid){

  plotdata <- filter(allplotdata, str_sub(code, 1, str_count(zoneid))==zoneid, var==varid) %>%
    mutate(town=str_sub(code, str_count(zoneid)+1, 12))
  
  if(nrow(plotdata)<1) {
    return()
  }
  
  path <- str_c("./G102audit/", zoneid)
  if(!file.exists(path)){
    dir.create(path)
  }

  pp <- ggplot(plotdata, aes(x=town, y=value))
  pp <- pp+ geom_point(color='#B22234')+geom_text(aes(label=town), size=4, color='#3C3B6E')
  pp <- pp+labs(x='村（乡镇码+村码）', 
              y="指标数值", 
              title= paste(varid, as.character(plotdata[1,'name'])), 
              subtitle=paste(zoneid, "村卡指标公布审核用图"))+
        theme(axis.text.x = element_blank())
  
  pb <- ggplot(plotdata, aes(y=value))+geom_boxplot()+
    geom_hline(yintercept = mean(plotdata$value), color="orange",size=1)+
    labs(x='橙色为均值', y="")+
    theme(axis.text.y = element_blank(),axis.text.x = element_blank())
  
  
  p <- plot_grid(pp, pb, labels = c("", ""), align = "h", rel_widths = c(4, 1))

  filename <- str_c('G102audit/', zoneid, '/','最小前50位 ', varid,as.character(plotdata[1,'name'])  ,'.png')
  ggsave(filename, plot=p, width = 8, height = 6)

}

plotzone <- function(zoneid){
  
  for(varid in vars){
    print(varid)
    plotsingle(zoneid, varid)
  }
}

Sys.time()

citys <- as.character(3301:3311) 
for(zoneid in citys){
  print(zoneid)
  plotzone(zoneid)
}

cityplotdata <- mutate(alldata, city=str_sub(code, 1, 4))
citythdata<- summarise(group_by(arrange(cityplotdata, city, var, value), city, var), thvalue=nth(value, 100))
cityplotdata <- left_join(cityplotdata, citythdata, by=c('city','var')) %>% filter(value<thvalue)
allplotdata <- filter(cityplotdata, is.finite(value))

plotsingle(zoneid='3302', varid = 'XK01')
plotzone('33')
write.csv(plotdata33, 'plotdata33.csv')
