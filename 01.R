folder <- "AL1890-1899EXAMs.bnk"

# setup -------------------------------------------------------------------
library(tidyverse)
library(xml2)
library(mathpix)

source("_helpers.R")
source("_f_.R")
source("_f_multichoice.R")
source("_f_essay.R")
source("_t_multichoice.R")
source("_t_essay.R")

path <- str_glue("data/{folder}/")

test_xml <- read_xml(str_glue("{path}/TTQuestionList.xml"))

questions_nodeset <- 
    test_xml %>% 
    xml_find_all("questions") %>% 
    xml_children()

to_pass <- questions_nodeset#[c(1, 2, 32)]

whatshere <- to_pass %>% imap(f)

worked <-  map_lgl(whatshere, ~ is.null(.$error)) & (map_dbl(whatshere, ~ length(.$result)) == 1)

whatshere[!worked] %>% map("error")
whatshere[!worked] %>% map("result")

whatshere[worked] %>% 
    map_chr("result") %>% 
    finish() %>% 
    desktop((str_remove(folder, "\\.tst")))

which(!worked)

# one <- questions_nodeset[[1]]
