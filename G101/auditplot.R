# audit plot

library(tidyverse)
library(stringr)
library(cowplot)

plotsingle <- function(zoneid, plotcol){
  
  xlabel <- varnames[varnames$varid==plotcol[1], 'name']
  ylabel <- varnames[varnames$varid==plotcol[2], 'name']
  clabel <- ''
  slabel <- ''
  
  varid <- 'varid'
  zonelen <- str_count(zoneid)
  codelen <- str_count(allplotdata$code[1])
  
  pdata <- allplotdata[str_sub(allplotdata$code, 1, zonelen)==zoneid, c('code', plotcol)]

  if(nrow(pdata)<1) return()
  
  if(length(plotcol) == 2){
    pdata$ccol=1
    pdata$scol=1
  }else{
    clabel <- varnames[varnames$varid==plotcol[3], 'name']
  }
  
  if(length(plotcol) == 3){
    pdata$scol=1
  }else{
    slabel <- varnames[varnames$varid==plotcol[4], 'name']
  }
  
  colnames(pdata) <- c('code', 'xcol', 'ycol', 'ccol', 'scol')
  pdata <- mutate(pdata, town=str_sub(as.character(code), zonelen+1, codelen))
  
  path <- str_c("./testplot/", zoneid)
  if(!file.exists(path)){
    dir.create(path)
  }
  
  cb_palette <- c('#B22234', "#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442",
                  "#0072B2", "#D55E00", "#CC79A7")
  
  pp <- ggplot(pdata, aes(x=as.factor(xcol), y=ycol, color=ccol, size=scol))
  pp <- pp+ geom_point(alpha=0.8)+geom_text(aes(label=town), size=4, vjust = "inward")
  pp <- pp+labs(x=xlabel, 
                y=ylabel, 
                color=clabel,
                size=slabel,
                title= paste(varid))+
    theme(axis.text.x = element_blank())+
    scale_color_manual(values=cb_palette)
  
  if(nchar(clabel)==0) pp <- pp+guides(color=F)
  if(nchar(slabel)==0) pp <- pp+guides(size=F)
  pp
  pb <- ggplot(pdata, aes(y=ycol))+geom_boxplot()+
    geom_hline(yintercept = mean(pdata$ycol), color="orange",size=1)+
    labs(x='橙色为均值', y="")+
    theme(axis.text.y = element_blank(),axis.text.x = element_blank())
  
  
  p <- plot_grid(pp, pb, labels = c("", ""), align = "h", rel_widths = c(4, 1))
  p
  filename <- str_c('testplot/', zoneid, '/','最小前50位 ', varid,as.character('.png'))
  ggsave(filename, plot=p, width = 8, height = 6)
  
}

plotzone <- function(zoneid){
  
  for(varid in vars){
    print(varid)
    plotsingle(zoneid, varid)
  }
}

Sys.time()

citys <- as.character(3301:3311) 
for(zoneid in citys){
  print(zoneid)
  plotzone(zoneid)
}
