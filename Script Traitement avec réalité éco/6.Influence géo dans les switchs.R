################################################## @
#                  Chaire ETIlab                  #
# author : Alexandre Gavaudan                     #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################

# Library

library(tidyverse)

# Importation

data <- readRDS("Intermediate/ge_eti_insee_historisée.rds")

ggplot(data = data %>%
    filter(lat > 8 & long > -10)) +
    geom_point(mapping = aes(x = long, y = lat), alpha = 0.5, size = 0.1) +
        labs(
            title = "Mapping des GE et ETI en France métropolitaine"
        )

ggsave("Mapping des GE et ETI en France métropolitaine.png", path = "graph/2.Analyse avec réalité éco")


ggplot(data = data %>%
    filter(lat > 8 & long > -10)) +
    geom_point(mapping = aes(x = long, y = lat, color = switch), alpha = 0.5, size = 0.1) + 
    labs(
        title = "Mapping des GE et ETI en France métropolitaine par changement"
    )

ggsave("Mapping des GE et ETI en France métropolitaine par changement.png", path = "graph/2.Analyse avec réalité éco")

ggplot(data = data %>%
    filter(lat > 8 & long > -10 & switch == "sortant")) +
    geom_point(mapping = aes(x = long, y = lat, color = secteur), alpha = 0.5, size = 0.5) +
    labs(
        title = "Carte des UL des ETI devenant GE par secteur"
    )
 
ggsave("Carte des UL des ETI devenant GE par secteur.png", path = "graph/2.Analyse avec réalité éco")

ggplot(data = data %>%
    filter(lat > 8 & long > -10 & switch == "sortant")) +
    geom_point(mapping = aes(x = long, y = lat), alpha = 0.5, size = 0.1) +
    labs(
        title = "Carte des UL des ETI devenant GE"
    )

ggsave("Carte des UL des ETI devenant GE.png", path = "graph/2.Analyse avec réalité éco")

