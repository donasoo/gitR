v5hm <- read.csv('v5hm.csv', header = TRUE, stringsAsFactors=FALSE)
str(v5hm)

vill_m <- rbind(vill_m, v5hm)
str(vill_m)

vm <- merge(vill, vill_m, by.x='code', by.y="code", all.x=TRUE)
str(vm)
vm[is.na(vm$adcode_t),'adcode_t'] <- vm[is.na(vm$adcode_t),'code']
vm$code1 <- as.numeric(substr(vm$adcode_t, 1, 4))*100000000
vm$code2 <- as.numeric(substr(vm$adcode_t, 1, 6))*1000000
vm$code3 <- as.numeric(substr(vm$adcode_t, 1, 9))*1000
vm$code4 <- as.numeric(substr(vm$adcode_t, 1, 12))*1
str(vm)

vm1 <- merge(vm, dic14, by.x='code1', by.y="adcode", all.x=TRUE)
colnames(vm1)[ncol(vm1)] <- 'name1'
str(vm1)
vm1 <- merge(vm1, dic14, by.x='code2', by.y="adcode", all.x=TRUE)
colnames(vm1)[ncol(vm1)] <- 'name2'
str(vm1)
vm1 <- merge(vm1, dic14, by.x='code3', by.y="adcode", all.x=TRUE)
colnames(vm1)[ncol(vm1)] <- 'name3'
str(vm1)
vm1 <- merge(vm1, dic14, by.x='code4', by.y="adcode", all.x=TRUE)
colnames(vm1)[ncol(vm1)] <- 'name4'
str(vm1)
write.csv(vm1, file='vm.csv')
