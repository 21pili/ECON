###################################################
#                  Chaire ETIlab                  #
# author : Alexandre Gavaudan                     #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################


# Libraries

library(tidyverse)
library(doParallel)
library(stringr)

# Importations

base_app <- list(
    readRDS("Input/eti_base_app.rds"),
    readRDS("Input/ge_base_app.rds")
    ) %>%
    bind_rows() %>%
    filter(annee_base == 2022)


# Fonctions

to_siren <- function(nom) {
    if (nom %in% base_app$denominationunitelegale) {
        sir <- base_app[denominationunitelegale == nom]$siren
        return(sir)
    }
    return(nom)
}

traitement <- function(df) {
  foreach (i = 0:nrow(df)) %do% {
    nom <- df$Nom[i]
    print(i)
    len <- nchar(nom)
    nom <- substring(nom, first = 1, last = len - 1)
    df$parent[i] <- to_siren(nom[1])
  }
  return(df)
}

dir_def <- readRDS("Input/dir_def.rds") %>%
    filter(
        Titre == "Président" |
        Titre == "président") %>%
    mutate(
        parent = NA
    )

dir_def <- traitement(dir_def)

saveRDS(dir_def, "Intermediate/links.rds")
