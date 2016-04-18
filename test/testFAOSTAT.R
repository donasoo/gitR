#test   FAOSTAT
library(FAOSTAT)
FAOsearch()
getFAO(query = .LastSearch)
FAOquery.df = data.frame(varName = c("arableLand", "cerealExp", "cerealProd"),
                         domainCode = c("RL", "TP", "QC"),
                         itemCode = c(6621, 1944, 1717),
                         elementCode = c(5110, 5922, 5510),
                         stringsAsFactors = FALSE)
FAO.lst = with(FAOquery.df,
               getFAOtoSYB(name = varName, domainCode = domainCode,
                           itemCode = itemCode, elementCode = elementCode,
                           useCHMT = TRUE, outputFormat = 'wide'))

WB.lst = getWDItoSYB(indicator = c("SP.POP.TOTL", "NY.GDP.MKTP.CD"),
                     name = c("totalPopulation", "GDPUSD"),
                     getMetaData = TRUE, printMetaData = TRUE)


p <- ggplot(data=wb, mapping = aes(x=Year, y=totalPopulation, colour=Country))
p+geom_point()
