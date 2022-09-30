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



sul_sample_2018 <- fread("Raw/INSEE/2018-12-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv",
  sep = ",",
  nrows = 50,
  select = c(
    "siren",
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
    "economiesocialesolidaireunitelegale"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2018
  )

sul_sample_2019 <- fread("Raw/INSEE/2019-12-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv",
  nrows = 50,
  sep = ",",
  select = c(
    "siren",
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
    "economieSocialeSolidaireUniteLegale"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2019
  )

sul_sample_2020 <- fread("Raw/INSEE/2020-12-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv",
  nrows = 50
  sep = ",",
  select = c(
    "siren",
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
    "economieSocialeSolidaireUniteLegale"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2020
  )

sul_sample_2021 <- fread("Raw/INSEE/2021-09-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv",
  sep = ",",
  nrows = 50,
  select = c(
    "siren",
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
    "economieSocialeSolidaireUniteLegale"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2021
  )

sul_sample_2022 <- fread("Raw/INSEE/2022-07-01-StockUniteLegale_utf8/StockUniteLegale_utf8.csv",
  sep = ",",
  nrows = 50,
  select = c(
    "siren",
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
    "economieSocialeSolidaireUniteLegale"
  ),
  keepLeadingZeros = getOption("datatable.keepLeadingZeros", TRUE)
) %>%
  mutate(
    annee_base = 2022
  )

colnames(sul_sample_2018) <- tolower(colnames(sul_sample_2018))
colnames(sul_sample_2019) <- tolower(colnames(sul_sample_2019))
colnames(sul_sample_2020) <- tolower(colnames(sul_sample_2020))
colnames(sul_sample_2021) <- tolower(colnames(sul_sample_2021))
colnames(sul_sample_2022) <- tolower(colnames(sul_sample_2022))

# saveRDS(sul_sample_2016, 'Intermediate/sul_sample_2016.rds')
# saveRDS(sul_sample_2017, 'Intermediate/sul_sample_2017.rds')
saveRDS(sul_sample_2018, "Intermediate/sul_sample_2018.rds")
saveRDS(sul_sample_2019, "Intermediate/sul_sample_2019.rds")
saveRDS(sul_sample_2020, "Intermediate/sul_sample_2020.rds")
saveRDS(sul_sample_2021, "Intermediate/sul_sample_2021.rds")
saveRDS(sul_sample_2022, "Intermediate/sul_sample_2022.rds")
