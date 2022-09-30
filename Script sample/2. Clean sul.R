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


liste <- list(
  readRDS("Intermediate/sul_sample_2018.rds"),
  readRDS("Intermediate/sul_sample_2019.rds"),
  readRDS("Intermediate/sul_sample_2020.rds"),
  readRDS("Intermediate/sul_sample_2021.rds"),
  readRDS("Intermediate/sul_sample_2022.rds")
  # readRDS('Intermediate/sul_sample_2017.rds'),
  # readRDS('Intermediate/sul_sample_2016.rds')
)


data_all <- liste %>% # data_all contient tous les types d'entreprises sauf ceux n'ayant pas leur categorie référencée
  map(
    ~ .x %>%
      filter(
        categorieentreprise != "" &
        (etatadministratifunitelegale == "A" |
          is.na(etatadministratifunitelegale)) &
          (economiesocialesolidaireunitelegale != "O" |
            is.na(economiesocialesolidaireunitelegale))
      ) %>%
      mutate_if(is.character, toupper)
  ) %>%
  bind_rows()

data_enr <- liste %>% # data_enr contient toutes entreprises n'ayant pas leur catégorieentreprise référencée
  map(
    ~ .x %>%
      filter(
        categorieentreprise == "" &
        (etatadministratifunitelegale == "A" |
          is.na(etatadministratifunitelegale)) &
          (economiesocialesolidaireunitelegale != "O" |
            is.na(economiesocialesolidaireunitelegale))
      ) %>%
      mutate_if(is.character, toupper)
  ) %>%
  bind_rows()


saveRDS(data_all, "Intermediate/all_sample_siren.rds")
saveRDS(data_enr, "Intermediate/enr_sample_siren.rds")
