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

data_ge <- readRDS("Intermediate/ge_acti_insee.rds") %>%
    mutate(
        ca = as.integer(ca),
        resultat = as.integer(resultat),
        categoriejuridiqueunitelegale = as.character(categoriejuridiqueunitelegale), # nolint
        effectif = as.integer(effectif),
        categorie_entreprise = "GE"
    )

data_eti <- readRDS("Intermediate/eti_acti_insee.rds") %>%
    mutate(
        ca = as.integer(ca),
        resultat = as.integer(resultat),
        categoriejuridiqueunitelegale = as.character(categoriejuridiqueunitelegale), # nolint
        effectif = as.integer(effectif),
        categorie_entreprise = "ETI"
    )


# Traitement

data <- bind_rows(data_eti, data_ge) %>%
    group_by(siren) %>%
    summarise(
        annee_base = paste((annee_base), collapse = ", "),
        categorie = paste((categorie_entreprise), collapse = ", "),
        secteur = secteur,
        datecreationunitelegale = datecreationunitelegale,
        naf = activiteprincipaleunitelegale,
        long = longitude,
        lat = latitude
    ) %>%
    mutate(
        switch = ifelse(
            (str_detect(categorie, "ETI, GE") &
                as.numeric(str_sub(annee_base, 1, 4)) < as.numeric(str_sub(annee_base, -4, -1))), "sortant", # nolint
            ifelse((str_detect(categorie, "ETI, GE") &
                as.numeric(str_sub(annee_base, 1, 4)) > as.numeric(str_sub(annee_base, -4, -1))), "entrant", "Pas de switch") # nolint
        ), age = ifelse(as.numeric(str_sub(datecreationunitelegale, 1, 4)) > 2012, "Moins de 10", # nolint
            ifelse(as.numeric(str_sub(datecreationunitelegale, 1, 4)) > 2002, "Entre 10 et 20", # nolint
                ifelse(as.numeric(str_sub(datecreationunitelegale, 1, 4)) > 1992, "Entre 20 et 30", # nolint
                    ifelse(as.numeric(str_sub(datecreationunitelegale, 1, 4)) > 1972, "Entre 30 et 50", # nolint
                        ifelse(as.numeric(str_sub(datecreationunitelegale, 1, 4)) > 1952, "Entre 50 et 70", "Non référencé" # nolint
                        )
                    )
                )
            )
        )
    )

saveRDS(data, "Intermediate/ge_eti_insee_historisée.rds")
