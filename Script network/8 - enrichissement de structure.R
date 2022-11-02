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

structures <- readRDS("Intermediate/structures.rds")

base_app <- list(
    readRDS("Input/eti_base_app.rds") %>% mutate(categorieentreprise = "ETI"),
    readRDS("Input/ge_base_app.rds") %>% mutate(categorieentreprise = "GE")
    ) %>%
    bind_rows() %>%
    filter(annee_base == 2022) %>%
    select(siren, categorieentreprise) %>%
    distinct(siren, categorieentreprise)


# Fonctions utiles

return_categorie <- function(sir) {
        if (sir %in% base_app$siren) {
                sub <- subset(base_app, siren == sir)
                return(sub$categorieentreprise)
        }
        return("Dirigeant")
}

# Affichage de la plus grande structure

structure <- structures %>% arrange(-n_edges) %>% head(50)

boite <- structure$structure[[13]]

yes <- tibble(
        from = boite[, 1],
        to = boite[, 2]
    )

nodes <- tibble(siren = unique(c(yes$from, yes$to)))

nodes$categorie <- sapply(nodes$siren, return_categorie)

graph <- graph_from_data_frame(yes, vertices = nodes)

p <- ggraph(graph, layout = "nicely") +
  geom_edge_link(edge_colour = "black", edge_alpha = 0.2, edge_width = 0.3) +
  geom_node_point(aes(colour = categorie), size = 1, alpha = 1) +
  theme_void() +
  theme(
    plot.margin = unit(c(0, 0, 0, 0), "null"),
    panel.spacing = unit(c(0, 0, 0, 0), "null")
  ) +
  ggtitle("Graphe d'une grosse structure random")

p

#ggsave("graph/trees/GUSTAVIA CONSULTING.png")

