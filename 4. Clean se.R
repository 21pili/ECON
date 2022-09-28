####################################
#            Chaire ETI            #
# File name:                       #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 14/07/22           #
# Purpose:                         #
# Date last modified: 14/07/22     #
####################################


# Libraries ---------------------------


library(tidyverse)


# Importations ------------------------


liste <- list(
  readRDS('Intermediate/se_2018.rds'),
  readRDS('Intermediate/se_2019.rds'),
  readRDS('Intermediate/se_2020.rds'),
  readRDS('Intermediate/se_2021.rds'),
  readRDS('Intermediate/se_2022.rds')

)

data0 <- liste %>%
  map(
    ~.x %>%
      filter(
        (etatadministratifetablissement == 'A' |
           is.na(etatadministratifetablissement ) )
      ) %>%
      mutate_if(is.character, toupper) %>%
      mutate(activiteprincipaleetablissement = paste0(nomenclatureactiviteprincipaleetablissement, ' - ',activiteprincipaleetablissement)) %>%
      group_by(siren, annee_base) %>%
      distinct(
        siret, .keep_all = T
      )%>% 
      arrange(-etablissementsiege) %>%
      summarise(
        nombre_etablissements = n(),
        siret = paste(siret, collapse = ", "),
        plus_ancien_etab = min(datecreationetablissement),
        trancheeffectifsetablissement = paste(trancheeffectifsetablissement, collapse = ", "),
        activiteprincipaleetablissement = paste(activiteprincipaleetablissement, collapse = ", ")
      )%>%
      ungroup()
  ) %>%
  bind_rows()



geo <- liste %>%
  map(
    ~.x %>%
      filter(
        (etatadministratifetablissement == 'A' |
           is.na(etatadministratifetablissement ) ) &
          etablissementsiege == T
      ) %>%
      mutate_if(is.character, toupper) %>%
     mutate(
       adresse = paste0(numerovoieetablissement, ' ',typevoieetablissement, ' ',libellevoieetablissement
                        #, ' ', codepostaletablissement, ' ',libellepaysetrangeretablissement
                        ),
       adresse = trimws(adresse)   
       )
  ) %>%
  bind_rows()

data <- data0 %>% 
  left_join(
    geo %>% 
      select(
        siren, annee_base, siret_siege = siret
      ),
    by = c('siren', 'annee_base')
  )


saveRDS(data, "Intermediate/all_data.rds") 

saveRDS(geo, "Intermediate/all_geo.rds") 
