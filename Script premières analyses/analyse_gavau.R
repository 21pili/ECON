##################################################
#                  Chaire ETIlab                 #
# author : Pierre Pili                           #
# modified : 5/10/22                             #
# email : pierre.pili@etu.minesparis.psl.eu      #
# phone : 06 78 16 28 99                         #
##################################################

# Libraries

library(tidyverse)
library(ggalluvial)
library(alluvial)
library(stringr)

# Importations

data_eti <- readRDS("base_app.rds")
data_eti$categorie_entreprise <- "ETI"
data_eti$categoriejuridiqueunitelegale <- as.character(data_eti$categoriejuridiqueunitelegale) #nolint
data_eti$resultat <- as.integer(data_eti$resultat)
data_eti$ca <- as.integer(data_eti$ca)

data_ge <- readRDS("ge_base_app.rds")
data_ge$categoriejuridiqueunitelegale <- as.character(data_ge$categoriejuridiqueunitelegale) #nolint
data_ge$ca <- NA
data_ge$resultat <- NA
data_ge$effectif <- NA
data_ge$categorie_entreprise <- "GE"

data <- bind_rows(data_eti, data_ge)

data_r <- data %>%
    group_by(siren) %>%
    summarise(
        annee_base = paste((annee_base), collapse = ", "),
        catego = paste((categorie_entreprise), collapse = ", ")
    ) # nolint

data_r$categorie2018 <- NA
data_r$categorie2019 <- NA
data_r$categorie2020 <- NA
data_r$categorie2021 <- NA
data_r$categorie2022 <- NA

### fonction auxiliaire ###

traitement <- function(annees, categos){      #nolint
    annees <- strsplit(annees, ", ")
    categos <- strsplit(categos, ", ")
    liste <- list(NA, NA, NA, NA, NA)
    foreach(i = 0 : 5) %do% {                 #nolint
        if(as.integer(annees[i] == i + 2018) %do% {
            liste[i] <- categos[i]
        }
    }
    return(liste)
}

traitement("2018, 2019, 2020, 2021","ETI, ETI, ETI, ETI")

ban <- function(df){NA}

#x est un vecteur contenant une série de valeurs
cv<-function(x){
moy<-mean(x) # moyenne de x
s<-sd(x)# ecart type de x
rslt<-s/moy # calcul du CV
rslt #la fonction retourne le résultat
}

ggplot(data = data,
       aes(y = Freq, axis1 = Gender, axis2 = Dept)) +
  geom_alluvium(aes(fill = Admit), width = 1/12) +
  geom_stratum(width = 1/12, fill = "black", color = "grey") +
  geom_label(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("Gender", "Dept"), expand = c(.05, .05)) +
  scale_fill_brewer(type = "qual", palette = "Set1") +
  ggtitle("UC Berkeley admissions and rejections, by sex and department")
