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
library(data.table)


# Importations ------------------------

all_sample_siren <- readRDS("Intermediate/all_sample_siren.rds")


all_sample_siren_2018 <- all_sample_siren %>% filter(annee_base==2018)
all_sample_siren_2019 <- all_sample_siren %>% filter(annee_base==2019)
all_sample_siren_2020 <- all_sample_siren %>% filter(annee_base==2020)
all_sample_siren_2021 <- all_sample_siren %>% filter(annee_base==2021)
all_sample_siren_2022 <- all_sample_siren %>% filter(annee_base==2022)


se_all_2018 <-  fread("Raw/INSEE/2018-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
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
    siren %in% all_sample_siren_2018$siren
  )

se_all_2019 <- fread("Raw/INSEE/2019-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
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
    siren %in% all_sample_siren_2019$siren
  )

se_all_2020 <- fread("Raw/INSEE/2020-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
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
    siren %in% all_sample_siren_2020$siren
  )

se_all_2021 <- fread("Raw/INSEE/2021-09-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
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
    siren %in% all_sample_siren_2021$siren
  )

se_all_2022 <- fread("Raw/INSEE/2022-07-01-StockEtablissement_utf8/StockEtablissement_utf8.csv", 
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
    siren %in% all_sample_siren_2022$siren
  )

colnames(se_all_2018) <- tolower(colnames(se_all_2018))
colnames(se_all_2019) <- tolower(colnames(se_all_2019))
colnames(se_all_2020) <- tolower(colnames(se_all_2020))
colnames(se_all_2021) <- tolower(colnames(se_all_2021))
colnames(se_all_2022) <- tolower(colnames(se_all_2022))






##On passe aux ENR





enr_sample_siren <- readRDS("Intermediate/enr_sample_siren.rds")


enr_sample_siren_2018 <- enr_sample_siren %>% filter(annee_base == 2018)
enr_sample_siren_2019 <- enr_sample_siren %>% filter(annee_base == 2019)
enr_sample_siren_2020 <- enr_sample_siren %>% filter(annee_base == 2020)
enr_sample_siren_2021 <- enr_sample_siren %>% filter(annee_base == 2021)
enr_sample_siren_2022 <- enr_sample_siren %>% filter(annee_base == 2022)


se_enr_2018 <- fread("Raw/INSEE/2018-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv",
  sep = ",",
  select = c(
    "siren",
    "siret",
    "datecreationetablissement",
    "numerovoieetablissement",
    "typevoieetablissement",
    "libellevoieetablissement",
    "codepostaletablissement",
    "libellecommuneetablissement",
    "codecommuneetablissement",
    "libellepaysetrangeretablissement",
    "etatadministratifetablissement",
    "nomenclatureactiviteprincipaleetablissement",
    "trancheeffectifsetablissement",
    "activiteprincipaleregistremetiersetablissement",
    "etablissementsiege",
    "activiteprincipaleetablissement"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2018
  ) %>%
  filter(
    siren %in% enr_sample_siren_2018$siren
  )

se_enr_2019 <- fread("Raw/INSEE/2019-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv",
  sep = ",",
  select = c(
    "siren",
    "siret",
    "dateCreationEtablissement",
    "numeroVoieEtablissement",
    "typeVoieEtablissement",
    "libelleVoieEtablissement",
    "codePostalEtablissement",
    "libelleCommuneEtablissement",
    "codeCommuneEtablissement",
    "libellePaysEtrangerEtablissement",
    "etatAdministratifEtablissement",
    "nomenclatureActivitePrincipaleEtablissement",
    "trancheEffectifsEtablissement",
    "activitePrincipaleRegistreMetiersEtablissement",
    "etablissementSiege",
    "activitePrincipaleEtablissement"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2019
  ) %>%
  filter(
    siren %in% enr_sample_siren_2019$siren
  )

se_enr_2020 <- fread("Raw/INSEE/2020-12-01-StockEtablissement_utf8/StockEtablissement_utf8.csv",
  sep = ",",
  select = c(
    "siren",
    "siret",
    "dateCreationEtablissement",
    "numeroVoieEtablissement",
    "typeVoieEtablissement",
    "libelleVoieEtablissement",
    "codePostalEtablissement",
    "libelleCommuneEtablissement",
    "codeCommuneEtablissement",
    "libellePaysEtrangerEtablissement",
    "etatAdministratifEtablissement",
    "nomenclatureActivitePrincipaleEtablissement",
    "trancheEffectifsEtablissement",
    "activitePrincipaleRegistreMetiersEtablissement",
    "etablissementSiege",
    "activitePrincipaleEtablissement"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2020
  ) %>%
  filter(
    siren %in% enr_sample_siren_2020$siren
  )

se_enr_2021 <- fread("Raw/INSEE/2021-09-01-StockEtablissement_utf8/StockEtablissement_utf8.csv",
  sep = ",",
  select = c(
    "siren",
    "siret",
    "dateCreationEtablissement",
    "numeroVoieEtablissement",
    "typeVoieEtablissement",
    "libelleVoieEtablissement",
    "codePostalEtablissement",
    "libelleCommuneEtablissement",
    "codeCommuneEtablissement",
    "libellePaysEtrangerEtablissement",
    "etatAdministratifEtablissement",
    "nomenclatureActivitePrincipaleEtablissement",
    "trancheEffectifsEtablissement",
    "activitePrincipaleRegistreMetiersEtablissement",
    "etablissementSiege",
    "activitePrincipaleEtablissement"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2021
  ) %>%
  filter(
    siren %in% enr_sample_siren_2021$siren
  )

se_enr_2022 <- fread("Raw/INSEE/2022-07-01-StockEtablissement_utf8/StockEtablissement_utf8.csv",
  sep = ",",
  select = c(
    "siren",
    "siret",
    "dateCreationEtablissement",
    "numeroVoieEtablissement",
    "typeVoieEtablissement",
    "libelleVoieEtablissement",
    "codePostalEtablissement",
    "libelleCommuneEtablissement",
    "codeCommuneEtablissement",
    "libellePaysEtrangerEtablissement",
    "etatAdministratifEtablissement",
    "nomenclatureActivitePrincipaleEtablissement",
    "trancheEffectifsEtablissement",
    "activitePrincipaleRegistreMetiersEtablissement",
    "etablissementSiege",
    "activitePrincipaleEtablissement"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2022
  ) %>%
  filter(
    siren %in% enr_sample_siren_2022$siren
  )

colnames(se_enr_2018) <- tolower(colnames(se_enr_2018))
colnames(se_enr_2019) <- tolower(colnames(se_enr_2019))
colnames(se_enr_2020) <- tolower(colnames(se_enr_2020))
colnames(se_enr_2021) <- tolower(colnames(se_enr_2021))
colnames(se_enr_2022) <- tolower(colnames(se_enr_2022))

# -------------------------------------------------------------------------


# Sauvegarde --------------------------------------------------------------

saveRDS(se_all_2018, 'Intermediate/se_all_sample_2018.rds')
saveRDS(se_all_2019, 'Intermediate/se_all_sample_2019.rds')
saveRDS(se_all_2020, 'Intermediate/se_all_sample_2020.rds')
saveRDS(se_all_2021, 'Intermediate/se_all_sample_2021.rds')
saveRDS(se_all_2022, "Intermediate/se_all_sample_2022.rds")



saveRDS(se_enr_2018, "Intermediate/se_enr_sample_2018.rds")
saveRDS(se_enr_2019, "Intermediate/se_enr_sample_2019.rds")
saveRDS(se_enr_2020, "Intermediate/se_enr_sample_2020.rds")
saveRDS(se_enr_2021, "Intermediate/se_enr_sample_2021.rds")
saveRDS(se_enr_2022, "Intermediate/se_enr_sample_2022.rds")