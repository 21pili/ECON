###################################################
#                  Chaire ETIlab                  #
# author : Pierre Pili                            #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################


# Libraries

library(tidyverse)
library(doParallel)
library(stringr)

# Importations


base_app <- base_app <- list(
    readRDS("Input/eti_base_app.rds"),
    readRDS("Input/ge_base_app.rds")
    ) %>%
    bind_rows() %>%
    filter(annee_base == 2022)

network <- readRDS("Intermediate/network.rds")

from <- network$from
to <- network$to

# functions 

to_denomination <- function(sir) {
    if (sir %in% base_app$siren){
        sub <- subset(base_app, siren == sir)
        return(sub$denominationunitelegale)
    }
    return(sir)
}

traitement <- function(liste) {
    res <- c()
    for (sir in liste) {
        res <- res %>% append(to_denomination(sir))
    }
    return(res)
}

network_nom <- tibble(
        traitement(from),
        traitement(to)
    )

saveRDS(network_nom, "Intermediate/network_label.rds")
