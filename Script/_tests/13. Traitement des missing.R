####################################
#            Chaire ETI            #
# File name:  ETI theme            #
# Author: Antoine PREVET           #
# Email: prevet.antoine@gmail.com  #
# Date created: 25/05/22           #
# Purpose:  Scrap        #
# Date last modified: 25/05/22     #
####################################

# Librairies ------------------------

library(tidyverse)
library(rvest)
library(doParallel)
library(RSelenium)
library(janitor)

# Importations ------------------------

liste <- readRDS("Intermediate/missing.rds") %>%
  distinct(siret_siege) %>%
  pull

# Scraping      -----------------------


data <- tibble()

rD <- rsDriver(browser="chrome", port=79L, verbose=F, chromever = "103.0.5060.53")

remDr <- rD[["client"]]

remDr$navigate("https://www.societe.com/")

Sys.sleep(5) 


foreach(i=1:10) %do% {
  
  tryCatch({
  
  print(i)
  
  remDr$navigate("https://www.societe.com/")
  
  Sys.sleep(5) 
  
  remDr$findElement(using = "id", value = "input_search")$sendKeysToElement(list(liste[i]))
  
  Sys.sleep(1)
  
  remDr$findElements(using = 'id', value = "buttsearch")[[1]]$clickElement()
  
  Sys.sleep(9)
  
  
  html <- remDr$getPageSource()[[1]]
  
  
  tab1 <- read_html(html) %>%
    html_nodes(xpath='//div[4]/table[1]/tbody') %>%
    html_table() %>% 
    .[[1]] %>%
    as.data.frame() %>%
    select(
      Var = X1,
      Val = X2
    )
  
  tab2 <- read_html(html) %>%
    html_nodes(xpath='//div[4]/table[2]/tbody') %>%
    html_table() %>% 
    .[[1]] %>%
    as.data.frame() %>%
    select(
      Var = X1,
      Val = X2
    )
  
  fj <- read_html(html) %>%
    html_nodes(xpath='//tr[2]/td/div/div[2]/div[1]/div/div[3]') %>%
    html_text() %>%
    .[[1]]
  
  str_replace_all(fj, '\n', '')
  
  fj <- gsub("^\\s+|\\s+$", "", fj)
   
  cat <- read_html(html) %>%
    html_nodes(xpath='//tr[13]/td/div/div[2]/div[1]/div/div[3]') %>%
    html_text() %>%
    .[[1]]
   
  str_replace_all(cat, '\n', '')
  
  cat <- gsub("^\\s+|\\s+$", "", cat)
  
  eff <- read_html(html) %>%
    html_nodes(xpath='//tr[20]/td/div/div[2]/div/div[3]') %>%
    html_text() %>%
    .[[1]]
  
  str_replace_all(eff, '\n', '')
  
  eff <- gsub("^\\s+|\\s+$", "", eff)
  
  cs <- read_html(html) %>%
    html_nodes(xpath='//div[2]/div/div/span/span') %>%
    html_text() %>%
    .[[1]]

  
data0 <- tab1 %>% 
  bind_rows(
    tab2
  ) %>%
  bind_rows(
    tibble(
      Var = "Forme Juridique",
      Val = fj
    ),
    tibble(
      Var = "NAF",
      Val = cat
    ),
    tibble(
      Var = "Effectif",
      Val = eff
    ),
    tibble(
      Var = "Capital Social",
      Val = cs
    )
  ) %>%
  mutate(
    liste = liste[i]
  )

  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  data <- data %>%
    bind_rows(
      data0
    )
  
}


# Sauvegarde --------------------------

saveRDS(data, 'Intermediate/scraps/socite.com9001-end.rds')
 