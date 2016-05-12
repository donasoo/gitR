library(ggplot2)
rankr <- read.csv('rankr.csv', stringsAsFactors = F)
rankr$grade <- factor(rankr$grade)
p <- ggplot(rankr, aes(y=dutylen, x=factor(id), fill=factor(grade)))
p + geom_bar(stat = "identity",position='stack', alpha=1) + scale_fill_identity(guide='legend')

p <- ggplot(rankr[rankr$grade == 9,], aes(x=top, y=dutylen, group=top))
p+ geom_boxplot()

p <- ggplot(rankr[rankr$grade == 9,], aes(x=dutylen, fill=top))
p+geom_histogram(binwidth = 0.5,alpha=0.5, position='identity')
