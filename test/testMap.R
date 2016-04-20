library(maps)
library(mapproj)
map("state", col="#01B8AA", bg="#374649", proj="albers", param=c(39,45))
points(mapproject(dataset$Longitude, dataset$Latitude))

