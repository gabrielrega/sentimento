library(tidyverse)

download_ata <- function(n_ata = 200) {
  url = paste0("http://www.bcb.gov.br/?COPOM", n_ata)
  if (n_ata < 200) {
    destfile = paste0("./atas/copom_", n_ata, ".htm")
  } else {
    destfile = paste0("./atas/copom_", n_ata, ".pdf")
  }
  download.file(url = url,
                destfile = destfile,
                mode = "wb",
                extra = '-L')
}


seq(from = 21, to = 212) %>% map(download_ata)
