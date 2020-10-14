library(tidyverse)

hiben <- 
    tibble(
        folder = c("0109ExamIA.tst"),
        addtotitle = c("Jan2009")
    )

# setup -------------------------------------------------------------------
library(xml2)
library(mathpix)

source("_helpers.R")
source("_f_.R")

source("_f_solve.R")
source("_f_multichoice.R")
source("_f_expression.R")
source("_f_freeresponse.R")

source("_t_solve.R")
source("_t_multichoice.R")
source("_t_expression.R")
source("_t_freeresponse.R")

THELOGS <- list()
for (q in 1:nrow(hiben)){
    folder <- hiben$folder[q]
    addtotitle <- hiben$addtotitle[q]
    
    path <- str_glue("data/{folder}/")
    test_xml <- read_xml(str_glue("{path}/TTQuestionList.xml"))
    
    questions_nodeset <- 
        test_xml %>% 
        xml_find_all("questions") %>% 
        xml_children()
    
    d <- 1:length(questions_nodeset)
    indices <- split(d, ceiling(seq_along(d)/50))
    nthitem <- 0
    counter <- 1
    mylog <- list()
    for (these in indices){
        to_pass <- questions_nodeset[these]
        whatshere <- map2(to_pass, these, f)
        worked <-  map_lgl(whatshere, ~ is.null(.$error)) & (map_dbl(whatshere, ~ length(.$result)) == 1)
        whatshere[worked] %>% 
            map_chr("result") %>% 
            finish() %>% 
            desktop(paste0(str_remove(folder, "\\.tst|\\.bnk"), "-", counter))
        mylog[[counter]] <- which(!worked)
        counter <- counter + 1
    }
    THELOGS[[q]] <- mylog
}

# one <- questions_nodeset[[2]]
# hi <- f(one, "DIDTHISWORKBEHAPPY")
# hi$result %>% desktop()
