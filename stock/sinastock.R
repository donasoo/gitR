class <- c(rep("character", 4), rep('numeric', 11), "character")
basic <- read.csv('basic.csv', header = TRUE, stringsAsFactors=FALSE, colClasses=class)
basic$code <- substr(x = paste("00000", basic$code, sep = ''), 
                     start = nchar(basic$code),
                     stop = nchar(basic$code)+5)
write.csv(basic, file="basic2.csv", row.names = F)
result <- sapply(X=basic$code, FUN=sinaholders, simplify=F )

sinaholders("300032")

rs <- data.frame(code="", 
                      serial= "" ,
                      deadline="",
                      name="",
                      mount= "",
                      proportion= "" ,
                      property= "", 
                      stringsAsFactors = F  )

for(i in 1:length(result)){
  if(length(result[[i]]) == 7){
    rs <- rbind(rs, result[[i]])
  }
}

write.csv(rs, file="rs.csv", row.names = F)
