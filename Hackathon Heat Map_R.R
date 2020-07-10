library(RColorBrewer)
library(rworldmap)

mapData <- read.csv("covid.csv")
mapData <- mapData[which(mapData$date == "2020-07-09"), ]

mapData <- aggregate(mapData$total_cases_per_million, by=list(location=mapData$location), FUN=sum)
colnames(mapData)[colnames(mapData) == "x"] <- "Total confirmed Covid-19 cases per million people"

# join data to map
worldMapCovid <- joinCountryData2Map( mapData,
                                      nameJoinColumn="location",
                                      joinCode = "NAME" )

# breaks
mybreaks <- c(0,5,10,50,100,500,1000,2000,5000,10000) #last break is arbitrarily high ceiling value

#set color palette
colourPalette <- RColorBrewer::brewer.pal(9, "RdPu")

#plot the map
mapParams <- mapCountryData( worldMapCovid,
                             nameColumnToPlot = "Total confirmed Covid-19 cases per million people",
                             catMethod=mybreaks,
                             colourPalette = colourPalette,
                             numCats = 9,
                             addLegend=FALSE)
do.call(addMapLegend, c(mapParams,
                        legendLabels="all", legendWidth=0.5,
                        legendIntervals="page"))
