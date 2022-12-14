##################################################
#                  Chaire ETIlab                 #
# author : Pierre Pili                           #
# modified : 5/10/22                             #                                                                               # nolint
# email : pierre.pili@etu.minesparis.psl.eu      #
# phone : 06 78 16 28 99                         #
##################################################

# Libraries

#install.packages("ggalluvial", repos = "http://cran.us.r-project.org") #nolint

library(tidyverse)
library(ggalluvial)
library(stringr)

# Importations

data <- readRDS("base_app.rds")
data$categoriejuridiqueunitelegale <- as.character(data$categoriejuridiqueunitelegale) #nolint
data$resultat <- as.integer(data$resultat)
data$ca <- as.integer(data$ca)
data$row <- seq(from = 1, to = 312948)

data_cat <- data %>% count(categoriejuridiqueunitelegale) %>% arrange(-n) %>% head(10) #nolint

############# Analyse simpliste ################

ggplot(data = data) +
    geom_bar(mapping = aes(x = annee_base))

ggplot(data = data %>% count(categoriejuridiqueunitelegale) %>% arrange(-n) %>% head()) + #nolint
    geom_bar(mapping = aes(x = categoriejuridiqueunitelegale, y = n), stat = "identity") + #nolint
    coord_flip()

ggplot(data = data_cat) +
    geom_col(mapping = aes(x = categoriejuridiqueunitelegale, y = n)) #nolint


ggplot(data = data) +
    geom_bar(mapping = aes(x = categoriejuridiqueunitelegale)) +
    scale_x_discrete("categorie juridique", limits = c("5710", "5720", "5499", "5498", "5699")) #nolint
    coord_flip()

ggplot(data = data) +
    geom_bar(mapping = aes(x = activiteprincipaleunitelegale)) +
    coord_flip()

ggplot(data = data) +
    geom_bar(mapping = aes(x = economiesocialesolidaireunitelegale))

ggplot(data = data) +
    geom_bar(mapping = aes(x = activiteprincipaleetablissement))

data_resultat <- data %>%
    filter(!is.na(resultat) &
        resultat > -10000000 &
        resultat < 10000000)

data_ca <- data %>%
    filter(!is.na(ca) &
        ca < 100000000)

ggplot(data = data_ca) +
    geom_histogram(aes(x = ca))

# Regardons les diff??rents entrant au niveau des ETI

data_distinct <- data %>%
    distinct(
        siren, .keep_all = "T"
    )

data_distinct$annee_base <- as.character(data_distinct$annee_base) 

data_rev <- arrange(data,desc(row)) #nolint

data_distinct_rev <- data_rev %>%
    distinct(
        siren, .keep_all = "T"
    )


data_distinct_rev$annee_base <- as.character(data_distinct_rev$annee_base) 


# Nombre d'entrants dans les ETI. D'o?? viennent-elles? GE? PME?

ggplot(data = data_distinct) +
    geom_bar(mapping = aes(x = annee_base)) + #nolint
    scale_x_discrete("annee_entree", limits = c("2018","2019", "2020", "2021", "2022")) #nolint

ggplot(data = data_distinct_rev) +
    geom_bar(mapping = aes(x = annee_base)) + #nolint
    scale_x_discrete("annee_entree", limits = c("2018","2019", "2020", "2021","2022")) #nolint

###### Regardons l'age moyen des ETIs 

data_age <- data %>%
    filter(annee_base  == "2018" &
        datecreationunitelegale > "1900-01-01")

data_age$annee_creation <- as.integer(str_sub(data_age$datecreationunitelegale, start = 0, end = 4)) #nolint

ggplot(data = data_age %>% filter(annee_creation > 1950)) +
    geom_bar(mapping = aes(x = annee_creation)) +
    coord_flip()

# On remarque que l'immense majorit?? des ETI ont ??t?? cr??es entre 1960 et avant 2018 #nolint

# Maintenant, jetons un oeil ?? l'age moyen des entrants par annee

data_distinct <- data %>%
    distinct(
        siren, .keep_all = "T"
    )

data_distinct$annee_creation <- as.integer(str_sub(data_distinct$datecreationunitelegale, start = 0, end = 4)) #nolint

data_distinct$annee_base <- as.character(data_distinct$annee_base)

age_moyen_entrants <- data_distinct %>%
    group_by(annee_base) %>%
    summarize(2022 - mean(annee_creation))

# Jetons un oeil ?? l'age des sortants

data_rev <- arrange(data,desc(row)) #nolint

data_distinct_rev <- data_rev %>%
    distinct(
        siren, .keep_all = "T"
    )

data_distinct_rev$annee_creation <- as.integer(str_sub(data_distinct_rev$datecreationunitelegale, start = 0, end = 4)) #nolint

data_distinct_rev$annee_base <- as.character(data_distinct_rev$annee_base)

age_moyen_sortants <- data_distinct_rev %>%
    group_by(annee_base) %>%
    summarize(2022 - mean(annee_creation)) %>%
    ungroup()

ggplot(data = age_moyen_sortants) +
    geom_col(mapping = aes(x = annee_base, y = `2022 - mean(annee_creation)`)) #nolint


ggplot(data = age_moyen_entrants) +
    geom_point(mapping = aes(x = annee_base, y = `2022 - mean(annee_creation)`))

# On va regarder plus en d??tail la distribution des entrants de chaque boite par annee #nolint

ggplot(data = data_distinct %>% filter(annee_base == 2019 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des neo-ETIs en 2019",
       x = "age des entreprises",
       y = "count")

ggplot(data = data_distinct %>% filter(annee_base == 2020 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des neo-ETIs en 2020",
       x = "age des entreprises",
       y = "count")

ggplot(data = data_distinct %>% filter(annee_base == 2021 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des neo-ETIs en 2021",
       x = "age des entreprises",
       y = "count")

ggplot(data = data_distinct %>% filter(annee_base == 2022 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des neo-ETIs en 2022",
       x = "age des entreprises",
       y = "count")

# On va regarder plus en d??tail la distribution des sortants de chaque boite par annee #nolint

ggplot(data = data_distinct_rev %>% filter(annee_base == 2018 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des ETI sortantes en 2018",
       x = "age des entreprises",
       y = "count")

ggplot(data = data_distinct_rev %>% filter(annee_base == 2019 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des ETI sortantes en 2019",
       x = "age des entreprises",
       y = "count")

ggplot(data = data_distinct_rev %>% filter(annee_base == 2020 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des ETI sortantes en en 2020",
       x = "age des entreprises",
       y = "count")

ggplot(data = data_distinct_rev %>% filter(annee_base == 2021 & datecreationunitelegale > "1901-01-01")) + #nolint
    geom_bar(mapping = aes(x = 2022 - annee_creation)) +
    labs(title = "Age des ETI sortantes en en 2021",
       x = "age des entreprises",
       y = "count")

#### Essayons d'extraire la distribution du nombre d'employ??s

ggplot(data = data %>% distinct(siren, .keep_all = "T")) +
    geom_bar(mapping = aes(x = libtrancheeffectifsunitelegale)) + #nolint
    scale_x_discrete("effectifunitelegale", limits = c( "Unit??s non employeuses", #nolint
                                                        "1 ou 2 salari??s",
                                                        "3 ?? 5 salari??s",
                                                        "6 ?? 9 salari??s",
                                                        "10 ?? 19 salari??s",
                                                        "20 ?? 49 salari??s",
                                                        "50 ?? 99 salari??s",
                                                        "100 ?? 199 salari??s",
                                                        "200 ?? 249 salari??s",
                                                        "250 ?? 499 salari??s",
                                                        "500 ?? 999 salari??s",
                                                        "1 000 ?? 1 999 salari??s", #nolint
                                                        "2 000 ?? 4 999 salari??s", #nolint
                                                        "5 000 ?? 9 999 salari??s")) + #nolint
    coord_flip()


#### On va regarder la r??partition de chaque effectif dans la r??partition par CA

ggplot(data = data_ca %>%
        distinct(siren, .keep_all = "T") %>%
        filter(ca < 20000000)) +
    geom_histogram(mapping = aes(x = ca, fill = libtrancheeffectifsunitelegale), bins = 10) + #nolint
    scale_fill_discrete("effectifunitelegale", limits = c( "Unit??s non employeuses", #nolint
                                                        "1 ou 2 salari??s",
                                                        "3 ?? 5 salari??s",
                                                        "6 ?? 9 salari??s",
                                                        "10 ?? 19 salari??s",
                                                        "20 ?? 49 salari??s",
                                                        "50 ?? 99 salari??s",
                                                        "100 ?? 199 salari??s",
                                                        "200 ?? 249 salari??s",
                                                        "250 ?? 499 salari??s",
                                                        "500 ?? 999 salari??s",
                                                        "1 000 ?? 1 999 salari??s", #nolint
                                                        "2 000 ?? 4 999 salari??s", #nolint
                                                        "5 000 ?? 9 999 salari??s")) #nolint

ggplot(data = data_ca %>%
        distinct(siren, .keep_all = "T") %>%
        filter(ca > 20000000)) +
    geom_histogram(mapping = aes(x = ca, fill = libtrancheeffectifsunitelegale), bins = 9) + #nolint
    scale_fill_discrete("effectifunitelegale", limits = c( "Unit??s non employeuses", #nolint
                                                        "1 ou 2 salari??s",
                                                        "3 ?? 5 salari??s",
                                                        "6 ?? 9 salari??s",
                                                        "10 ?? 19 salari??s",
                                                        "20 ?? 49 salari??s",
                                                        "50 ?? 99 salari??s",
                                                        "100 ?? 199 salari??s",
                                                        "200 ?? 249 salari??s",
                                                        "250 ?? 499 salari??s",
                                                        "500 ?? 999 salari??s",
                                                        "1 000 ?? 1 999 salari??s", #nolint
                                                        "2 000 ?? 4 999 salari??s", #nolint
                                                        "5 000 ?? 9 999 salari??s")) #nolint


ggplot(data = data_ca %>% distinct(siren, .keep_all = "T") %>% filter(activiteprincipaleunitelegale == "70.10Z")) + #nolint
    geom_histogram(mapping = aes(x = ca, fill = libtrancheeffectifsunitelegale), bins = 10) + #nolint
    scale_fill_discrete("effectifunitelegale", limits = c( "Unit??s non employeuses", #nolint
                                                        "1 ou 2 salari??s",
                                                        "3 ?? 5 salari??s",
                                                        "6 ?? 9 salari??s",
                                                        "10 ?? 19 salari??s",
                                                        "20 ?? 49 salari??s",
                                                        "50 ?? 99 salari??s",
                                                        "100 ?? 199 salari??s",
                                                        "200 ?? 249 salari??s",
                                                        "250 ?? 499 salari??s",
                                                        "500 ?? 999 salari??s",
                                                        "1 000 ?? 1 999 salari??s", #nolint
                                                        "2 000 ?? 4 999 salari??s", #nolint
                                                        "5 000 ?? 9 999 salari??s")) #nolint




data <- readRDS("alluvial.rds") %>%
    mutate(
        categorie2018 = as.factor(unlist(categorie2018)),
        categorie2019 = as.factor(unlist(categorie2019)),
        categorie2020 = as.factor(unlist(categorie2020)),
        categorie2021 = as.factor(unlist(categorie2021)),
        categorie2022 = as.factor(unlist(categorie2022))
    )

ggplot(data = data,
    aes(y = freq,
        axis1 = categorie2018,
        axis2 = categorie2019,
        axis3 = categorie2020,
        axis4 = categorie2021,
        axis5 = categorie2022)) +
    geom_alluvium(aes(fill = categorie2022)) +
    scale_x_discrete(limits = c("2018",
                                "2019",
                                "2020",
                                "2021",
                                "2022")) +
    scale_fill_discrete(limits = c("GE", "ETI")) +
    geom_stratum(width = 0.1)

######## Tra??on des alluvial dans tous les sens :)

data <- data[-c(1), ]

