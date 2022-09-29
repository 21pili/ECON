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


# scraping pour les eti_2019 ----------------------------------------------


past <- readRDS("Intermediate/from_past/final_scrap.rds")

entrfiltr_siren <- readRDS("Intermediate/entrfiltr_siren.rds")

# scraping pour les eti_2019 ----------------------------------------------


n <- entrfiltr_siren %>%
  anti_join(past %>% select(siren=liste), by = "siren") %>%
  distinct(siren) %>%
  nrow()


# Matrice de scrap---------------------------------------------------------


liste2 <- tibble(
  j = seq(1,18000, by = 1000),
  k = seq(1000, 18000, by = 1000)
) %>%
  mutate(
    k = ifelse(k==18000, n, k)
  ) %>%
  mutate(
    l = 4000:4017
  )


foreach(q=9:18) %do% {
  
  tryCatch({ 
    
    print(q)
    
    l <- liste2$l[q]
    
    k <- liste2$k[q]
    
    j <- liste2$j[q]
    
   source('Script/9. Scraping.R')
    
    }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
}
