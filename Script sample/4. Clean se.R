#######################################
#            Chaire ETI               #
# File name:                          #
# Author: Alexandre Gavaudan          #
# Email: alexandregavaudan0@gmail.com #
# Date created: 30/09/22              #
# Purpose:                            #
# Date last modified: 30/09/22        #
#######################################

# Libraries ---------------------------


library(tidyverse)


# Importations ------------------------



liste_all <- list(
  readRDS("Intermediate/se_all_sample_2018.rds"),
  readRDS("Intermediate/se_all_sample_2019.rds"),
  readRDS("Intermediate/se_all_sample_2020.rds"),
  readRDS("Intermediate/se_all_sample_2021.rds"),
  readRDS("Intermediate/se_all_sample_2022.rds")
)

liste_enr <- list(
  readRDS("Intermediate/se_enr_sample_2018.rds"),
  readRDS("Intermediate/se_enr_sample_2019.rds"),
  readRDS("Intermediate/se_enr_sample_2020.rds"),
  readRDS("Intermediate/se_enr_sample_2021.rds"),
  readRDS("Intermediate/se_enr_sample_2022.rds")
)

data0_all <- liste_all %>%
  map(
    ~ .x %>%
      filter(
        (etatadministratifetablissement == "A" |
          is.na(etatadministratifetablissement))
      ) %>%
      mutate_if(is.character, toupper) %>%
      mutate(activiteprincipaleetablissement = paste0(nomenclatureactiviteprincipaleetablissement, " - ", activiteprincipaleetablissement)) %>%
      group_by(siren, annee_base) %>%
      distinct(
        siret,
        .keep_all = T
      ) %>%
      arrange(-etablissementsiege) %>%
      summarise(
        nombre_etablissements = n(),
        siret = paste(siret, collapse = ", "),
        plus_ancien_etab = min(datecreationetablissement),
        trancheeffectifsetablissement = paste(trancheeffectifsetablissement, collapse = ", "),
        activiteprincipaleetablissement = paste(activiteprincipaleetablissement, collapse = ", ")
      ) %>%
      ungroup()
  ) %>%
  bind_rows()

geo_all <- liste_all %>%
  map(
    ~ .x %>%
      filter(
        (etatadministratifetablissement == "A" |
          is.na(etatadministratifetablissement)) &
          etablissementsiege == T
      ) %>%
      mutate_if(is.character, toupper) %>%
      mutate(
        adresse = paste0(
          numerovoieetablissement, " ", typevoieetablissement, " ", libellevoieetablissement
          # , ' ', codepostaletablissement, ' ',libellepaysetrangeretablissement
        ),
        adresse = trimws(adresse)
      )
  ) %>%
  bind_rows()

data_all <- data0_all %>%
  left_join(
    geo_all %>%
      select(
        siren, annee_base,
        siret_siege = siret
      ),
    by = c("siren", "annee_base")
  )


saveRDS(data_all, "Intermediate/all_data.rds")

saveRDS(geo_all, "Intermediate/all_geo.rds")




data0_enr <- liste_enr %>%
  map(
    ~ .x %>%
      filter(
        (etatadministratifetablissement == "A" |
          is.na(etatadministratifetablissement))
      ) %>%
      mutate_if(is.character, toupper) %>%
      mutate(activiteprincipaleetablissement = paste0(nomenclatureactiviteprincipaleetablissement, " - ", activiteprincipaleetablissement)) %>%
      group_by(siren, annee_base) %>%
      distinct(
        siret,
        .keep_all = T
      ) %>%
      arrange(-etablissementsiege) %>%
      summarise(
        nombre_etablissements = n(),
        siret = paste(siret, collapse = ", "),
        plus_ancien_etab = min(datecreationetablissement),
        trancheeffectifsetablissement = paste(trancheeffectifsetablissement, collapse = ", "),
        activiteprincipaleetablissement = paste(activiteprincipaleetablissement, collapse = ", ")
      ) %>%
      ungroup()
  ) %>%
  bind_rows()

geo_enr <- liste_enr %>%
  map(
    ~ .x %>%
      filter(
        (etatadministratifetablissement == "A" |
          is.na(etatadministratifetablissement)) &
          etablissementsiege == T
      ) %>%
      mutate_if(is.character, toupper) %>%
      mutate(
        adresse = paste0(
          numerovoieetablissement, " ", typevoieetablissement, " ", libellevoieetablissement
          # , ' ', codepostaletablissement, ' ',libellepaysetrangeretablissement
        ),
        adresse = trimws(adresse)
      )
  ) %>%
  bind_rows()

data_enr <- data0_enr %>%
  left_join(
    geo_enr %>%
      select(
        siren, annee_base,
        siret_siege = siret
      ),
    by = c("siren", "annee_base")
  )


saveRDS(data_enr, "Intermediate/enr_data.rds")

saveRDS(geo_enr, "Intermediate/enr_geo.rds")