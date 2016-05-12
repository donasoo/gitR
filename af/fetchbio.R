#prase every item in one search page
library(rvest)
library(stringr)

fetchbio <- function(site){
  
  Sys.setlocale('LC_ALL','C') 
  rank_pattern <- "GENERAL|BRIGADIER GENERAL|LIEUTENANT GENERAL|MAJOR GENERAL"
  
  biosearch <- read_html(site)
  con <- biosearch %>% html_nodes(".dal_list td.cell a")
  urls <- html_attr(con, 'href')
  caption <- html_text(con)
  
  ranks <- str_extract(caption, rank_pattern)
  names <- str_trim(str_replace(caption, rank_pattern, ''))
  
  con2 <- biosearch %>% html_nodes(".dal_list td.cell span.red")
  remark <- html_text(con2)
  
  years <- str_extract(remark, '\\d{4}')
  
  page <- data.frame(name=names, rank=ranks, year=years, url=urls, reamrk=str_trim(remark),
                     stringsAsFactors = F)
  return(page)
  
}
