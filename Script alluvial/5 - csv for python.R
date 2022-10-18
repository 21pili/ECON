##################################################
#                  Chaire ETIlab                 #
# author : Pierre Pili                           #
# modified : 17/10/22                            #                                                                               # nolint
# email : pierre.pili@etu.minesparis.psl.eu      #
# phone : 06 78 16 28 99                         #
##################################################

#Libraries

library(tidyverse)

#Importations

eti <- readRDS("Input/eti_base_app.rds") %>%
  mutate(
    categorieentreprise = "ETI"
  )

ge <- readRDS("Input/ge_base_app.rds") %>%
  mutate(
    categorieentreprise = "GE"
  )

histoire <- readRDS("Intermediate/histoireETI-GE.rds")

data <- list(eti, ge) %>%
  bind_rows() %>%
  left_join(histoire %>%
    select(
      siren,
      categorie2018,
      categorie2019,
      categorie2020,
      categorie2021,
      categorie2022,
    ), 
    by = c("siren"))

write_csv(data, "Output/histoire.csv")
