source('E:/gitR/recking/reckland.R', encoding='UTF-8')
source('E:/gitR/recking/reckfz.R', encoding='UTF-8')
source('E:/gitR/recking/recksmp.R', encoding='UTF-8')
source('E:/gitR/recking/reckco.R', encoding='UTF-8')
source('E:/gitR/recking/recking.R', encoding='UTF-8')
source('E:/gitR/recking/seasonfilter.R', encoding='UTF-8')
source('E:/gitR/recking/read.R', encoding='UTF-8')

year <- 2015
season <- 1
reduce <- reduce[reduce$annual<year,]
plough <- plough[plough$annual==year,]
clri <- clri[clri$season=='Q1',]
tb <- FALSE

if(tb){
  
  fz1 <- fzcrop_1[,1:2]
  fz2 <- fzcrop[,1:2]
  fz1$V2 <- toupper(fz1$V2)
  fz2$V2 <- toupper(fz2$V2)
  fzid <- merge(x=fz1, y=fz2, by.x='V2', by.y='V2', all=F)
  
  fzcrop <- merge(x=fzcrop, y=fzid, by.x='V2', by.y='V2', all.x=FALSE, all.y=FALSE)
  fzcrop_1 <- merge(x=fzcrop_1, y=fzid, by.x='V2', by.y='V2', all.x=FALSE, all.y=FALSE)
  
}

land_t <- reckland(land_0, reduce, verify)
fzcrop_city <- reckfz(fzcrop)
cocrop_city <- reckco(cocrop) 
smpcrop_city <- recksmp(smpcrop, land_t, plough)
citycrop <- recking(smpcrop_city, fzcrop_city, cocrop_city, clri)

citycrop0 <- citycrop
citycrop[1,] <- citycrop0[12, ]
citycrop[2:12,] <- citycrop0[1:11, ]
colnames(citycrop) <- identifiers;
rownames(citycrop) <- units
tcitycrop <- t(citycrop)
write.csv(tcitycrop, 'citycrop16 same.csv')

