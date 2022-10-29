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

seeds_1 <- readRDS("Intermediate/histoireETI-GE-PME.rds") %>%
    filter(
        categorie2021 == "ETI",
        categorie2022 == "GE"
    ) %>%
    select(siren) %>%
    distinct(siren)

saveRDS(seeds_1, "Intermediate/seeds_1.rds")

seeds_2 <- readRDS("Intermediate/histoireETI-GE-PME.rds") %>%
    select(siren) %>%
    distinct(siren)

saveRDS(seeds_2, "Intermediate/seeds_2.rds")

seeds_total <- list(
        readRDS("Input/eti_base_app.rds"),
        readRDS("Input/ge_base_app.rds")
    ) %>%
    bind_rows() %>%
    filter(str_detect(denominationunitelegale, regex("total", ignore_case = TRUE))) %>% #nolint
    select(siren) %>%
    distinct(siren)


saveRDS(seeds_total, "Intermediate/seeds_total.rds")
