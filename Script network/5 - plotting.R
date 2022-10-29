###################################################
#                  Chaire ETIlab                  #
# author : Pierre Pili                            #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################


# Libraries

library(igraph)
library(networkD3)
library(tidyverse)
library(doParallel)
library(stringr)
library(htmlwidgets)
library(ggraph)

# Importation

network <- readRDS("Intermediate/network.rds")

nodes <- tibble(siren = unique(c(network$from, network$to))) #nolint

base_app <- list(
    readRDS("Input/eti_base_app.rds") %>% mutate(categorieentreprise = "ETI"),
    readRDS("Input/ge_base_app.rds") %>% mutate(categorieentreprise = "GE")
    ) %>%
    bind_rows() %>%
    filter(annee_base == 2022) %>%
    select(siren, categorieentreprise) %>%
    distinct(siren, categorieentreprise)


return_categorie <- function(sir) {
        if (sir %in% base_app$siren) {
                sub <- subset(base_app, siren == sir)
                return(sub$categorieentreprise)
        }
        return("Dirigeant")
}

nodes$categorie <- sapply(nodes$siren, return_categorie)

mygraph <- graph_from_data_frame(network, vertices = nodes)

V(mygraph)$vertex_degree <- degree(mygraph)

# plotting

# Make the graph


p <- ggraph(mygraph, layout = "fr") +
  geom_edge_link(edge_colour = "black", edge_alpha = 0.2, edge_width = 0.3) +
  geom_node_point(aes(colour = categorie), size = 1, alpha = 1) +
  theme_void() +
  theme(
    plot.margin = unit(c(0, 0, 0, 0), "null"),
    panel.spacing = unit(c(0, 0, 0, 0), "null")
  ) + 
  ggtitle("Graphe des entreprises en 2022, liés à au moins une entreprise du type ETI -> GE", subtitle = "categorie de l'entreprise en 2022")

p

# save the widget

#saveWidget(p, "graph/wg/network_1.html")
