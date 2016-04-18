page <- 122;
url0 <- 'http://www.l-zzz.cn/zhishu/zs_list.jsp?nID=41&pageNum=';
start <- 338;
step1 <- 11;
step2 <- 4;

yypi <- 0;
date <- '';

pattern1 <- '[0-9]{3,4}\\.[0-9]+';
pattern2 <- '\\d{4}-\\d{2}-\\d{2}';

for(i in 1:page){
  print(i)
  
  url <- paste(url0, i , sep='');
  content <- readLines(url);
  
  rows <- 16;
  for(j in 1:rows){
    line <- (j-1)*step1+start;
    str <- content[line];
    exp <- gregexpr(pattern1, str);
    pi <- as.numeric(substring(str, exp[[1]], exp[[1]]+attr(exp[[1]],'match.length')-1));
    yypi <- c(yypi, pi);
    str <- content[line+4];
    exp <- gregexpr(pattern2, str);
    dt <- substring(str, exp[[1]], exp[[1]]+attr(exp[[1]],'match.length')-1);
    date <- c(date, dt);
  }
  
}

yypi <- data.frame('date'=date, 'yypi'=yypi);
yypi <- yypi[-1,];
write.csv(yypi, 'yypiweb.csv', row.names=FALSE);