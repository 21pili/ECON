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

all_siren <- readRDS("Intermediate/all_siren.rds")


all_siren_2018 <- all_siren %>% filter(annee_base==2018)
all_siren_2019 <- all_siren %>% filter(annee_base==2019)
all_siren_2020 <- all_siren %>% filter(annee_base==2020)
all_siren_2021 <- all_siren %>% filter(annee_base==2021)
all_siren_2022 <- all_siren %>% filter(annee_base==2022)


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
    siren %in% all_siren_2018$siren
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
    siren %in% all_siren_2019$siren
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
    siren %in% all_siren_2020$siren
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
    siren %in% all_siren_2021$siren
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
    siren %in% all_siren_2022$siren
  )

colnames(se_2018) <- tolower(colnames(se_2018))
colnames(se_2019) <- tolower(colnames(se_2019))
colnames(se_2020) <- tolower(colnames(se_2020))
colnames(se_2021) <- tolower(colnames(se_2021))
colnames(se_2022) <- tolower(colnames(se_2022))

# -------------------------------------------------------------------------


# Sauvegarde --------------------------------------------------------------

saveRDS(se_2018, 'Intermediate/se_2018.rds')
saveRDS(se_2019, 'Intermediate/se_2019.rds')
saveRDS(se_2020, 'Intermediate/se_2020.rds')
saveRDS(se_2021, 'Intermediate/se_2021.rds')
saveRDS(se_2022, 'Intermediate/se_2022.rds') 

