library(rvest)
wiki_kirk <- read_html("https://en.wikipedia.org/wiki/Kirk_Ferentz")
wiki_kirk_extract <- wiki_kirk %>%html_nodes(".vcard td , .vcard th")
head(wiki_kirk_extract)
## {xml_nodeset (6)}
## [1] <td colspan="2" style="text-align:center"><a href="/wiki/File:Kirk_p ...
## [2] <th scope="row">Sport(s)</th>
## [3] <td class="category">n  <a href="/wiki/American_football" title="Am ...
## [4] <th colspan="2" style="text-align:center;background-color: lightgray ...
## [5] <th scope="row">Title</th>
## [6] <td>n  <a href="/wiki/Head_coach" title="Head coach">Head coach</a> ...

wiki_kirk_extract <- wiki_kirk %>%html_nodes(".vcard td , .vcard th") %>% html_text()
head(wiki_kirk_extract)
## [1] "nFerentz at the 2010 Orange Bowln"
## [2] "Sport(s)"                           
## [3] "Football"                           
## [4] "Current position"                   
## [5] "Title"                              
## [6] "Head coach"

wiki_kirk %>%
  html_nodes(".vcard td , .vcard th") %>%
  html_text() %>%
  guess_encoding()
##       encoding language confidence
## 1        UTF-8                1.00
## 2 windows-1252       en       0.36
## 3 windows-1250       ro       0.18
## 4 windows-1254       tr       0.13
## 5     UTF-16BE                0.10
## 6     UTF-16LE                0.10

record_kirk <- wiki_kirk %>%
  html_nodes(".wikitable") %>%
  .[[1]] %>%
  html_table(fill = TRUE)

lego_movie <- html("http://www.imdb.com/title/tt1490017/")

lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()

t <- lego_movie %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()
Sys.setlocale(locale="C")
afhtml <- read_html("http://www.af.mil/AboutUs/Biographies/Display/tabid/225/Article/108479/lieutenant-general-john-w-jay-raymond.aspx")
af1 <- afhtml %>% html_node(".da_black") %>%html_text()
af2 <- strsplit(af1, "\r\n")

af3 <- sapply(af2, function(x) strsplit(x, "\r\n"), simplify=T)


myvec <- 3:8
mymatrix <- matrix(6:1*10,3,2)
mydataframe <- as.data.frame(mymatrix)
mylist <- list(mv=myvec, mm=mymatrix,
               mdf=mydataframe, mn=56,ms="test")
# updating one element
mylist$ms <- "new test"
mylist$ms
mylist[[5]] <- "newer test"
mylist$ms
# inserting two elements
mylist <- c(mylist,wname="Friday", mday=13)
mylist
# deleting one element at a time
mylist$ms<- NULL
mylist[["mn"]]<- NULL
mylist[[1]]<- NULL
mylist