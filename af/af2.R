
afneed <- read.csv('afsneed.csv', stringsAsFactors  = F)
af <- afneed[1,]

for(i in 1:365){
  print(i)
  bio <- getbio(afneed[i,])
  if(is.na(bio)) next

  if(!all(colnames(af) == colnames(bio))){
    cname <- setdiff(colnames(bio), colnames(af))
    af[,cname] <- NA
    cname <- setdiff(colnames(af), colnames(bio))
    bio[,cname] <- NA
  }
  af <- rbind(af, bio)
}

write.csv(af, 'af.csv')

