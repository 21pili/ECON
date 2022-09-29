####################################
#            Chaire ETI            #
# File name:  ETI theme            #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 09/05/22           #
# Purpose:                         #
# Date last modified: 09/05/22     #
####################################


# Libraries ---------------------------


library(tidyverse)
library(data.table)


# Importations ------------------------

# Libraries ---------------------------


library(tidyverse)


# Importations ------------------------


geo_cquest <- list(
  readRDS('Intermediate/cquest_2018.rds'),
  readRDS('Intermediate/cquest_2019.rds'),
  readRDS('Intermediate/cquest_2020.rds'),
  readRDS('Intermediate/cquest_2021.rds'),
  readRDS('Intermediate/cquest_2022.rds')
  # readRDS('Intermediate/sul_2017.rds'),
  # readRDS('Intermediate/sul_2016.rds')
)%>%
  bind_rows() %>% 
  filter(
    !is.na(longitude) &
    !is.na(latitude)
  ) %>%
  distinct(
    siret, .keep_all = T
  ) 

saveRDS(geo_cquest , 'Intermediate/geo_cquest.rds')

