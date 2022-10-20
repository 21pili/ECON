###################################################
#                  Chaire ETIlab                  #
# author : Alexandre Gavaudan                     #
# modified :                                      #
# email : alexandre.gavaudan@etu.minesparis.psl.eu#
# phone : 06 34 27 50 46                          #
###################################################

# Library

library(tidyverse)

# Importation

base_eti <- readRDS("Input/eti_base_app.rds")
base_ge <- readRDS("Input/ge_base_app.rds")

# Traitement

give_sec <- function(naf){
  ifelse(as.integer(str_sub(naf, 1, 2)) %in% 41:43, "Construction", ifelse( #nolint
    as.integer(str_sub(naf, 1, 2)) %in% 45:47, "Commerce", ifelse(
      as.integer(str_sub(naf, 1, 2)) %in% 5:39, "industrie", ifelse(
        as.integer(str_sub(naf, 1, 2)) %in% 49:53, "Transport", ifelse(
          (as.integer(str_sub(naf, 1, 2)) %in% c(55:63, 69:82, 90:93, 95:96)), "Services marchands", NA) #nolint
        )
      )
    )
  )
}

base_eti <- base_eti %>%
  mutate(secteur = give_sec(activiteprincipaleunitelegale)) %>%
  filter(!is.na(secteur))

base_ge <- base_ge %>%
  mutate(secteur = give_sec(activiteprincipaleunitelegale)) %>%
  filter(!is.na(secteur))

saveRDS(base_eti, "Intermediate/eti_acti_insee.rds")
saveRDS(base_ge, "Intermediate/ge_acti_insee.rds")