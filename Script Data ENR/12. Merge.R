####################################
#            Chaire ETI            #
# File name:  ETI theme            #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 09/05/22           #
# Purpose:                         #
# Date last modified: 09/05/22     #
####################################


# Libraries ---------------------------


library(tidyverse)
library(geosphere)
library(doParallel)
library(readxl)

# Importations ------------------------------------------------------------

# Libelle tranche

tranche <- read_excel("Raw/INSEE/modalites effectif.xlsx", col_names = F ) %>% 
  setNames(c('trancheeffectifsunitelegale','libtrancheeffectifsunitelegale'))

# Liste des Unités Légales

enr_siren <- readRDS("Intermediate/enr_siren.rds") %>% 
  left_join(
    tranche, 
    by = "trancheeffectifsunitelegale"
  )

# Données des établissements de chaque unité légale

eti_data <- readRDS("Intermediate/eti_data.rds")

# Geolocalisation des sièges selon plusieurs sources

geo_ban <- readRDS("Intermediate/geo_ban.rds")

geo_cquest <- readRDS("Intermediate/geo_cquest.rds")

geo_osm <- readRDS("Intermediate/geo_osm.rds")



# Les données de CA; résultat et effectifs d'Infogreffe

final_scrap <- readRDS("Intermediate/scraps/final.rds") %>% 
  filter(
    !is.na(cloture)
  ) %>% 
  select(
    -cloture
  ) %>% 
  distinct(
    annee, liste, .keep_all = T
  ) %>% 
  mutate(
    ca = ifelse(ca=='',NA,ca),
    resultat=ifelse(resultat=='',NA,resultat),
    effectif = ifelse(effectif=='',NA,effectif)
  ) %>% 
  mutate(
ca = str_replace_all(ca, "\u00A0|\\s", ""),
resultat = str_replace_all(resultat, "\u00A0|\\s", ""),
effectif = str_replace_all(effectif, "\u00A0|\\s", ""),

ca = str_replace_all(ca, "K", "000"),
resultat = str_replace_all(resultat, "K", "000"),
effectif = str_replace_all(effectif, "K", "000"),

  )

# Construction de la base -------------------------------------------------


data <- enr_siren %>%
  left_join(
    eti_data,
    by = c('siren', 'annee_base')
  ) %>%
  left_join(
    geo_cquest %>% 
      select(siret_siege=siret, long_cq = longitude, lat_cq = latitude),
    by = 'siret_siege'
  ) %>%
  left_join(
    geo_ban %>% 
      select(siret_siege=siret, long_ban = lon, lat_ban = lat, libellepaysetrangeretablissement),
    by = 'siret_siege'
  ) %>% 
  left_join(
    geo_osm %>% 
      select(siret_siege=siret, long_osm = lon, lat_osm = lat),
    by = 'siret_siege'
  ) %>% 
  left_join(
    final_scrap %>% rename(siren = liste, annee_base = annee),
    by = c('siren', 'annee_base')
  )%>% 
  mutate(
    dist= NA
  )

data_f <- data

# detectCores()
# 
# cl <- makeCluster(8)
# 
# registerDoParallel(cl)
# 
# foreach(i=1:nrow(data), .combine = "c", .packages = c('tidyverse', "geosphere"))%dopar%{
#   
#   coords_cq=NA
#   
#   coords_ban=NA
#   
#   t = NA
#   
#   if(!is.na(data$long_cq[i]) & 
#      !is.na(data$lat_cq[i]) &
#      !is.na(data$long_ban[i])&
#      !is.na(data$lat_ban[i])){
#   
#   print(i)
#   
#   coords_cq = c(data$long_cq[i],data$lat_cq[i])
#    
#   coords_ban = c(data$long_ban[i], data$lat_ban[i])
#   
#   t = distGeo(coords_cq, coords_ban) 
#   
#   data_f$dist[i]=t
#   
#   }
#   
#   return(data_f)
#   
# }
# 
# missing <- data_f %>% distinct(siret_siege, .keep_all = T) %>% filter(is.na(dist))
# 
# chelou <- data_f %>% distinct(siret_siege, .keep_all = T) %>% filter(!is.na(dist)&dist>5000) 

data_def = data_f %>% 
  mutate(                                    # 2659 na pour cq dont (2659 - 1462) sont à l'étranger
    longitude = long_cq,
    latitude = lat_cq,
    longitude = case_when(
      !is.na(longitude) ~ longitude,
      is.na(longitude) & libellepaysetrangeretablissement == '' ~long_ban,
      TRUE ~long_osm
    ),
    latitude = case_when(
      !is.na(latitude) ~ latitude,
      is.na(latitude) & libellepaysetrangeretablissement == '' ~lat_ban,
      TRUE ~lat_osm
    )
  ) %>% 
  filter(
    libellepaysetrangeretablissement ==''
  ) %>% 
  select(
  -c("trancheeffectifsunitelegale","prenomusuelunitelegale", "sexeunitelegale", "nomunitelegale",
     "etatadministratifunitelegale","categorieentreprise",
     "long_cq","lat_cq",'long_ban', "lat_ban", "lat_osm", "long_osm", "dist", "libellepaysetrangeretablissement")
  ) %>% # 1076 manquants
  mutate(
    dum = substr(activiteprincipaleunitelegale,0,2)
    ) %>% 
  filter(
    dum != "84" &  # Administration 
    dum != "86"    # Santé
  ) %>% 
  select(
    -dum
  )

saveRDS(data_def,'Output/base_app_enr.rds')

#saveRDS(missing, 'Intermediate/missing.rds')
