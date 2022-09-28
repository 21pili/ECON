#############################################
#            Chaire ETI                     #
# File name: training.R                     #
# Author: Pierre Pili                       #
# Email: pierre.pili@etu.minesparis.psl.eu  #
# Date created: 28/09/22                    #
# Purpose:  Plotting                        #
# Date last modified: 14/07/22              #
#############################################


# Libraries ---------------------------

#install.packages("tidyverse")
#install.packages("data.table")

library(tidyverse)
library(data.table)


# Importations ------------------------

ge <- readRDS("Intermediate/ge_siren.rds")
