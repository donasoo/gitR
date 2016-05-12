#read every bio
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

write.csv(af, 'af.csv', row.names = F)


getbio <- function(item){
  
  afhtml <- read_html(item$url)
  content <- as.character( afhtml %>% html_nodes(".da_black") )
  section <- afhtml %>% html_nodes(".da_black strong") %>% html_text()
  if(length(section) == 0){
    section <- afhtml %>% html_nodes(".da_black b") %>% html_text()
  }
  
  if(length(section) == 0){
    return(NA)
  }else{
    section <- str_trim(section)
    section <- section[nchar(section)>2]
    section.pattern <- 'abstract'
    for(i in 1:length(section)){
      section.pattern <- paste(section.pattern, section[i], sep="|")
    }
    
    paragraph <- str_split(content, section.pattern)[[1]]
    names(paragraph) <- c('abstra', str_to_lower(str_sub(section, end=6)))
    paragraph <- data.frame(as.list(paragraph), stringsAsFactors = F)
    
    item <- cbind(item, paragraph)
    
    return(item)
  }
  
  
}




