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
library(rvest)
library(doParallel)
library(RSelenium)
library(janitor)
# library(emayili)


# Paramètre du mail -------------------------------------------------------

# options(envelope.details = TRUE)
# options(envelope.invisible = FALSE)
# 
# email <- envelope(
#   to = c("prevet.antoine@gmail.com"),
#   from = "eti.lab.data@gmail.com",
#   subject = paste0("Scraping", l),
#   text = "Calcul terminé"
# )
# 
# smtp <- server(
#   host = "smtp.gmail.com",
#   port = 465,
#   username = "eti.lab.data@gmail.com",
#   password = "fbdqvamemohbqsok"
# )

# binman::rm_platform("phantomjs")
# wdman::selenium(retcommand = TRUE)



# Les paramètres du scraping ----------------------------------------------
# 
# l = 350
# 
# j = 40001
# 
# k = 50000

# Importations ------------------------

all_siren <- readRDS("Intermediate/all_siren.rds")

# scraping pour les eti_2019 ----------------------------------------------


liste <- all_siren %>%
  distinct(siren) %>%
  pull

# Scraping      -----------------------

# Conseil : 2 fois 5 sessions pour le scraping

data <- tibble()

rD <- rsDriver(browser="chrome", port=as.integer(l), verbose=F, chromever = "105.0.5195.127") # Changer de port à chaque run

remDr <- rD[["client"]]

remDr$navigate("https://www.infogreffe.fr/")

Sys.sleep(3) 

remDr$findElements(using = 'id', value = "refusercookies_label")[[1]]$clickElement()

Sys.sleep(2)

foreach(i=j:k) %do% {
  
  tryCatch({
    
    print(i)
    
    rm(data0)
    
    remDr$navigate("https://www.infogreffe.fr/")
    
    Sys.sleep(3) 
    
    
    remDr$findElement(using = "id", value = "champRechercheGlobale")$sendKeysToElement(list(liste[i]))
    
    Sys.sleep(1)
    
    remDr$findElements(using = 'id', value = "loupeRechercheGlobale")[[1]]$clickElement()
    
    Sys.sleep(3)
    
    
     html <- remDr$getPageSource()[[1]]
    
     data0 <- read_html(html) %>%
       html_nodes(xpath='//section/div/div[3]/div/div[1]/div[2]') %>%
       html_text() %>%
       as.data.frame() %>%
       setNames(c("Temp")) %>%
       mutate(
         liste = liste[i]
       )
     

  data <- data %>%
    bind_rows(
      data0
    )
  
}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
}

# Sauvegarde --------------------------

saveRDS(data, paste0("Intermediate/scraps/all_to_add", paste0(j, "-", k),'.rds'))

#smtp(email, verbose = TRUE)

