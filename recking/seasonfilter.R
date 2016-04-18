#季度净化
seasonfilter <- function(x, q){
  filtercol <- c(14,15,16,22,26)
  if(q==3){
    filtercol <- c(14,15,16,22,26)
  }
  
  x[,filtercol] <- 0
  
  return(x)
}