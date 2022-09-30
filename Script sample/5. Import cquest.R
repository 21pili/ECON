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
library(data.table)


# Importations ------------------------

eti_siren <- readRDS("Intermediate/eti_siren.rds")

# eti_siren_2016 <- eti_siren %>% filter(annee_base==2016)
# eti_siren_2017 <- eti_siren %>% filter(annee_base==2017)
eti_siren_2018 <- eti_siren %>% filter(annee_base==2018)
eti_siren_2019 <- eti_siren %>% filter(annee_base==2019)
eti_siren_2020 <- eti_siren %>% filter(annee_base==2020)
eti_siren_2021 <- eti_siren %>% filter(annee_base==2021)
eti_siren_2022 <- eti_siren %>% filter(annee_base==2022)

cquest_2018 <- fread("Raw/INSEE/cquest/2018-12/StockEtablissementActif_utf8_geo.csv/StockEtablissementActif_utf8_geo.csv", 
                     sep = ",", 
                     select = c("siren", "siret", "etablissementSiege", "etatAdministratifEtablissement",
                                "enseigne1Etablissement", "activitePrincipaleEtablissement",
                                "longitude", "latitude", "numeroVoieEtablissement",
                                "typeVoieEtablissement", "libelleVoieEtablissement", "codePostalEtablissement",
                                "libelleCommuneEtablissement", "libellePaysEtrangerEtablissement"),
                     keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  filter(
    siren %in% eti_siren_2018$siren
  )

saveRDS(cquest_2018, 'Intermediate/cquest_2018.rds')

rm(cquest_2018)

gc()



cquest_2019 <- fread("Raw/INSEE/cquest/2019-12/StockEtablissementActif_utf8_geo (1).csv/StockEtablissementActif_utf8_geo (1).csv", 
                     sep = ",", 
                     select = c("siren", "siret", "etablissementSiege", "etatAdministratifEtablissement",
                                "enseigne1Etablissement", "activitePrincipaleEtablissement",
                                "longitude", "latitude", "numeroVoieEtablissement",
                                "typeVoieEtablissement", "libelleVoieEtablissement", "codePostalEtablissement",
                                "libelleCommuneEtablissement", "libellePaysEtrangerEtablissement"),
                     keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  filter(
    siren %in% eti_siren_2019$siren
  )


saveRDS(cquest_2019, 'Intermediate/cquest_2019.rds') 

rm(cquest_2019)

gc()



cquest_2020 <- fread("Raw/INSEE/cquest/2020-12/StockEtablissementActif_utf8_geo (2).csv/StockEtablissementActif_utf8_geo (2).csv", 
                     sep = ",", 
                     select = c("siren", "siret", "etablissementSiege", "etatAdministratifEtablissement",
                                "enseigne1Etablissement", "activitePrincipaleEtablissement",
                                "longitude", "latitude", "numeroVoieEtablissement",
                                "typeVoieEtablissement", "libelleVoieEtablissement", "codePostalEtablissement",
                                "libelleCommuneEtablissement", "libellePaysEtrangerEtablissement"),
                     keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  filter(
    siren %in% eti_siren_2020$siren
  )

saveRDS(cquest_2020, 'Intermediate/cquest_2020.rds') 

rm(cquest_2020)

gc()

cquest_2021 <- fread("Raw/INSEE/cquest/2021-12/StockEtablissementActif_utf8_geo (3).csv", 
                     sep = ",", 
                     select = c("siren", "siret", "etablissementSiege", "etatAdministratifEtablissement",
                                "enseigne1Etablissement", "activitePrincipaleEtablissement",
                                "longitude", "latitude", "numeroVoieEtablissement",
                                "typeVoieEtablissement", "libelleVoieEtablissement", "codePostalEtablissement",
                                "libelleCommuneEtablissement", "libellePaysEtrangerEtablissement"),
                     keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  filter(
    siren %in% eti_siren_2021$siren
  )


saveRDS(cquest_2021, 'Intermediate/cquest_2021.rds') 

rm(cquest_2021)

gc()


cquest_2022 <- fread("Raw/INSEE/cquest/2022-06/StockEtablissementActif_utf8_geo (4).csv/StockEtablissementActif_utf8_geo (4).csv", 
                     sep = ",", 
                     select = c("siren", "siret", "etablissementSiege", "etatAdministratifEtablissement",
                                "enseigne1Etablissement", "activitePrincipaleEtablissement",
                                "longitude", "latitude", "numeroVoieEtablissement",
                                "typeVoieEtablissement", "libelleVoieEtablissement", "codePostalEtablissement",
                                "libelleCommuneEtablissement", "libellePaysEtrangerEtablissement"),
                     keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
)%>%
  filter(
    siren %in% eti_siren_2022$siren
  )

saveRDS(cquest_2022, 'Intermediate/cquest_2022.rds')

rm(cquest_2022)

gc()
# Sauvegarde --------------------------------------------------------------


# saveRDS(cquest_2017, 'Intermediate/cquest_2017.rds') 

