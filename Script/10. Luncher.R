####################################
#            Chaire ETI            #
# File name:  ETI theme            #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 04/07/22           #
# Purpose:                         #
# Date last modified: 04/07/22    #
####################################

library(tidyverse)
library(doParallel)


# scraping ----------------------------------------------

all_siren <- readRDS("Intermediate/all_siren.rds")

n <- all_siren %>%
  distinct(siren) %>%
  nrow()


# Matrice de scrap---------------------------------------------------------


liste2 <- tibble(
  j = seq(1, 14145000, by = 1000),
  k = seq(1000, 14145000, by = 1000)
) %>%
  mutate(
    k = ifelse(k==14144000, n, k)
  ) %>%
  mutate(
    l = 4000:18144
  )


foreach(q=1) %do% {
  
  tryCatch({ 
    
    print(q)
    
    l <- liste2$l[q]
    
    k <- liste2$k[q]
    
    j <- liste2$j[q]
    
   source('Script/9. Scraping.R')
    
    }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
}
