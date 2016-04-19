vignette("tm") 
library(tm)
txt <- system.file("texts", "txt", package = "tm")
txt
docs <- c("This is a text.", "This another one.")
docs
VCorpus(VectorSource(docs))

reut21578 <- system.file("texts", "crude", package = "tm")

reuters <- Corpus(DirSource(reut21578), readerControl = list(reader = readReut21578XML))  
writeCorpus(reuters)  
reuters[1]

assignments <- read.delim(file = 'af104966.txt', stringsAsFactors = F, header = F)
str(assignments)
xas <- strsplit(assignments[, 1], split="[,]")

xas
states = rownames(USArrests)
states
