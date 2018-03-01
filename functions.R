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
    unlist() %>% 
    paste(collapse = " ") %>% 
    str_squish()
  return(b)
}

extrair_html <- function(x) {
  
  t <- read_html(x) %>% 
    html_nodes("div.lista1") %>% 
    html_text() %>% 
    str_split("\r\r\n") %>% 
    unlist() %>% 
    paste(collapse = " ") %>% 
    str_squish()
  return(t)
  
}

extrair_html2 <- function(x) {
  
  t <- read_html(x) %>% 
    html_nodes("div.conteudo") %>% 
    html_text() %>% 
    str_split("\r\r\n") %>% 
    unlist() %>% 
    paste(collapse = " ") %>% 
    str_squish()
  return(t)
  
}

extrair_txt <- function(x) {
  y <- as.integer(str_sub(x, 14, -5))
    if (y < 97) {
    return(extrair_html2(x))
  } else {
    if (y < 200) {
      return(extrair_html(x))
    } else {
      return(extrair_pdf(x))
    }
  }
}

datar_html <- function(x) {
  z <- read_html(x) %>% 
    html_nodes("meta") %>% 
    html_attr("content") %>%
    .[5] %>% 
    dmy() %>% 
    as.character()
  
  return(z)
}

datar_pdf <- function(x) {
  z <- pdf_info(x) %>% 
    .$modified %>% 
    str_sub(1, 10) %>% 
    ymd() %>% 
    as.character()
  return(z)
}

extrair_data <- function(x) {
  y <- as.integer(str_sub(x, 14, -5))
  if (y < 200) {
      return(datar_html(x))
    } else {
      return(datar_pdf(x))
    }
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
