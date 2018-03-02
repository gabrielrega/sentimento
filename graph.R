# Pontuando em listas ---------------------------------------------------------

pts <- rec %>% 
  mutate(pontos = map(texto, pontuar_texto)) %>% 
  unnest(pontos) 
  
# Criando um gráfico ----------------------------------------------------------

library(ggplot2)

p <- ggplot(data = pts, aes(x = data, y = pontos)) +
              geom_line()
p
