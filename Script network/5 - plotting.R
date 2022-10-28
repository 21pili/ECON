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

# Importation

network <- readRDS("Intermediate/network_label.rds")

# plotting

p <- simpleNetwork(network, height="100px", width="100px",        
        Source = 1,                 # column number of source
        Target = 2,                 # column number of target
        linkDistance = 2,          # distance between node. Increase this value to have more space between nodes
        charge = -900,                # numeric value indicating either the strength of the node repulsion (negative value) or attraction (positive value)
        fontSize = 14,               # size of the node names
        fontFamily = "serif",       # font og node names
        linkColour = "#666",        # colour of edges, MUST be a common colour for the whole graph
        nodeColour = "#000000",     # colour of nodes, MUST be a common colour for the whole graph
        opacity = 1,              # opacity of nodes. 0=transparent. 1=no transparency
        zoom = T                    # Can you zoom on the figure?
        )

p

# save the widget
library(htmlwidgets)
saveWidget(p, "graph/wg/network_1.html")
