##################################################@
#                  Chaire ETIlab                  #
# author : Alexandre Gavaudan                     #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################

# Libraries

library(tidyverse)

# Importation

data_ge <- readRDS("Intermediate/ge_acti_insee.rds") %>%
    mutate(
        ca = as.integer(ca),
        resultat = as.integer(resultat),
        categoriejuridiqueunitelegale = as.character(categoriejuridiqueunitelegale), # nolint
        effectif = as.integer(effectif)
    )

data_eti <- readRDS("Intermediate/eti_acti_insee.rds") %>%
    mutate(
        ca = as.integer(ca),
        resultat = as.integer(resultat),
        categoriejuridiqueunitelegale = as.character(categoriejuridiqueunitelegale), # nolint
        effectif = as.integer(effectif)
    )


# Traitement

# Commencons par les GE

data_for_lm_ge <- data_ge %>%
    filter(effectif < 10000, effectif != 0)

summary_fit_ge <- summary(lm(effectif ~ ca, data = data_for_lm_ge))

ggplot(data_for_lm_ge, mapping = aes(x = effectif, y = ca, color = secteur)) +
    geom_point(size = 0.5, alpha = 0.5) + # nolint
    geom_smooth(method = "lm", se = FALSE) +
    labs(
        title = "CA en fonction de l'effectif pour les GE",
        x = "Effectif",
        y = "CA"
    )

ggsave("CA en fonction de l'effectif pour les GE.png", path = "graph/2.Analyse avec réalité éco/") #nolint

# Continuons avec les ETI

data_for_lm_eti <- data_eti %>%
    filter(effectif > 5 & effectif < 5000)

summary_fit_eti <- summary(lm(effectif ~ ca, data = data_for_lm_eti))

ggplot(data_for_lm_eti, mapping = aes(x = effectif, y = ca, color = secteur)) +
    geom_point(size = 0.5, alpha = 0.5) + # nolint
    geom_smooth(method = "lm", se = FALSE) +
    labs(
        title = "CA en fonction de l'effectif pour les ETI"
    )
ggsave("CA en fonction de l'effectif pour les ETI.png", path = "graph/2.Analyse avec réalité éco/") # nolint
