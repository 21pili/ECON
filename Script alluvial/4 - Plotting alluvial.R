##################################################
#                  Chaire ETIlab                 #
# author : Pierre Pili                           #
# modified : 15/10/22                            #                                                                               # nolint
# email : pierre.pili@etu.minesparis.psl.eu      #
# phone : 06 78 16 28 99                         #
##################################################

# Libraries

library(tidyverse)
library(ggalluvial)

#Importations

#GE-ETI-PME avec seulement les PME qui interviennent dans un switch

alluvial <- readRDS("Intermediate/histoireETI-GE-PME.rds") %>%
  group_by(categorie2018,
           categorie2019,
           categorie2020,
           categorie2021,
           categorie2022) %>%
  summarize(
    freq = n()
  ) %>%
  arrange(-freq)

alluvial_1 <- alluvial %>%
  mutate(
    categorie2018 = as.factor(unlist(categorie2018)),
    categorie2019 = as.factor(unlist(categorie2019)),
    categorie2020 = as.factor(unlist(categorie2020)),
    categorie2021 = as.factor(unlist(categorie2021)),
    categorie2022 = as.factor(unlist(categorie2022)),
    categorie2018 = factor(categorie2018, levels = c("GE", "ETI", "PME", NA)),
    categorie2019 = factor(categorie2019, levels = c("GE", "ETI", "PME", NA)),
    categorie2020 = factor(categorie2020, levels = c("GE", "ETI", "PME", NA)),
    categorie2021 = factor(categorie2021, levels = c("GE", "ETI", "PME", NA)),
    categorie2022 = factor(categorie2022, levels = c("GE", "ETI", "PME", NA))
  )

ggplot(data = alluvial_1,
       aes(y = freq,
           axis1 = categorie2018,
           axis2 = categorie2019,
           axis3 = categorie2020,
           axis4 = categorie2021,
           axis5 = categorie2022)) +
  geom_alluvium(aes(fill = categorie2018)) +
  geom_stratum(width = 0.2, fill = "black", color = "white") +
  geom_label(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("2018",
                              "2019",
                              "2020",
                              "2021",
                              "2022")) +
  scale_fill_discrete(limits = c("GE", "ETI", "PME", NA)) +
  ggtitle("UL switchs") +
  labs(subtitle = "Only PME switching to ETI or GE are represented") + 
  theme_classic()

ggsave("graph/alluvial/alluvial_1.png")
  
# ETI-PME-GE mais uniquement avec des entreprises qui switch au moins une fois

alluvial_2 <- alluvial %>%
  mutate(
    categorie2018 = as.factor(unlist(categorie2018)),
    categorie2019 = as.factor(unlist(categorie2019)),
    categorie2020 = as.factor(unlist(categorie2020)),
    categorie2021 = as.factor(unlist(categorie2021)),
    categorie2022 = as.factor(unlist(categorie2022)),
    categorie2018 = factor(categorie2018, levels = c("GE", "ETI", "PME", NA)),
    categorie2019 = factor(categorie2019, levels = c("GE", "ETI", "PME", NA)),
    categorie2020 = factor(categorie2020, levels = c("GE", "ETI", "PME", NA)),
    categorie2021 = factor(categorie2021, levels = c("GE", "ETI", "PME", NA)),
    categorie2022 = factor(categorie2022, levels = c("GE", "ETI", "PME", NA))
  ) %>% 
  arrange(-freq) %>%
  filter(!(categorie2018 == categorie2019 & 
           categorie2019 == categorie2020 &
           categorie2020 == categorie2021 & 
           categorie2021 == categorie2022))

ggplot(data = alluvial_2,
       aes(y = freq,
           axis1 = categorie2018,
           axis2 = categorie2019,
           axis3 = categorie2020,
           axis4 = categorie2021,
           axis5 = categorie2022)) +
  geom_alluvium(aes(fill = categorie2018)) +
  geom_stratum(width =  0.2, fill = "black", color = "white") +
  geom_label(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("2018",
                              "2019",
                              "2020",
                              "2021",
                              "2022")) +
  scale_fill_discrete(limits = c("GE", "ETI", "PME")) +
  ggtitle("UL with at least one change") +
  labs(subtitle = "Only PME switching to ETI or GE are represented") +
  theme_classic()

ggsave("graph/alluvial/alluvial_2.png")

# Plus aucun NA

alluvial_3 <- alluvial %>%
  mutate(
    categorie2018 = as.factor(unlist(categorie2018)),
    categorie2019 = as.factor(unlist(categorie2019)),
    categorie2020 = as.factor(unlist(categorie2020)),
    categorie2021 = as.factor(unlist(categorie2021)),
    categorie2022 = as.factor(unlist(categorie2022)),
    categorie2018 = factor(categorie2018, levels = c("GE", "ETI", "PME", NA)),
    categorie2019 = factor(categorie2019, levels = c("GE", "ETI", "PME", NA)),
    categorie2020 = factor(categorie2020, levels = c("GE", "ETI", "PME", NA)),
    categorie2021 = factor(categorie2021, levels = c("GE", "ETI", "PME", NA)),
    categorie2022 = factor(categorie2022, levels = c("GE", "ETI", "PME", NA))
  ) %>% 
  arrange(-freq) %>%
  filter(!(is.na(categorie2018) |
           is.na(categorie2019) |
           is.na(categorie2020) |
           is.na(categorie2021) |
           is.na(categorie2022))) %>%
  filter(!(categorie2018 == categorie2019 & 
             categorie2019 == categorie2020 &
             categorie2020 == categorie2021 & 
             categorie2021 == categorie2022))

ggplot(data = alluvial_3,
       aes(y = freq,
           axis1 = categorie2018,
           axis2 = categorie2019,
           axis3 = categorie2020,
           axis4 = categorie2021,
           axis5 = categorie2022)) +
  geom_alluvium(aes(fill = categorie2018)) +
  geom_stratum(width =  0.2, fill = "black", color = "white") +
  geom_label(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("2018",
                              "2019",
                              "2020",
                              "2021",
                              "2022")) +
  scale_fill_discrete(limits = c("GE", "ETI", "PME")) +
  ggtitle("UL with at least one change") +
  labs(subtitle = "Only PME switching to ETI or GE are represented, any firm switching to NA removed") +
  theme_classic()

ggsave("graph/alluvial/alluvial_3.png")

