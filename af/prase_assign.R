
prase_assign <- function(x) {
  month.pattern <- 'January|February|March|April|May|June|July|August|September|October|November|December'
  id <- str_extract(x[1], '\\d{6}')
  mystr <- x[2]
  index <- str_extract(mystr, '\\d{1,2}.') %>% str_replace('\\.', '')
  month.o <- str_extract(mystr, month.pattern)
  year.o <- str_extract(mystr, '\\d{4}')
  mystr <- str_replace(mystr, paste(month.o, year.o, sep='|'), '')
  month.t <- str_extract(mystr, month.pattern)
  year.t <- str_extract(mystr, '\\d{4}')
  
  position <- x[3]
  lx <- length(x)
  state <- x[lx]
  if(str_detect(state, 'D.C.')){
    state <- paste('Washington', state)
    lx <- lx-1
  }
  afb <- x[lx-1]
  
  unit <- ''
  for(i in (lx-2):4){
    unit <- paste(unit, x[i])
  }
  
  df <- c(id,index,month.o,year.o,month.t,year.t,position,unit, afb,state)

  return(df)
  
}

