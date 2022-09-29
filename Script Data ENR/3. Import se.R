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

enr_siren <- readRDS("Intermediate/enr_siren.rds")

# enr_siren_2016 <- enr_siren %>% filter(annee_base==2016)
# enr_siren_2017 <- enr_siren %>% filter(annee_base==2017)
enr_siren_2018 <- enr_siren %>% filter(annee_base==2018)
enr_siren_2019 <- enr_siren %>% filter(annee_base==2019)
enr_siren_2020 <- enr_siren %>% filter(annee_base==2020)
enr_siren_2021 <- enr_siren %>% filter(annee_base==2021)
enr_siren_2022 <- enr_siren %>% filter(annee_base==2022)

# se_2016 <- fread("Raw/INSEE/cquest/sirene_201612_L_M/sirc-17804_9075_14209_201612_L_M_20170104_171522721.csv",
#                   sep = ";",
#                   select = c("SIREN",
# "L1_NORMALISEE",
# "L4_NORMALISEE",
# "L5_NORMALISEE",
# "L6_NORMALISEE",
# "L7_NORMALISEE",
# "APET700",
# "SIEGE",
# "LIBTEFET")
# ) %>%
#   mutate(adresse = trimws(paste0(L4_NORMALISEE, ' ', L5_NORMALISEE, ' ', L6_NORMALISEE, ' ',L7_NORMALISEE))) %>%
#   setNames(c("siren","denominationunitelegale", "adresse", "activiteprincipaleetablissement","etablissementsiege", 'trancheeffectifsetablissement')) %>%
#   mutate(activiteprincipaleunitelegale = paste0("APET700 - ",activiteprincipaleunitelegale),
#          etatadministratifunitelegale = 'A',
#          economiesocialesolidaireunitelegale = NA_character_,
#          annee_base = 2016) %>%


# 
# 
# se_2017 <- fread("Raw/INSEE/cquest/geo_sirene 2017.csv/geo_sirene.csv", 
#                      sep = ",", 
#                      select = c("SIREN", "L1_NORMALISEE", "APET700", "SIEGE", "CATEGORIE")
#                      ) %>%
#   setNames(c("siren","denominationunitelegale","activiteprincipaleunitelegale","siege", "categorieentreprise")) %>%
#   mutate(activiteprincipaleunitelegale = paste0("APET700 - ",activiteprincipaleunitelegale),
#          etatadministratifunitelegale = 'A',
#          economiesocialesolidaireunitelegale = NA_character_,
#          annee_base = 2017) %>%
#   filter(siege==1) %>%
#   select(-siege)


se_2018 <-  fread("Raw/INSEE/2018-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
                   sep = ",",
                   select = c("siren",
                              "siret",
                              "datecreationetablissement",
                              "numerovoieetablissement",
                              "typevoieetablissement",
                              "libellevoieetablissement",
                              "codepostaletablissement",
                              "libellecommuneetablissement",
                              "codecommuneetablissement",
                              "libellepaysetrangeretablissement",
                              "etatadministratifetablissement" ,
                              "nomenclatureactiviteprincipaleetablissement",
                              "trancheeffectifsetablissement",
                              "activiteprincipaleregistremetiersetablissement",
                              "etablissementsiege",
                              "activiteprincipaleetablissement" 
                              ),
                  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)) %>%
  mutate(
    annee_base = 2018
  ) %>%
  filter(
    siren %in% enr_siren_2018$siren
  )

se_2019 <- fread("Raw/INSEE/2019-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "siret",
                             "dateCreationEtablissement",
                             "numeroVoieEtablissement",
                             "typeVoieEtablissement",
                             "libelleVoieEtablissement",
                             "codePostalEtablissement",
                             "libelleCommuneEtablissement",
                             "codeCommuneEtablissement",
                             "libellePaysEtrangerEtablissement",
                             "etatAdministratifEtablissement" ,
                             "nomenclatureActivitePrincipaleEtablissement",
                             "trancheEffectifsEtablissement",
                             "activitePrincipaleRegistreMetiersEtablissement",
                             "etablissementSiege",
                             "activitePrincipaleEtablissement" 
                             ),
                 keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)) %>%
  mutate(
    annee_base = 2019
  ) %>%
  filter(
    siren %in% enr_siren_2019$siren
  )

se_2020 <- fread("Raw/INSEE/2020-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "siret",
                             "dateCreationEtablissement",
                             "numeroVoieEtablissement",
                             "typeVoieEtablissement",
                             "libelleVoieEtablissement",
                             "codePostalEtablissement",
                             "libelleCommuneEtablissement",
                             "codeCommuneEtablissement",
                             "libellePaysEtrangerEtablissement",
                             "etatAdministratifEtablissement" ,
                             "nomenclatureActivitePrincipaleEtablissement",
                             "trancheEffectifsEtablissement",
                             "activitePrincipaleRegistreMetiersEtablissement",
                             "etablissementSiege",
                             "activitePrincipaleEtablissement" 
                  ),
                 keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)) %>%
  mutate(
    annee_base = 2020
  ) %>%
  filter(
    siren %in% enr_siren_2020$siren
  )

se_2021 <- fread("Raw/INSEE/2021-09-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "siret",
                             "dateCreationEtablissement",
                             "numeroVoieEtablissement",
                             "typeVoieEtablissement",
                             "libelleVoieEtablissement",
                             "codePostalEtablissement",
                             "libelleCommuneEtablissement",
                             "codeCommuneEtablissement",
                             "libellePaysEtrangerEtablissement",
                             "etatAdministratifEtablissement" ,
                             "nomenclatureActivitePrincipaleEtablissement",
                             "trancheEffectifsEtablissement",
                             "activitePrincipaleRegistreMetiersEtablissement",
                             "etablissementSiege",
                             "activitePrincipaleEtablissement" 
                  ),
                 keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)) %>%
  mutate(
    annee_base = 2021
  ) %>%
  filter(
    siren %in% enr_siren_2021$siren
  )

se_2022 <- fread("Raw/INSEE/2022-07-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
                  sep = ",",
                  select = c("siren",
                             "siret",
                             "dateCreationEtablissement",
                             "numeroVoieEtablissement",
                             "typeVoieEtablissement",
                             "libelleVoieEtablissement",
                             "codePostalEtablissement",
                             "libelleCommuneEtablissement",
                             "codeCommuneEtablissement",
                             "libellePaysEtrangerEtablissement",
                             "etatAdministratifEtablissement" ,
                             "nomenclatureActivitePrincipaleEtablissement",
                             "trancheEffectifsEtablissement",
                             "activitePrincipaleRegistreMetiersEtablissement",
                             "etablissementSiege",
                             "activitePrincipaleEtablissement" 
                  ),
                 keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)) %>%
  mutate(
    annee_base = 2022
  ) %>%
  filter(
    siren %in% enr_siren_2022$siren
  )

colnames(se_2018) <- tolower(colnames(se_2018))
colnames(se_2019) <- tolower(colnames(se_2019))
colnames(se_2020) <- tolower(colnames(se_2020))
colnames(se_2021) <- tolower(colnames(se_2021))
colnames(se_2022) <- tolower(colnames(se_2022))

# -------------------------------------------------------------------------


# Sauvegarde --------------------------------------------------------------


# saveRDS(se_2016, 'Intermediate/se_2016.rds')
# saveRDS(se_2017, 'Intermediate/se_2017.rds')
saveRDS(se_2018, 'Intermediate/se_2018.rds')
saveRDS(se_2019, 'Intermediate/se_2019.rds')
saveRDS(se_2020, 'Intermediate/se_2020.rds')
saveRDS(se_2021, 'Intermediate/se_2021.rds')
saveRDS(se_2022, 'Intermediate/se_2022.rds') 

