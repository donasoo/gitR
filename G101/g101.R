# g101 data dp

library(tidyverse)

gzvar <- read_csv('g101var.csv', locale=locale(encoding = 'GB18030'))

gzd <- read_csv('G101.33.00.csv', col_names = F, skip =1, locale=locale(encoding = 'GB18030'))
colnames(gzd) <- gzvar$varid
gzd$code <- str_sub(gzd$code, 1, 9)
allplotdata <- select(gzd, -starts_with("X"))


##  test var
zoneid <- '331082'

# 设置全局变量
# varnames  指标名称代码
varnames <- gzvar
# allplotdata需要画的数据集，横格式
allplotdata <- select(gzd, -starts_with('X'))
# plotcol： x y 颜色 大小 4个变量设置
allmode <- c('Z00', 'Z12', 'Z01', 'Z19')
# titleword： 标题
titleword <- paste(zoneid, '乡镇卡审核用图')
# fnprefix  文件名前缀
fnprefix <- 'G101 '

# 各类占村比
z11_yvars <- c('Z12', 'Z13', 'Z14', 'Z15','Z16', 'Z17')
z11_mode <- c('Z11', 'Z12', 'Z01', 'Z19')

# 占耕地比
z23_yvars <- c('Z24', 'Z25', 'Z26', 'Z27','Z28')
z11_mode <- c('Z23', 'Z23', 'Z01', 'Z07')



plotsingle(zoneid, plotcol)
plotzone(zoneid, yvars)
