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
library(doParallel)
library(lubridate)
library(parallel)

# Importation -------------------------------------------------------------

# data <- readRDS("Intermediate/scraps/infogre1-10000.rds") %>%
#   mutate(
#     id = 1:9618
#   )


temp = list.files("Intermediate/scraps", pattern=".rds") %>%
  as.data.frame() %>%
  setNames(c('x')) %>%
  mutate(
    x=paste0("Intermediate/scraps/",x)
  ) %>%
  pull(x)

data = lapply(temp, readRDS) %>%
  bind_rows()

# detectCores()
# 
# cl <- makeCluster(2)
# 
# registerDoParallel(cl)

final <- tibble()

#final <- foreach(j=1:1000, .combine = rbind ,.packages = c('tidyverse', 'foreach', 'lubridate')) %dopar% {

foreach(j=1:nrow(data)) %do% {
  
  tryCatch({
  
  print(j)

    t2 <- data[j,] %>%
      filter(
        str_detect(
          Temp,
          "chiffres clés"
        )
      ) %>%
      mutate(
        temp2 = gsub(".*chiffres clés", '', Temp)
      ) %>% 
      select(
        -Temp
      ) %>% 
      mutate(
        temp2 = gsub(' ', '', temp2),
        temp2 = gsub('\n\n€', '', temp2),
        temp2 = gsub('\n\nK€', 'K', temp2),
        temp2 = gsub('\nComptesannuelsnondéposés', '', temp2),
        temp2 = gsub('\nNonrévélable', '', temp2),
        temp2 = gsub('\nComptesannuelsdéposésauGreffe.Commandepossible.', '', temp2),
        temp2 = gsub('\nComptesdéposésavecdéclarationdeconfidentialité', '', temp2)
        
      )

foreach(i=1:80)%do%{

 # print(i)

  t2 <- t2 %>%
    mutate(
      temp2 = sub('\n', paste0("id-",i), temp2)
    )
}

c1 <- str_match(t2$temp2, "id-2\\s*(.*?)\\s*id-3")[,2]
c2 <- str_match(t2$temp2, "id-3\\s*(.*?)\\s*id-4")[,2]
c3 <- str_match(t2$temp2, "id-4\\s*(.*?)\\s*id-5")[,2]
c4 <- str_match(t2$temp2, "id-5\\s*(.*?)\\s*id-6")[,2]

date1 <- str_match(t2$temp2, "id-6\\s*(.*?)\\s*id-7")[,2]
date2 <- str_match(t2$temp2, "id-16\\s*(.*?)\\s*id-17")[,2]
date3 <- str_match(t2$temp2, "id-26\\s*(.*?)\\s*id-27")[,2]
date4 <- str_match(t2$temp2, "id-36\\s*(.*?)\\s*id-37")[,2]

ca1 <- str_match(t2$temp2, "id-8\\s*(.*?)\\s*id-9")[,2]
ca2 <- str_match(t2$temp2, "id-18\\s*(.*?)\\s*id-19")[,2]
ca3 <- str_match(t2$temp2, "id-28\\s*(.*?)\\s*id-29")[,2]
ca4 <- str_match(t2$temp2, "id-38\\s*(.*?)\\s*id-39")[,2]

res1 <- str_match(t2$temp2, "id-12\\s*(.*?)\\s*id-13")[,2]
res2 <- str_match(t2$temp2, "id-22\\s*(.*?)\\s*id-23")[,2]
res3 <- str_match(t2$temp2, "id-32\\s*(.*?)\\s*id-33")[,2]
res4 <- str_match(t2$temp2, "id-42\\s*(.*?)\\s*id-43")[,2]
 
eff1 <- str_match(t2$temp2, "id-15\\s*(.*?)\\s*id-16")[,2] 
eff2 <- str_match(t2$temp2, "id-25\\s*(.*?)\\s*id-26")[,2]
eff3 <- str_match(t2$temp2, "id-35\\s*(.*?)\\s*id-36")[,2]
eff4 <- str_match(t2$temp2, "id-45\\s*(.*?)\\s*id-46")[,2]

data0 <- tibble(
  cloture = c(date1, date2, date3,date4),
  ca = c(ca1,ca2,ca3,ca4),
  resultat = c(res1,res2,res3,res4),
  effectif = c(eff1, eff2, eff3, eff4)
) %>%
  mutate(
    liste = t2$liste[1],
    cloture = as.Date(cloture,  format = "%d/%m/%Y"),
    annee = year(cloture)
  )

final <- final %>%
  bind_rows(
    data0
  )

rm(list = c('data0', 't2', 'ca1','ca2','ca3','ca4','date1','date2',
            'date3','date4','eff1','eff2','eff3','eff4','res1','res2',
            'res3','res4'))

  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
  #return(final)

}

 saveRDS(final, "Intermediate/scraps/final.rds")
