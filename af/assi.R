library(stringr)
library(dplyr)

afc <- read.csv('afc.csv', stringsAsFactors = F)

afc$assign <- str_trim(str_replace_all(afc$assign, '<span.*</span>|<p>|</p><em>|</em>|聽|\\(.*\\)|<div>|</b>|&#13;|</strong>|</div>|\\n', ''))
assign.list <- str_split(afc$assign, '<br />')

for( i in 1:length(assign.list)){
  assign.list[[i]] <- paste(afc$id[i], assign.list[[i]], sep = ',')
}

assign.v <- unlist(assign.list)
assign.v <- assign.v[nchar(assign.v) > 20]


write.table(assign.v, 'assignv.txt', row.names = F)
assign.l <- str_split(assign.v, ',')
assign.l <- sapply(assign.l, prase_assign, simplify=F)
ma <- matrix(unlist(assign.l), ncol=10, byrow=T)
assign <- data.frame(ma,  stringsAsFactors = F)
colnames(assign) <- c('id','index','month.o','year.o','month.t','year.t','position','unit', 'afb','state')
assign$content <- assign.v

#check
write.csv(assign, 'assign.csv')

