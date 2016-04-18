class <- c('numeric', "character", "character")
gem <- read.csv('gem.csv', header = TRUE, stringsAsFactors=FALSE, colClasses=class)
sme <- read.csv('sme.csv', header = TRUE, stringsAsFactors=FALSE, colClasses=class)
codes <- rbind(gem, sme)

result <- sapply(X=codes$code, FUN=sinaholders, simplify=F )

sinaholders(codes$code[470])

rs <- data.frame(code="", 
                      serial= "" ,
                      deadline="",
                      name="",
                      mount= "",
                      proportion= "" ,
                      property= "", 
                      stringsAsFactors = F  )

for(i in 1:1283){
  if(length(result[[i]]) == 7){
    rs <- rbind(rs, result[[i]])
  }
}

write.csv(rs, file="rs.csv")
