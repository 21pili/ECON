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
  readRDS('Intermediate/sul_2018.rds'),
  readRDS('Intermediate/sul_2019.rds'),
  readRDS('Intermediate/sul_2020.rds'),
  readRDS('Intermediate/sul_2021.rds'),
  readRDS('Intermediate/sul_2022.rds')
)


data <- liste %>%
  map(
    ~.x %>%
      filter( 
          (categorieEntreprise == 'GE') &
          (
            (etatadministratifunitelegale == 'A' |
           is.na(etatadministratifunitelegale)) &
          (economiesocialesolidaireunitelegale != 'O' | # nolint
           is.na(economiesocialesolidaireunitelegale))
          )
      ) %>%
      mutate_if(is.character, toupper)
  ) %>%
  bind_rows()


saveRDS(data, "Intermediate/ge_siren.rds")
