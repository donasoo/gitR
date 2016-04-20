#test web 

library(XML)
library(RCurl)
library(rvest)

strurl <- "http://www.af.mil/AboutUs/Biographies/Display/tabid/225/Article/104763/general-michael-v-hayden.aspx"

doc   <- htmlParse(getURL(strurl),asText=TRUE)
tx <- getNodeSet(doc, '//div[@class="da_black"]')
tx1 <- tx[[1]]
a <- sapply(tx, xmlValue)
strsplit(a, "EDUCATION|ASSIGNMENTS|SUMMARY OF JOINT ASSIGNMENTS|FLIGHT INFORMATION|MAJOR AWARDS AND DECORATIONS|EFFECTIVE DATES OF PROMOTION|")

