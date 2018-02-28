library(dplyr)
library(lubridate)

atas <- read.table("atas.txt", header = TRUE) %>%
  as_tibble() %>% 
  mutate(data = ymd(data)) %>% 
  mutate(texto = as.character(texto))
