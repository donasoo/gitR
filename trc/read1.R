#  读入粮食监测原始村级字典库
vill <- read.csv('vill.csv', header = TRUE, stringsAsFactors=FALSE)
str(vill)

# 读入2011年标准行政区划代码
dic11 <- read.csv('dic11.csv', header = TRUE, stringsAsFactors=FALSE)
str(dic11)

#读入11年变更文件
md11 <- read.csv('md11.csv', header = TRUE, stringsAsFactors=FALSE)
str(md11)

# 读入2012年标准行政区划代码
dic12 <- read.csv('dic12.csv', header = TRUE, stringsAsFactors=FALSE)
str(dic12)

#读入12年变更文件
md12 <- read.csv('md12.csv', header = TRUE, stringsAsFactors=FALSE)
str(md12)

# 读入2013年标准行政区划代码
dic13 <- read.csv('dic13.csv', header = TRUE, stringsAsFactors=FALSE)
str(dic13)

#读入13年变更文件
md13 <- read.csv('md13.csv', header = TRUE, stringsAsFactors=FALSE)
str(md13)

# 读入2014年标准行政区划代码
dic14 <- read.csv('dic14.csv', header = TRUE, stringsAsFactors=FALSE)
str(dic14)

#读入14年变更文件
md14 <- read.csv('md14.csv', header = TRUE, stringsAsFactors=FALSE)
str(md14)
