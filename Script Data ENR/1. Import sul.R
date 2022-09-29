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
library(data.table)


# Importations ------------------------

# sul_2016 <- fread("Raw/INSEE/cquest/sirene_201612_L_M/sirc-17804_9075_14209_201612_L_M_20170104_171522721.csv", 
#                   sep = ";",
#                   select = c("SIREN", "L1_NORMALISEE", "APET700", "SIEGE", "CATEGORIE"),
#                   colClasses = c(rep("character",100))
# ) %>%
#   setNames(c("siren","denominationunitelegale","activiteprincipaleunitelegale","siege", "categorieentreprise")) %>%
#   mutate(activiteprincipaleunitelegale = paste0("APET700 - ",activiteprincipaleunitelegale),
#          etatadministratifunitelegale = 'A',
#          economiesocialesolidaireunitelegale = NA_character_,
#          annee_base = 2016) %>%
#   filter(siege==1) %>%
#   select(-siege)
# 
# 
# sul_2017 <- fread("Raw/INSEE/cquest/geo_sirene 2017.csv/geo_sirene.csv", 
#                      sep = ",", 
#                      select = c("SIREN", "L1_NORMALISEE", "APET700", "SIEGE", "CATEGORIE"),
#                   colClasses = c(rep("character",91))
#                      ) %>%
#   setNames(c("siren","denominationunitelegale","activiteprincipaleunitelegale","siege", "categorieentreprise")) %>%
#   mutate(activiteprincipaleunitelegale = paste0("APET700 - ",activiteprincipaleunitelegale),
#          etatadministratifunitelegale = 'A',
#          economiesocialesolidaireunitelegale = NA_character_,
#          annee_base = 2017) %>%
#   filter(siege==1) %>%
#   select(-siege)


sul_2018 <-  fread("Raw/INSEE/2018-12-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv", 
                   sep = ",",
                   select = c("siren",
                              "denominationunitelegale",
                              "datecreationunitelegale", 
                              "prenomusuelunitelegale", 
                              "sexeunitelegale", 
                              "trancheeffectifsunitelegale", 
                              "nomunitelegale", 
                              "categoriejuridiqueunitelegale", 
                              "activiteprincipaleunitelegale",
                              "etatadministratifunitelegale",
                              "categorieentreprise",
                              "economiesocialesolidaireunitelegale"),
                   keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
                   ) %>%
  mutate(
    annee_base = 2018
  ) 

sul_2019 <- fread("Raw/INSEE/2019-12-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "denominationUniteLegale",
                             "dateCreationUniteLegale", 
                             "prenomUsuelUniteLegale", 
                             "sexeUniteLegale", 
                             "trancheEffectifsUniteLegale", 
                             "nomUniteLegale", 
                             "categorieJuridiqueUniteLegale", 
                             "activitePrincipaleUniteLegale",
                             "etatAdministratifUniteLegale",
                             "categorieEntreprise",
                             "economieSocialeSolidaireUniteLegale"),
                  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
                  ) %>%
  mutate(
    annee_base = 2019
  )

sul_2020 <- fread("Raw/INSEE/2020-12-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "denominationUniteLegale",
                             "dateCreationUniteLegale", 
                             "prenomUsuelUniteLegale", 
                             "sexeUniteLegale", 
                             "trancheEffectifsUniteLegale", 
                             "nomUniteLegale", 
                             "categorieJuridiqueUniteLegale", 
                             "activitePrincipaleUniteLegale",
                             "etatAdministratifUniteLegale",
                             "categorieEntreprise",
                             "economieSocialeSolidaireUniteLegale"),
                  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
                  ) %>%
  mutate(
    annee_base = 2020
  ) 

sul_2021 <- fread("Raw/INSEE/2021-09-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "denominationUniteLegale",
                             "dateCreationUniteLegale", 
                             "prenomUsuelUniteLegale", 
                             "sexeUniteLegale", 
                             "trancheEffectifsUniteLegale", 
                             "nomUniteLegale", 
                             "categorieJuridiqueUniteLegale", 
                             "activitePrincipaleUniteLegale",
                             "etatAdministratifUniteLegale",
                             "categorieEntreprise",
                             "economieSocialeSolidaireUniteLegale"),
                  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
                  ) %>%
  mutate(
    annee_base = 2021
  ) 

sul_2022 <- fread("Raw/INSEE/2022-07-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                              "denominationUniteLegale",
                              "dateCreationUniteLegale", 
                              "prenomUsuelUniteLegale", 
                              "sexeUniteLegale", 
                              "trancheEffectifsUniteLegale", 
                              "nomUniteLegale", 
                              "categorieJuridiqueUniteLegale", 
                              "activitePrincipaleUniteLegale",
                              "etatAdministratifUniteLegale",
                              "categorieEntreprise",
                              "economieSocialeSolidaireUniteLegale"),
                  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
                  ) %>%
  mutate(
    annee_base = 2022
  ) 

colnames(sul_2018) <- tolower(colnames(sul_2018))
colnames(sul_2019) <- tolower(colnames(sul_2019))
colnames(sul_2020) <- tolower(colnames(sul_2020))
colnames(sul_2021) <- tolower(colnames(sul_2021))
colnames(sul_2022) <- tolower(colnames(sul_2022))

# saveRDS(sul_2016, 'Intermediate/sul_2016.rds')
# saveRDS(sul_2017, 'Intermediate/sul_2017.rds')
saveRDS(sul_2018, 'Intermediate/sul_2018.rds')
saveRDS(sul_2019, 'Intermediate/sul_2019.rds')
saveRDS(sul_2020, 'Intermediate/sul_2020.rds')
saveRDS(sul_2021, 'Intermediate/sul_2021.rds')
saveRDS(sul_2022, 'Intermediate/sul_2022.rds') 

