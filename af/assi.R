library(stringr)
library(dplyr)

afc <- read.csv('afc.csv', stringsAsFactors = F)



afc$assign <- str_trim(str_replace_all(afc$assign, '<span.*</span>|<p>|</p><em>|</em>|聽|\\(.*\\)|<div>|</b>|&#13;|</strong>|</div>|\\n', ''))
assign.list <- str_split(afc$assign, '<br />')

for( i in 1:length(assign.list)){
  assign.list[[i]] <- paste(afc$id[i], assign.list[[i]])
}

assign.v <- unlist(assign.list)
assign.v <- assign.v[nchar(assign.v) > 20]

write.table(assign.v, 'assignv.txt', row.names = F)

#check
y2 <- str_locate_all(rank.v, '\\s\\d{4}')
rank.v[sapply(y2, nrow) != 1]
rank.list[sapply(rank.list, length) <9 ]
rank.list[sapply(rank.list, length) > 10]
rank.list[sapply(rank.list, length) == 10]
write.table(rank.list[sapply(rank.list, length) == 10], 'rank10.txt')

rank <- data.frame(content=str_trim(rank.v),stringsAsFactors = F)
rank$id <- str_sub(rank$content, 1, 6)

afs.need <- read.csv('afsneed.csv', stringsAsFactors = F)
rankr <- afs.need[afs.need$id %in% rank$id & str_detect(afs.need$reamrk, 'Retir'), c('reamrk', 'id')]
rankr <- rename(rankr, reamrk=content) 
rank <- rbind(rank, rankr)


rank$year <- str_replace_all(str_extract(rank$content, '(\\s|,)\\d{4}'), ',|\\s', '')

month.pattern <- c('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
rank$month <- 0
for(i in 1: 12){
  rank[str_detect(rank$content, month.pattern[i]), 'month'] <- i
}

rank$day <- str_replace(str_extract(rank$content, '\\d{1,2},'), ',', '')

rank.pattern <- data.frame(rank=
				c('Second Lieutenant', 
				  'First Lieutenant',
				  'Captain',
				  'Lieutenant Colonel',
				  'Brigadier General',
				  'Major General',
				  'Lieutenant General',
				  'Major',
				  'Colonel',
				  'General',
				  'Retir'
				  ), 
				  grade=c(1,2,3,5,7,8,9,4,6,10, 90),
				  stringsAsFactors=F)
rank$grade <- 0
for(i in 1:11){
  rank[str_detect(rank$content, rank.pattern[i, 'rank']) & rank$grade==0, 'grade'] <- rank.pattern[i, 'grade']
}

rank$date <- as.Date(paste(rank$year, rank$month, rank$day, sep = '-'))

#commission
crank <- aggregate(rank$date, by=list(rank$id), min)
colnames(crank) <- c('id', 'commmi')
rank <- merge(rank, crank, by='id', all=T)

rank$servlen <- round(as.numeric(difftime(rank$date, rank$commmi, units = 'days'))/365, 1)

rank <- rank[order(rank$commmi, rank$id, rank$date),]
rank$dutylen <- c(diff(rank$servlen), 0)
rank[rank$dutylen < 0, 'dutylen'] <- 0 
rank$top <- FALSE
rank[rank$id %in% rank[rank$grade==10, 'id'], 'top'] <- TRUE
write.csv(rank, 'rank.csv', row.names = F)

rankr <- rank[rank$id %in% rank[rank$grade==90,'id'],]
write.csv(rankr, 'rankr.csv', row.names = F)
#check
rank[is.na(rank$date), ]
rank[rank$grade==0,]
