library(tidyverse)
nfl <- read_csv('NFL.csv') %>% filter(!is.na(PLAYER))
nfl <- mutate(nfl, 
              dollars=as.integer( str_remove(DOLLARS, '\\S') %>% str_remove_all(","))/10000,
              average=dollars/YRS)

p <- ggplot(data = nfl, mapping = aes(x=POS, y=average))+geom_boxplot()+geom_jitter()
p
