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

# Traitement 

ggplot(data = data) +
    geom_bar(mapping = aes(y = age)) +
    labs(
        title = "Répartition des ages au sein des UL des ETI et GE"
    )

ggsave("Répartition des ages au sein des UL des ETI et GE.png", path = "graph/2.Analyse avec réalité éco")

ggplot(data = data %>% filter(switch == "entrant")) +
    geom_bar(mapping = aes(y = age)) +
    labs(
        title = "Répartition des ages au sein des UL des GE devenant ETI"
    )
ggsave("Répartition des ages au sein des UL des GE devenant ETI.png", path = "graph/2.Analyse avec réalité éco")

ggplot(data = data) +
    geom_bar(
        mapping = aes(x = switch, fill = age),
        position = "fill"
    ) +
    labs(
        title = "Comparaison des proportions des tranches d'age des UL en fonction de leur switch"
    )
ggsave("Comparaison des proportions des tranches d'ages des UL en fonction de leur switch.png", path = "graph/2.Analyse avec réalité éco")
