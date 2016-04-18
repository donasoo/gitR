#test  web

library(XML)
library(RCurl)

script <- getURL("http://www.af.mil/AboutUs/Biographies/Display/tabid/225/Article/104966/general-mark-a-welsh-iii.aspx")
doc <- htmlParse(script)
li <- getNodeSet(doc, "//ul[@class='xoxo blogroll']//a")

urls <- sapply(li, xmlGetAttr, "href")

top <- xmlRoot(doc)
pro <- getNodeSet(top,"//div[@class='da_black']")
txt <- xmlSApply(pro, "xmlValue")

at <- strsplit(txt, "EDUCATION|ASSIGNMENTS|SUMMARY OF JOINT ASSIGNMENTS|FLIGHT INFORMATION|AMAJOR AWARDS AND DECORATIONS|EFFECTIVE DATES OF PROMOTION")
tx <- strsplit(a, "\r\n")
write(tx[[3]], "pro.txt")
