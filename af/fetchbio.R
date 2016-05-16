#prase every item in one search page
library(rvest)
library(xml2)
library(XML)

site1 <- 'http://www.af.mil/AboutUs/Biographies/tabid/132/Page/'
site2 <- '/Default.aspx'

fectch.rosters <- function(roster.nodes, pageno){
  print(pageno)
  site <- paste(site1, pageno, site2, sep='')
  
  roster.node <- read_html(site) %>% html_nodes('table.dal_list')
  pageno.max <- html_nodes(roster.node, 'a.dig_pager_button') %>% html_text() %>% as.numeric() %>% max()
  if(pageno < pageno.max){
    roster.nodes <- append(fectch.rosters(roster.nodes, pageno+1), roster.node)
  }else{
    return (list(roster.node))
  }
  
}