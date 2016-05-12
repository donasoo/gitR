#prase every item in one search page
library(rvest)

site1 <- 'http://www.af.mil/AboutUs/Biographies/tabid/132/Page/'
site2 <- '/Default.aspx'
site <- paste(site1, '1', site2, sep='')
search.nodes <- c(read_html(site) %>% html_nodes("table.dal_list"))

for(i in 2:227){
  print(i)
  site <- paste(site1, i, site2, sep='')
  search.nodes <- append(afs, read_html(site) %>% html_nodes("table.dal_list"))
}

save(search.nodes, file='searchnodes.RData')