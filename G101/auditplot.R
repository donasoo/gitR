# audit plot

library(tidyverse)
library(stringr)
library(cowplot)

# 画单张图
# 输入zoneid：地区行政代码
# 输入plotvars: 6个变量，分别是分母、分子、色、大小、倍数、附加计量单位
# 默认为无、行政区划面积，乡级类型、人口，1，无
plotsingle <- function(zoneid='330802', plotvars=c('1', 'Z07', 'Z01', 'Z19', '1', '')){
  
  
  zonelen <- str_count(zoneid)
  codelen <- str_count(allplotdata$code[1])
  
  pdata <- filter(allplotdata, str_sub(code, 1, zonelen)==zoneid) %>%
    mutate(town=str_sub(as.character(code), zonelen+1, codelen))
  if(nrow(pdata)<1) return()
  
  delabel <- NA
  ylabel <- varnames[varnames$varid==plotvars[2], 'name']
  clabel <- NA
  slabel <- NA
  vars <- colnames(pdata)
  filename <- ''
  
  if(plotvars[1] %in% vars){
    pdata$devar=pdata[[plotvars[1]]]
    delabel <- varnames[varnames$varid==plotvars[1], 'name']
    filename <- str_c('G101plot/', zoneid, '/',plotvars[2],  ylabel,' 比 ', delabel, '.png')
    ylabel <- paste(ylabel, '比', delabel, plotvars[6])
  }else{
    pdata$devar=1
    filename <- str_c('G101plot/', zoneid, '/',plotvars[2],  ylabel,'.png')
  }
  
  pdata$yvar= (pdata[[plotvars[2]]]/pdata$devar*as.numeric(plotvars[5]))
  
  if(plotvars[3] %in% vars){
    pdata$cvar=pdata[[plotvars[3]]]
    clabel <- str_c('颜色表示：\n',varnames[varnames$varid==plotvars[3], 'name'])
  }else{
    pdata$cvar=1
  }
  
  if(plotvars[4] %in% vars){
    pdata$svar=pdata[[plotvars[4]]]
    slabel <- str_c('大小表示：\n', varnames[varnames$varid==plotvars[4], 'name'])
  }else{
    pdata$svar=1
  }
  
  path <- str_c("./G101plot/", zoneid)
  if(!file.exists(path)){
    dir.create(path)
  }
  
  cb_palette <- c('#B22234', "#096386", "#facf5a", "#00b7a8", "#692db7", "#F0E442",
                  "#0072B2", "#D55E00", "#CC79A7")
  
  pp <- ggplot(pdata, aes(x=town, y=yvar, color=as.factor(cvar), size=svar))
  pp <- pp+ geom_point(alpha=0.8)+geom_text(aes(label=town), size=4, vjust = "inward")
  pp <- pp+labs(x='', 
                y='指标数值', 
                color=clabel,
                size=slabel,
                title= paste(zoneid, titleword),
                subtitle=ylabel)+
    theme(axis.text.x = element_blank(), legend.position="left")+
    scale_color_manual(values=cb_palette)
  
  if(is.na(clabel)) pp <- pp+guides(color=F)
  if(is.na(slabel)) pp <- pp+guides(size=F)

  pb <- ggplot(pdata, aes(y=yvar))+geom_boxplot()+
    geom_hline(yintercept = mean(pdata$yvar, na.rm = T), color="orange",size=1)+
    labs(x='橙色为均值', y="")+
    theme(axis.text.y = element_blank(),axis.text.x = element_blank())

  p <- plot_grid(pp, pb, labels = c("", ""), align = "h", rel_widths = c(4, 1))
  
  ggsave(filename, plot=p, width = 9, height = 6, dpi=300)
  
}

#plotsingle(zoneid, plotcol)

# 批量画一个地区的
# zoneid：地区
# 输入plotvars: x,y,color,size 4个变量，默认为乡镇、行政区划面积，乡级类型，人口
# yvars，批量的y变量，默认为全部
plotzone <- function(zoneid='330802', plotvars=c('1', 'Z07', 'Z01', 'Z19', '1', ''), yvars=datavars){
  
  for(yvar in yvars){
    plotvars[2] <- yvar
    plotsingle(zoneid, plotvars)
  }
}


# 批量多地区多图
# grade：地区级别，行政区划码的位数，6为县
# 输入plotvars: x,y,color,size 4个变量，默认为乡镇、行政区划面积，乡级类型，人口
# yvars，批量的y变量，默认为全部
plotall <- function(grade=6, plotvars=c('1', 'Z07', 'Z01', 'Z19', '1', ''), yvars=datavars){
 
  for(zone in sort(unique(str_sub(allplotdata$code, 1, grade)))){
    plotzone(zone, plotvars, yvars)
    print(str_c(zone," is ok"))
  }
}

