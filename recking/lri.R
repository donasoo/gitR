require(reshape2)
lri <- read.csv('lri.csv', header = TRUE, stringsAsFactors=FALSE)
str(lri)
clri <- dcast(lri, city+ season ~ type)
clri$icradio <- clri$ic/clri$lot
clri$rimradio <- clri$rim/clri$lot

write.csv(clri, 'clri.csv')
