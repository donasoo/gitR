wsum <-function(w, v){sum(w*v)}



d <- read.csv('d.csv', header = TRUE, stringsAsFactors=TRUE)
str(d)

d[,2:3]*d$w

aggregate(x=d$num,by=list(d$id), FUN=wsum, w=d$w)
