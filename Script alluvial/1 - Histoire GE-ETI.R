##################################################
#                  Chaire ETIlab                 #
# author : Pierre Pili                           #
# modified : 16/10/22                            #                                                                               # nolint
# email : pierre.pili@etu.minesparis.psl.eu      #
# phone : 06 78 16 28 99                         #
##################################################

# libraries

library(tidyverse)
library(stringr)
library(doParallel)

# Définition d'une fonction

fill <- function(categories, annees){
  cat <- unlist(strsplit(categories, ", "))
  ann <- unlist(strsplit(annees, ", "))
  res <- c(NA, NA, NA, NA, NA)
  i <- 1
  for(annee in ann){
    res[as.integer(annee)-2017] = cat[i]
    i <- i + 1
  }
  return(res)
}

traitement <- function(df){
  foreach (i = 0:nrow(df)) %do%{
    print(i)
    res = fill(df$histoire[i],df$annees[i])
    df$categorie2018[i] <- res[1]
    df$categorie2019[i] <- res[2]
    df$categorie2020[i] <- res[3]
    df$categorie2021[i] <- res[4]
    df$categorie2022[i] <- res[5]
  }
  return(df)
}

# Importations

eti <- readRDS("Input/eti_base_app.rds") %>%
  mutate(
    categorieentreprise = "ETI"
  )


ge <- readRDS("Input/ge_base_app.rds") %>%
  mutate(
    categorieentreprise = "GE"
  )

# Traitement de la base de donnée


data <- list(eti, ge) %>%
  bind_rows() %>%
  group_by(siren) %>%
  summarize(
    histoire = paste(categorieentreprise, collapse = ", "),
    annees = paste(annee_base, collapse = ", ")
  ) %>%
  ungroup() %>%
  mutate(
    categorie2018 = NA,
    categorie2019 = NA,
    categorie2020 = NA,
    categorie2021 = NA,
    categorie2022 = NA
  )

data <- traitement(data)

saveRDS(data, "Intermediate/histoireETI-GE.rds")