
require(reshape2)

#读取系统中导入的本级数据并转换格式
#系统导出的本级数据格式是长格式
#要转化成宽格式
getDData <- function(odata, idlen=12, Prefix="D", fill=FALSE){

  odata$id <- substr(odata$SURVEYOBJECTID, 3, idlen+2)
  
  odata2 <- odata[,c("id", "REPORTPERIOD", "MODELID", "VALUE")]
  vv <- setdiff(min(odata$MODELID):max(odata$MODELID), unique(odata$MODELID))
  
  if(length(vv)>0 && fill){
    id <- unique(odata$id)
    rp <- unique(odata$REPORTPERIOD)
    
    ids <- rep(id, times=length(vv))
    vvs <- rep(vv, each=length(id))
    rps <- rep(rp, each=length(ids))
    
    ids <- rep(ids, times=length(rp))
    vvs <- rep(vvs, times=length(rp))
    
    bc <- data.frame(id=ids, MODELID=vvs, REPORTPERIOD=rps, VALUE=0, stringsAsFactors = FALSE)
    odata2 <- rbind(odata2, bc)
  }
  
  odata2$MODELID <- paste(Prefix, odata2$MODELID+1000 , sep = "")
  
  ddata <- odata2[,c("id", "REPORTPERIOD", "MODELID", "VALUE")]
  ddata2 <- dcast(ddata, id+REPORTPERIOD ~ MODELID, value.var = "VALUE")
  
  return(ddata2)

}

