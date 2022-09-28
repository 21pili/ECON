####################################
#            Chaire ETI            #
# File name: ...                   #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 2022/07/11         #
# Purpose: ...                     #
# Date last modified: 2022/07/05   #
####################################


# =============================================================================
# Librairies
# =============================================================================

library(tidyverse)
library(leaflet)
library(htmlwidgets)
library(sf)
library(RColorBrewer)

# Importations ------------------------------------------------------------


master <- readRDS("Output/base_app.rds") 


# =============================================================================
# Construction de la carte
# =============================================================================

map <- leaflet(master) %>% 
  addProviderTiles(providers$CartoDB.Positron) %>% 
  addMarkers(
    ln = ~longitude, 
    lat = ~latitude,
    label = ~denominationunitelegale, 
    clusterOptions  = markerClusterOptions(
      showCoverageOnHover = FALSE)
  )
