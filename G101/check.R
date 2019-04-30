# check

library(tidyverse)
library(stringr)

g101 <- read_csv('G101.33.00.csv', skip=1, col_names = F,  locale=locale(encoding = 'GB18030'))
g301 <- read_csv('G301-2.33.00.csv', skip=1, col_names = F,  locale=locale(encoding = 'GB18030'))
g101code <- read_csv('g101code.csv',  locale=locale(encoding = 'GB18030'))
g301code <- read_csv('g301code.csv',  locale=locale(encoding = 'GB18030'))

g101 <- select(g101, X1, X2, num_range('X', 3:8), num_range('X', 21:128))
g301 <- select(g301, X1, X2, num_range('X', 14:156))

colnames(g101) <- c('code', 'unit',str_c('D', 1:114))
colnames(g301) <- c('code', 'unit',str_c('D', 1:143))

datax <- select(g101, code, unit, num_range('D', 9:15))
datax <- mutate(datax, 
                D10=D10/D9, 
				        D11=D11/D9, 
				        D12=D12/D9, 
                D13=D13/D9, 
                D14=D14/D9, 
                D15=D15/D9)

plotg(datax)

plotg <- function(plotdata){
  data.l <- gather(plotdata, var, value, -code, -unit)
  data.l <- left_join(data.l,g101code, by='var' )
  
  varlist <- unique(data.l$var)
  
  for(varstr in varlist){
    x <- filter(data.l, var==varstr)
    p <- ggplot(x, aes(x=name, y=value))
    p <- p+ geom_point(color='#B22234')+geom_text(aes(label=paste(code, unit)), size=4, color='#3C3B6E')
    p <- p+labs(x='指标', y='数量', title=paste('乡镇卡匹配性审核  占村数量比例  指标代码：', varstr))
    print(varstr)
    ggsave(paste('G101/', varstr, 'G101-匹配性审核.png'), plot=p, width = 6, height = 8)
  }
}
