#read bio and prase sections use fetchbio function result
library(rvest)
library(stringr)
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




