##################################################
#                  Chaire ETIlab                 #
# author : Pierre Pili                           #
# modified : 17/10/22                            #                                                                               # nolint
# email : pierre.pili@etu.minesparis.psl.eu      #
# phone : 06 78 16 28 99                         #
##################################################

#Libraries

library(tidyverse)

#Importations

siren_na <- readRDS("Intermediate/histoireETI-GE.rds") %>%
  filter(is.na(categorie2018) |
         is.na(categorie2019) |
         is.na(categorie2020) |
         is.na(categorie2021) |
         is.na(categorie2022)) %>%
  select(siren)

pme_switch <- readRDS("Input/pme_base_app.rds") %>%
  filter(siren %in% siren_na$siren)

saveRDS(pme_switch, "Intermediate/pme_switch.rds")
