#af

#读取上将列表及网址
#并截取编号
library(rvest)
Sys.setlocale('LC_ALL','C') 

wikiaf4s.site <- 'https://en.wikipedia.org/wiki/List_of_United_States_Air_Force_four-star_generals'
wikiaf4s <- read_html(sikiaf4s.site)

af4s <- wikiaf4s %>% html_nodes("tr td span a")%>% html_text()
af4s.names <- af4s[134:length(af4s)]
search.names <- chartr(old=' ', new='+', af4s[134:length(af4s)])
url <- ''
serchaf.site0 <- 'http://search.af.mil/search?utf8=%E2%9C%93&affiliate=aflink&query=000000&commit=Search'

for(i in 1:length(search.names)){
  serchaf.sites <- gsub(pattern='000000',  replacement=search.names[i], x=serchaf.site0)
  serch <- read_html(serchaf.sites)
  results <- serch %>% html_nodes("#results .url")%>% html_text()
  url[i] <- results[1]
}

af4s.data <- data.frame(name=af4s.names, url=url, stringsAsFactors = FALSE)
af4s.data$id <- substr(x=af4s.data$url, start =  regexpr(pattern = '\\d{6}', text=results[1])[[1]], stop = regexpr(pattern = '\\d{6}', text=results[1])[[1]]+5)

#write.csv(af4s.data, 'af4sdata.csv')
#af4s.data <- read.csv('af4sdata.csv', stringsAsFactors = FALSE)
#save(af4s.data, file='af4s.RData')


