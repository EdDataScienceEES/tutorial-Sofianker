#Sofia Anker 
#Tutorial on ggmapping
#Mapping Sampling locations in the North Sea 
#contact: ankersofiamay@gmail.com
#Began on 15/11/24

#Load Libraries----
library(tidyverse)
library(ggmap)
library(ggplot2)
library(forcats)
library(patchwork)
library(ggdensity)
#Load Data
#Can be found in repository
register_stadiamaps("d3dae1ed-f4db-43ac-b64b-c15410e3ac30",write = FALSE)
North_Sea<-read_csv("~/Desktop/Ecological Measurement /download_3400_'ME5301_ActualPositions_RC20130128.zip'.csv")
str(North_Sea)

#Mapping----
#Define bbox
bbox<- c(-12.650070,49.968448,5.279617,59.880324)
get_stadiamap(bbox = bbox, zoom=5, maptype = "stamen_terrain")
ggmap(map)
#create map using geompoint and ggmap
get_stadiamap(bbox, zoom = 5, maptype = "stamen_terrain") %>% ggmap() +
  geom_point(aes(x = DecLon84, y = DecLat84, colour = CruiseID), data = North_Sea, size = 2)

#creat map using qmplot
qmplot(DecLon84, DecLat84, data = North_Sea, maptype = "stamen_toner_lite", color = I("blue"))

qmplot(DecLon84, DecLat84, data = North_Sea, maptype = "stamen_terrain", color = I("blue"))

qmplot(DecLon84, DecLat84, data = North_Sea, maptype = "stamen_terrain", color = CruiseID)

#map the density of sampling locations 
(hdr_map <- ggmap(map) + 
    geom_hdr(
      aes(DecLon84, DecLat84, fill = after_stat(probs)), data = North_Sea,
      alpha = .5
    ) +
    scale_fill_brewer(palette = "YlOrRd") +
    theme(legend.position = "left", legend.title = element_text('density')))
