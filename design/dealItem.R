dealItem <- function(dataInform, lorname){
  
  #lorname <- "330000000000_20160330151732.lor"
  #dataInform <- notes.df[1,]
  
  nname <- paste("N_", dataInform$tableId, ".csv", sep = "")
  vname <- paste("V_", dataInform$tableId, ".csv", sep = "")
  
  
  ctype <- c(rep("character", 3), "integer", rep("character", 2))
  ndata <- read.csv(file=unzip(lorname, nname), header = TRUE, stringsAsFactors=FALSE, colClass=ctype)
  dndata <- getDData(ndata, 9, "N", fill=TRUE)
  vdata <- read.csv(file=unzip(lorname, vname), header = TRUE, stringsAsFactors=FALSE, colClass=ctype)
  dvdata <- getDData(vdata, 9, "V", fill=FALSE)
  ddata <- merge(x=dndata, y=dvdata, by=c("id", "REPORTPERIOD"), all=TRUE)
  ldata <- split(ddata, "REPORTPERIOD")
  
  for(i in 1:length(ldata)){
	  idata <- ldata[[i]]
	  filename <- paste(dataInform$tableNum, idata[1,"REPORTPERIOD"], ".csv", sep = " ")
	  write.csv(idata, file=filename, na = "", quote = FALSE)
  }
  
}