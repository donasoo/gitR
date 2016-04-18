#推算耕地

reckland <- function(land_0, reduce, verify){
#系数逐年求乘积
reduce$radio <- 1-reduce$radio
reduce_t <- aggregate(x=reduce$radio, by=list(id=reduce$id), FUN=prod)

#合并方案初耕地数和逐年减少系数累计，计算当年耕地
land_t <- merge(x=land_0, y=reduce_t, by.x='id', by.y='id', suffixes = c("",".y"))
#合并核实系数
land_t <- merge(x=land_t, y=verify, by.x='id', by.y='id', suffixes = c("",".y"))
land_t$landt <- land_t$land*land_t$x*land_t$radio

write.csv(land_t, "landt.csv")
return(land_t)
}