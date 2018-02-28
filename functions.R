pontuar_html <- function(x) {
  
  z <- read_html(x) %>% 
    html_nodes("div.lista1") %>% 
    html_text() %>% 
    str_split("\r\r\n") %>% 
    unlist() %>% 
    as_tibble() %>% 
    unnest_tokens(term, value) %>% 
    inner_join(oplexicon_v3.0) %>% 
    .$polarity %>% 
    sum()
  
  return(z)
}

pontuar_pdf <- function(x) {
  x <- pdf_text(x)
  baz <- gsub("\n", "", x)
  baz <- gsub("\r", " ", baz)
  tex <- baz %>% 
    as_tibble() %>% 
    unnest_tokens(term, value) %>% 
    inner_join(oplexicon_v3.0) %>% 
    .$polarity %>% 
    sum()
  return(tex)
}

extrair_pdf <- function(x) {
  b <- pdf_text(x) %>% 
    str_split("\r\n") %>% 
    unlist() 
  return(b)
}

extrair_html <- function(x) {
  
  t <- read_html(x) %>% 
    html_nodes("div.lista1") %>% 
    html_text() %>% 
    str_split("\r\r\n") %>% 
    unlist() %>% 
    paste(collapse = " ")
  return(t)
  
}

datar_html <- function(x) {
  z <- read_html(x) %>% 
    html_nodes("meta") %>% 
    html_attr("content") %>%
    .[5]
  
  return(z)
}

datar_pdf <- function(x) {
  z <- pdf_info(x) %>% 
    .$modified %>% 
    str_sub(1, 10)
  return(z)
}

pontuar_lista <- function(x) {
  p <- x %>%
    inner_join(oplexicon_v3.0) %>% 
    .$polarity %>% 
    sum()
  return(p)
}

pontuar_texto <- function(x) {
  p <- x %>%
    as_tibble() %>% 
    unnest_tokens(term, value) %>% 
    inner_join(oplexicon_v3.0) %>% 
    .$polarity %>% 
    sum()
  return(p)
}

# Criando a base de dados -----------------------------------------------------

atas_html <- list.files("./atas/", "html") %>% 
  as_tibble() %>% 
  mutate(path = paste0("./atas/",value)) %>% 
  mutate(ata = str_sub(value, 6, -6)) %>% 
  mutate(ata = as.integer(ata)) %>% 
  mutate(data = map(path, datar_html)) %>% 
  mutate(data = dmy(data)) %>% 
  mutate(texto = map(path, extrair_html)) %>% 
  select(-path, -value)

atas_pdf <- list.files("./atas/", "pdf") %>% 
  as_tibble() %>% 
  mutate(path = paste0("./atas/",value)) %>% 
  mutate(ata = str_sub(path, -7, -5)) %>% 
  mutate(ata = as.integer(ata)) %>% 
  mutate(data = map(path, datar_pdf)) %>% 
  mutate(data = ymd(data)) %>% 
  mutate(texto = map(path, extrair_pdf)) %>% 
  select(-path, -value)

atas_html %>% full_join(atas_pdf)
