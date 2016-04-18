createImport <- function(rownum, colnum, start){

  rows <- rep(1:rownum, each=colnum)
  cols <- rep(1:colnum, times= rownum)
  import <- data.frame(rows=rows, cols=cols)
  import$b <- start+1:length(cols)-1
  import$content <- paste("<表1>[行", import$rows, 
                          "][列", import$cols, 
                          "]=B", import$b, sep="")
  write.csv(import$content, file="import.txt", 
            quote = FALSE, 
            row.names = FALSE,
            col.names = FALSE)
}