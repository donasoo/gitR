af <- read.csv('af.csv', stringsAsFactors = F)
afc <- af
afc[!is.na(afc[,18]), 8] <- afc[!is.na(afc[,18]), 18]
afc[!is.na(afc[,31]), 7] <- afc[!is.na(afc[,31]), 31]
afc[!is.na(afc[,14]), 11] <- afc[!is.na(afc[,14]), 14]
afc[!is.na(afc[,19]), 6] <- afc[!is.na(afc[,19]), 19]
afc[!is.na(afc[,25]), 6] <- afc[!is.na(afc[,25]), 25]
afc <- afc[,1:12]
afc <- afc[!is.na(afc$assign),]
afc <- afc[!is.na(afc$educat),]
afc <- afc[!is.na(afc$effect),]
colnames(afc)[11] <- 'awards'
colnames(afc)[9] <- 'joints'

#remove Surgeon Air National Guard and  Reserve Judge Advocate
afc <- afc[!str_detect(afc$abstra, 'Surgeon'),]
afc <- afc[!str_detect(afc$abstra, 'Judge Advocate'),]
afc <- afc[afc$id != 742033, ]

write.csv(afc, 'afc.csv', row.names = F)
write.csv(af[,c('id', "effect")], 'af0.csv', row.names = F)
