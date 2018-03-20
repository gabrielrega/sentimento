library(tidyverse)
library(tidytext)
library(lexiconPT)

pontuar_texto <- function(x) {
  p <- x %>%
    as_tibble() %>% 
    unnest_tokens(term, value) %>% 
    inner_join(oplexicon_v3.0) %>% 
    .$polarity %>% 
    sum()
  return(p)
}

pts <- atas %>% 
  mutate(pontos = map(texto, pontuar_texto)) %>% 
  unnest(pontos)
  
# Criando um gráfico ----------------------------------------------------------

library(ggplot2)

p <- ggplot(data = pts, aes(x = data, y = pontos)) +
              geom_line()
p
