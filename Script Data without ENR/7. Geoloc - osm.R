####################################
#            Chaire ETI            #
# File name:                       #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 16/07/22           #
# Purpose:                         #
# Date last modified: 16/07/22     #
####################################


# Libraries ---------------------------


library(tidyverse)
library(rvest)
library(stringi)
library(jsonlite)
library(foreach)



# Définition de fonction --------------------------------------------------

osm <- function(df){
  
  
  
  df <- df %>%
    mutate(
      lon = NA,
      lat = NA
    )
  
  src_url <- NA
  request <- NA
  response <- NA
  lon <- NA
  lat <- NA

  tryCatch({
  
 foreach(i=1:nrow(df)) %do% {

  print(i)
  
  src_url <- "https://nominatim.openstreetmap.org/search?q="
  
  request <- paste0(src_url, df$adresse[i], " ", df$codecommuneetablissement[i], " ", df$libellecommuneetablissement[i]," ", df$libellepaysetrangeretablissement[i], "&format=geojson") %>%
    trimws(whitespace = "\u00A0|\\s")%>% 
    str_replace_all(" ","\\+")

  response <- read_html(request) %>%
      html_node("p") %>%
      html_text() %>%
      fromJSON()
  
lon <- response$features$geometry$coordinates[[1]][1]
lat <- response$features$geometry$coordinates[[1]][2]

if(!is.null(lat) & !is.null(lon)){
  
  df$lon[i] <- lon
  df$lat[i] <- lat
  
}
}

  
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
  
  return(df)
}

# Importations ------------------------

geo <- readRDS("Intermediate/eti_geo.rds")%>% 
  distinct(siret, .keep_all = T) %>% 
  filter(
    libellepaysetrangeretablissement !=''
  ) 

geo_osm <- osm(geo)

saveRDS(geo_osm, 'Intermediate/geo_osm.rds')

