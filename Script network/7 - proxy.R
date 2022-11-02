###################################################
#                  Chaire ETIlab                  #
# author : Pierre Pili                            #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################


# Libraries

library(igraph)
library(tidyverse)
library(ggraph)

# Importations

sousgraphes <- readRDS("Intermediate/sousgraphes_connexes.rds")

base_app <- list(
    readRDS("Input/eti_base_app.rds") %>% mutate(categorieentreprise = "ETI"),
    readRDS("Input/ge_base_app.rds") %>% mutate(categorieentreprise = "GE")
    ) %>%
    bind_rows() %>%
    filter(annee_base == 2022) %>%
    select(siren, categorieentreprise) %>%
    distinct(siren, categorieentreprise)

# Functions

n_nodes <- function(matrix) {
    return(length(unique(c(matrix[, 1], matrix[, 2]))))
}

is_eti <- function(sir) {
    if (sir %in% subset(base_app, categorieentreprise == "ETI")$siren) {
        return(1)
    }
    return(0)
}

is_ge <- function(sir) {
    if (sir %in% subset(base_app, categorieentreprise == "GE")$siren) {
        return(1)
    }
    return(0)
}

n_eti <- function(matrix) {
    res <- 0
    for (vertex in unique(c(matrix[, 1], matrix[, 2]))) {
        res <- res + is_eti(vertex)
    }
    return(res)
}

n_ge <- function(matrix) {
    res <- 0
    for (vertex in unique(c(matrix[, 1], matrix[, 2]))) {
        res <- res + is_ge(vertex)
    }
    return(res)
}



# Traitement

sousgraphes$isousgraphes <- sapply(sousgraphes$structure, graph_from_edgelist)

structures <- tibble(
    structure = sousgraphes$structure
)

structures$n_edges <- sapply(sousgraphes$isousgraphes, gsize)
structures$diameter <- sapply(sousgraphes$isousgraphes, diameter)
structures$degrees <- sapply(sousgraphes$isousgraphes, degree)
structures$n_eti <- sapply(structures$structure, n_eti)
structures$n_ge <- sapply(structures$structure, n_ge)

saveRDS(structures, "Intermediate/structures.rds")
