# audit plot

library(tidyverse)
library(stringr)
library(cowplot)

# 画单张图
# 输入zoneid：地区行政代码
# 输入plotvars: x,y,color,size 4个变量，默认为乡镇、行政区划面积，乡级类型，人口
plotsingle <- function(zoneid='330802', plotvars=c('Z00', 'Z07', 'Z01', 'Z19')){
  
  xlabel <- varnames[varnames$varid==plotvars[1], 'name']
  ylabel <- varnames[varnames$varid==plotvars[2], 'name']
  clabel <- ''
  slabel <- ''
  
  zonelen <- str_count(zoneid)
  codelen <- str_count(allplotdata$code[1])
  
  pdata <- allplotdata[str_sub(allplotdata$code, 1, zonelen)==zoneid, c('code', plotvars)]

  if(nrow(pdata)<1) return()
  
  if(length(plotvars) == 2){
    pdata$cvar=1
    pdata$svar=1
  }else{
    clabel <- str_c('颜色表示：\n',varnames[varnames$varid==plotvars[3], 'name'])
  }
  
  if(length(plotvars) == 3){
    pdata$svar=1
  }else{
    slabel <- str_c('大小表示：\n', varnames[varnames$varid==plotvars[4], 'name'])
  }
  
  colnames(pdata) <- c('code', 'xvar', 'yvar', 'cvar', 'svar')
  pdata <- mutate(pdata, town=str_sub(as.character(code), zonelen+1, codelen))
  
  path <- str_c("./testplot/", zoneid)
  if(!file.exists(path)){
    dir.create(path)
  }
  
  cb_palette <- c('#B22234', "#096386", "#facf5a", "#00b7a8", "#692db7", "#F0E442",
                  "#0072B2", "#D55E00", "#CC79A7")
  
  pp <- ggplot(pdata, aes(x=xvar, y=yvar, color=cvar, size=svar))
  pp <- pp+ geom_point(alpha=0.8)+geom_text(aes(label=town), size=4, vjust = "inward")
  pp <- pp+labs(x=xlabel, 
                y=ylabel, 
                color=clabel,
                size=slabel,
                title= titleword)+
    theme(axis.text.x = element_blank())+
    scale_color_manual(values=cb_palette)
  
  if(is.numeric(pdata$xvar)) pp <-pp+ geom_abline(intercept=0, slope=1)
  if(nchar(clabel)==0) pp <- pp+guides(color=F)
  if(nchar(slabel)==0) pp <- pp+guides(size=F)
  pb <- ggplot(pdata, aes(y=yvar))+geom_boxplot()+
    geom_hline(yintercept = mean(pdata$yvar), color="orange",size=1)+
    labs(x='橙色为均值', y="")+
    theme(axis.text.y = element_blank(),axis.text.x = element_blank())

  p <- plot_grid(pp, pb, labels = c("", ""), align = "h", rel_widths = c(4, 1))
  filename <- str_c('testplot/', zoneid, '/',fnprefix, plotvars[1], xlabel, '-',plotvars[2],  ylabel, '.png')
  ggsave(filename, plot=p, width = 9, height = 6)
  
}

#plotsingle(zoneid, plotcol)

# 批量画一个地区的
# zoneid：地区
# 输入plotvars: x,y,color,size 4个变量，默认为乡镇、行政区划面积，乡级类型，人口
# yvars，批量的y变量，默认为全部
plotzone <- function(zoneid='330802', plotvars=c('Z00', 'Z00', 'Z01', 'Z19'), yvars=colnames(allplotdata)){
  
  for(yvar in yvars){
    plotvars[2] <- yvar
    plotsingle(zoneid, plotvars)
  }
}

# 批量多地区多图
# grade：地区级别，行政区划码的位数，6为县
# 输入plotvars: x,y,color,size 4个变量，默认为乡镇、行政区划面积，乡级类型，人口
# yvars，批量的y变量，默认为全部
plotall <- function(grade=6, plotvars=c('Z00', 'Z00', 'Z01', 'Z19'), yvars=colnames(allplotdata)){
 
  for(zone in unique(str_sub(allplotdata$code, 1, grade))){
    plotzone(zone, plotvars, yvars)
  }
}

