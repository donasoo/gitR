#read every bio  and save 
library(rvest)
library(dplyr)
load('roster.RData')

roster.need <- filter(af.list, year>1990 & !is.na(rank))
bio.notes <- list()
for(i in 1:nrow(af.need)){
  print(i)
  bio.notes <- append(bio.notes, read_html(as.character( af.need[i, 'url'])) %>% html_nodes("div.da_black") )
}

save(af.list, search.nodes, bio.notes, file = 'bio.RData')


save(n)