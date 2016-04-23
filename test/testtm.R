vignette("tm") 
library(tm)
library(SnowballC)
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


data <- readLines("http://www.r-bloggers.com/wp-content/uploads/2016/01/vent.txt") # from: http://www.wvgazettemail.com/
df <- data.frame(data)
textdata <- df[df$data, ]
textdata = gsub("[[:punct:]]", "", textdata)

jay <- read.delim(file = '108479.txt', stringsAsFactors = F, header = F)
unlist(strsplit(jay[,1], " "))
unlist(strsplit("a.b.c", "."))
unlist(strsplit("a.b.c", "\\."))

jay <- jay[,1]
unlist(strsplit(jay.pro, " |,|."))
strsplit(jay.pro, " |,|.")
