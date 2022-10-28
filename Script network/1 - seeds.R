###################################################
#                  Chaire ETIlab                  #
# author : Alexandre Gavaudan                     #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################


# Libraries

library(tidyverse)

# Importations

seeds <- readRDS("Intermediate/histoireETI-GE-PME.rds") %>%
    filter(
        categorie2021 == "ETI",
        categorie2022 == "GE"
    ) %>%
    select(siren) %>%
    distinct(siren)

saveRDS(seeds, "Intermediate/seeds.rds")
