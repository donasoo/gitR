dic <- read.csv(file = 'e:\\gitR\\fz\\dic.csv', header = TRUE, stringsAsFactors = FALSE);
admin <- read.csv(file = 'e:\\gitR\\fz\\admin.csv', header = TRUE, stringsAsFactors = FALSE);
str(admin)
city <- admin[substr(admin$id, 5,12)==0,]
