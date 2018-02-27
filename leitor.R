library(dplyr)
library(tidytext)
library(lexiconPT)

data("oplexicon_v3.0")
get_word_sentiment("temer")

bcb <- read_delim("bcb.txt", "\t", escape_double = FALSE, 
                  col_names = FALSE, trim_ws = TRUE)


bcb %>% rename(text = X1) %>% unnest_tokens(term, text) %>% inner_join(oplexicon_v3.0) %>% .$polarity %>% sum()
