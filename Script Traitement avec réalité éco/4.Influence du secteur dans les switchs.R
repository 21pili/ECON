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

ggplot(data %>% filter(switch == "sortant"), mapping = aes(y = secteur)) +
    geom_bar() +
    labs(
        title = paste("secteur des UL ETI devenant GE"),
        y = "secteur d'activité"
    )

ggsave("secteur des UL ETI devenant GE.png", path = "graph/2.Analyse avec réalité éco")


ggplot(data %>%
    filter(switch == "entrant"), mapping = aes(y = secteur)) +
    geom_bar() +
    labs(
        title = paste("secteur des UL GE devenant ETI"),
        y = "secteur d'activité"
    )

ggsave("secteur des UL GE devenant ETI.png", path = "graph/2.Analyse avec réalité éco")

## Regardons maintenant les proportions des secteurs dans la base ETI/GE groupé par siren #nolint

ggplot(data, mapping = aes(y = secteur)) +
    geom_bar() +
    labs(
        title = "Proportions des secteurs d'activités pour ETI/GE",
        y = "secteur d'activité"
    )

ggsave("Proportions des secteurs d'activités pour ETI-GE.png", path = "graph/2.Analyse avec réalité éco")

ggplot(data = data) +
    geom_bar(
        mapping = aes(x = switch, fill = secteur),
        position = "fill"
    ) +
    labs(
        title = "Comparaison des proportions des secteurs des UL en fonction de leur switch"
    )

ggsave("Comparaison des proportions des secteurs des UL en fonction de leur switch.png", path = "graph/2.Analyse avec réalité éco")

