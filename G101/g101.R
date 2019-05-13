# g101 data dp

library(tidyverse)

gzvar <- read_csv('g101var.csv', locale=locale(encoding = 'GB18030'))

gzd <- read_csv('G101.33.00.csv', col_names = F, skip =1, locale=locale(encoding = 'GB18030'))
colnames(gzd) <- gzvar$varid
gzd$code <- str_sub(gzd$code, 1, 9)
allplotdata <- select(gzd, -starts_with("X"))


##  test var
#zoneid <- '331082'

# 设置全局变量
# varnames  指标名称代码
varnames <- gzvar
# allplotdata需要画的数据集，横格式
allplotdata <- select(gzd, -starts_with('X'))
# plotcol： x y 颜色 大小 4个变量设置
#allmode <- c('Z00', 'Z12', 'Z01', 'Z19')
# titleword： 标题
titleword <- '乡镇卡审核用图'
# fnprefix  文件名前缀
fnprefix <- 'G101 '

datavars <- c(str_c("Z0", 1:9), str_c('Z', 10:77))

plotall()

gradelevel = 4


# 户均人口
z18_19 <- c('Z19')
z18_pop <- c('Z18', 'Z19', 'Z01', 'Z07', 1, '(户每人)')
plotall(grade=gradelevel,  plotvars = z18_pop,  yvars = z18_19)
# 各类占村比
z11_yvars <- c('Z12', 'Z13', 'Z14', 'Z15','Z16', 'Z17')
z11_mode <- c('Z11', 'Z12', 'Z01', 'Z19', 100, '(%)')
plotall(grade=gradelevel,  plotvars = z11_mode,  yvars = z11_yvars)
# 占耕地比
z23_yvars <- c('Z24', 'Z25', 'Z26', 'Z27','Z28')
z23_mode <- c('Z23', 'Z24', 'Z01', 'Z07', 100, '(%)')
plotall(grade=gradelevel,  plotvars = z23_mode,  yvars = z23_yvars)
# 占户数比
z18_yvars <- c('Z32', 'Z33', 'Z34', 'Z35', 'Z73','Z74')
z18_mode <- c('Z18', 'Z32', 'Z01', 'Z19', 100, '(%)')
plotall(grade=gradelevel,  plotvars = z18_mode,  yvars = z18_yvars)

#占人比
z19_yvars <- c('Z20', 'Z21', 'Z22','Z58', 'Z59', 'Z70','Z71','Z72')
z19_mode <- c('Z18', 'Z32', 'Z01', 'Z19', 100, '(%)')
plotall(grade=gradelevel,   plotvars = z19_mode,  yvars = z19_yvars)
# 占地比
z07_yvars <- c('Z08', 'Z09', 'Z23')
z07_mode <- c('Z07', 'Z07', 'Z01', 'Z19',100, '(%)')
plotall(grade=gradelevel,   plotvars = z07_mode,  yvars = z07_yvars)
