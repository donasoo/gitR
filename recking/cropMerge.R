cropSeason <- function(rdname, year, season){

load(paste(rdname, '.RData', sep=""))
crop.15 <- cocrop
crop.15$.type <-'co'
fzcrop$.type <- 'fz'
smpcrop$.type <- 'lot'
crop.15 <- rbind(crop.15, fzcrop)
crop.15 <- rbind(crop.15, smpcrop)
crop.15$.season <- season
crop.15$.year <- '2015'
return(crop.15)
}

crop.15 <- rbind(crop.15q1, crop.15q2, crop.15q3, crop.15q4)
save(crop.15, file = 'crop15.RData')
