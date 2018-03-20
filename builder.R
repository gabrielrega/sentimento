# Criando a base de dados -----------------------------------------------------

library(tidyverse)
library(stringr)
library(pdftools)
library(rvest)

atas <- list.files("./atas/") %>% 
  as_tibble() %>% 
  mutate(path = paste0("./atas/",value)) %>% 
  mutate(ata = str_sub(value, 7, -5)) %>% 
  mutate(ata = as.integer(ata)) %>% 
  mutate(data = map(path, extrair_data)) %>% 
  mutate(data = ymd(data)) %>% 
  mutate(texto = map(path, extrair_txt)) %>% 
  arrange(data) %>% 
  select(-path, -value)

write.table(atas %>% unnest(), "atas.txt", sep = '\t', row.names = FALSE)

options(encoding = "utf8")
jsonlite::write_json(atas,"atas.json")
atas2 <- jsonlite::read_json("atas.json", flatten = TRUE, simplifyVector = TRUE) %>% as_tibble()
atas2
