#af

#在空军官网简历页获取所有简历的列表
library(rvest)
Sys.setlocale('LC_ALL','C') 

site1 <- 'http://www.af.mil/AboutUs/Biographies/tabid/132/Page/'
site2 <- '/Default.aspx'
i <- 1

for(i in 1:5){
  site <- paste(site1, i, site2, sep='')
}
biosearch <- read_html(site)
con <- biosearch %>% html_nodes(".dal_list td.cell a")
con
url <- html_attr(con, 'href')
name <- html_text(con)

con2 <- biosearch %>% html_nodes(".dal_list td.cell span.red")
remark <- html_text(con2)

strsplit('MAJOR GENERAL ELMER EDWARD ADLER','MAJOR GENERAL')
