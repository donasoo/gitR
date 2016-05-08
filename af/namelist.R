#user fetchbio function get every item in every page


site1 <- 'http://www.af.mil/AboutUs/Biographies/tabid/132/Page/'
site2 <- '/Default.aspx'

afs <- fetchbio(paste(site1, '1', site2, sep=''))

for(i in 2:227){
  print(i)
  site <- paste(site1, i, site2, sep='')
  items <- fetchbio(site)
  afs <- rbind(afs, items)
}
write.csv(afs, 'afs2.csv')

#read and filter
afs <- read.csv('afs1.csv', stringsAsFactors = F)
afs <- afs[,-1]
str(afs)


afs.need <- afs[afs$year>1990 | is.na(afs$year),]
afs.need <- afs.need[!is.na(afs.need$rank),]
afs.need <- afs.need[afs.need$rank=='GENERAL'|afs.need$rank=='LIEUTENANT GENERAL',]
afs.need$id <- str_extract(afs.need$url, '\\d{6}')
write.csv(afs.need, 'afsneed.csv', row.names = F)
