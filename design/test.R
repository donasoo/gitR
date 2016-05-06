#XML文件

# Load the package required to read XML files.
library("XML")
library("methods")

dealLor <- function(lorname){
  #lorname <- "330000000000_20160330151732.lor"
  doc <- xmlParse(unzip(lorname, "dataInform.xml"), encoding="GBK")
  
  root <- xmlRoot(doc)
  notes <- getNodeSet(root, '//tableDescription')
  
  note1 <- xmlSApply(notes[[1]], xmlValue)
  notes.v <- xmlSApply(notes, function(x) xmlSApply(x, xmlValue))
  
  notes.df <- as.data.frame(t(notes.v), stringsAsFactors=FALSE)
  notes.df$tableNum <- gsub(pattern = "[^A-Za-z0-9\\-]", replacement="", x=notes.df$tableNum)
  notes.df$tableId <- gsub(pattern = "\\D", replacement="", x=notes.df$tableId)
  
  
  for(i in 1:nrow(notes.df)){
    dealItem(notes.df[i,], lorname)
  }
  #lapply(notes.df, dealItem, lorname=lorname)
}