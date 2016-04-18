library(rvest)

sinaholders <- function(code){

sinasite <- "http://vip.stock.finance.sina.com.cn/corp/go.php/vCI_CirculateStockHolder/stockid/000000/displaytype/40.phtml"
codesite <- gsub("000000", code, sinasite)

tryCatch(sinaweb <- html(codesite), error = function(e) print(code)) 
t <- sinaweb %>%  html_nodes("#CirculateShareholderTable") %>% .[[1]] %>% html_table(fill = T)



if(nrow(t) <10){
  return(0)
}

holders <- data.frame(code=code, 
                      serial= iconv(t[,1],"utf-8","gbk") ,
                      deadline="",
                      name=iconv(t[,2],"utf-8","gbk") ,
                      mount= iconv(t[,3],"utf-8","gbk") ,
                      proportion= iconv(t[,4],"utf-8","gbk") ,
                      property= iconv(t[,5],"utf-8","gbk"), 
                      stringsAsFactors = F  )

deadline <- holders[holders$serial=="截止日期",4]
begin <- which(holders$serial=="截止日期")+3
end <- which(holders$serial=="")-1

for(i in 1:length(deadline)){
  holders[begin[i]:end[i], 3] <- deadline[i]
}

holders <- holders[holders$deadline != "",]
return(holders)

}