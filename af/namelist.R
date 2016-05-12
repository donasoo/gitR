#
library(stringr)
library(dplyr)

load('searchnodes.RData')

f.url <- function(x) x %>% html_nodes("a.title") %>% html_attr('href') %>% str_trim()
f.caption <- function(x) x %>% html_nodes("tr.dal_row a.title") %>% html_text()
f.year <- function(x) x  %>% html_nodes("tr.dal_row span.red") %>% html_text() %>%  str_extract('\\d{4}')
f.update <- function(x) x %>% html_nodes("tr.dal_row td.updated") %>% html_text() %>% str_trim() 
af.list <- sapply(search.nodes, FUN = f.url) %>% unlist() %>% data.frame(url=., stringsAsFactors=F) %>% tbl_df()
af.list <- mutate(af.list, name=sapply(search.nodes, FUN = f.caption) %>% unlist() %>% str_replace(rank_pattern, '') %>% str_trim())
af.list <- mutate(af.list, rank=sapply(search.nodes, FUN = f.caption) %>% unlist() %>% str_extract(rank_pattern))
af.list <- mutate(af.list, year=sapply(search.nodes, FUN = f.year) %>% unlist() )
af.list <- mutate(af.list, update=sapply(search.nodes, FUN = f.update) %>% unlist() %>% as.Date('%m/%d%Y'))
af.list <- mutate(af.list, id=str_extract(url, '\\d{6}') )

save(search.nodes, af.list, file='afs.RData')
