f_multchoice <- function(one, thetitle){
    
    # EXPLANATION -------------------------------------------------------------
    x <- one %>% xml_find_all("rationale") %>% xml_find_all("rationalehtml") %>% xml_text()
    
    if (length(x) > 0){
        it <- t_multichoice_exp
        
        okay <- 
            str_sub(x, str_locate(x, "font-style: normal")[1, 2] + 3, str_locate(x,  "/></span></div>")[1, 1] - 2) %>% 
            str_remove_all("\"") %>% 
            str_split("<|/>") %>% 
            .[[1]] %>% 
            map_chr(str_trim)
        
        new <- okay[okay != ""]
        
        handle <- function(x){
            if (str_detect(x, "images/\\w+\\.png")){
                return(paste0(path, str_extract(x, "images/\\w+\\.png")) %>% get_latex() %>% make_latex())
            } else{
                return(x %>% make_text())
            }
        }
        
        whatwehave <- new %>% map_chr(handle)
        
        it <-
            str_replace(
                it,
                "THEEXPLANATION",
                whatwehave %>% paste0(collapse = ",")
            ) %>% 
            str_replace(
                "THETITLE",
                thetitle
            )
    } else {
        it <- 
            t_multichoice %>% 
            str_replace(
                "THETITLE",
                thetitle
            )
    }
    
    # TAGS --------------------------------------------------------------------
    tags <- one %>% xml_find_all("standards") %>% xml_children() %>% xml_text() %>% str_subset("^reference", negate = TRUE) %>% str_remove_all("(nationalstandard)|(topic)|(statestandard)|(keywords)") %>% str_remove_all(":|-") %>%  str_trim() %>% str_to_lower() %>% str_replace_all(" ", "-")
    it <- str_replace(it, "THETAGS", flatten_tags(c(tags, "type-multiple-choice", paste0("jmap-", str_remove(str_remove(folder, "\\.tst"),"Exam")))))
    
    # QUESTION ----------------------------------------------------------------
    QUESTION_TEXT <- 
        one %>% 
        xml_find_all("questiontext") %>% 
        xml_text() %>% 
        str_replace_all('\"', '\\\\\\\\\\\\\\\\\\\\\\\"') %>% 
        str_remove_all("\\n") %>% # NEED TO MAKE SEPARATE PARAGRAPHS IN THE FUTURE
        str_split("\\[IMAGE\\]") %>% 
        map(make_text)
    
    image_paths <- one %>% xml_find_all("questiontexthtml") %>% xml_text() %>% str_extract_all("images/\\w+\\.png") %>% .[[1]]
    if (length(image_paths) > 0){
        QUESTION_LATEX <- paste0(path, image_paths) %>% get_latex()
        QUESTION_LATEX_FINAL <- QUESTION_LATEX %>% make_latex()
        it <- 
            it %>% 
            str_replace(
                "THEQUESTION", 
                interleave(QUESTION_TEXT[[1]], QUESTION_LATEX_FINAL) %>% paste0(collapse = ",")
            )
    } else {
        it <- 
            it %>% 
            str_replace(
                "THEQUESTION", 
                QUESTION_TEXT[[1]]
            )
    }
    
    # ANSWERS -----------------------------------------------------------------
    answers_nodes <- one %>% xml_find_all("answers") %>% xml_children()
    answertext <- answers_nodes %>% xml_find_all("answertext") %>% xml_text()
    answer_image_paths <- answers_nodes %>% xml_find_all("answerhtml") %>% xml_text() %>% str_extract_all("images/\\w+\\.png")
    
    ANSWER_TEXT_LIST <- answertext %>% str_split("\\[IMAGE\\]") %>% map(make_text_answer)
    
    ANSWER_LATEX_LIST <- list()
    for (i in seq_along(answer_image_paths)){
        if (length(answer_image_paths[[i]]) == 1){
            ANSWER_LATEX_LIST[[i]] <- get_latex(paste0(path, answer_image_paths[[i]]))
        } else {
            ANSWER_LATEX_LIST[[i]] <- NA
        }
    }
    ANSWER_LATEX_LIST_FINAL <- ANSWER_LATEX_LIST %>% map(make_latex_answer)
    
    FINAL_ANSWERS <- list()
    for (i in (1:max(length(ANSWER_TEXT_LIST), length(ANSWER_LATEX_LIST_FINAL)))){
        
        if (is.na(ANSWER_LATEX_LIST_FINAL[[i]])){
            FINAL_ANSWERS[[i]] <- ANSWER_TEXT_LIST[[i]]
        } else {
            FINAL_ANSWERS[[i]] <- 
                interleave(ANSWER_TEXT_LIST[[i]], ANSWER_LATEX_LIST_FINAL[[i]]) %>% 
                paste0(collapse = ",")
        }
    }
    
    for (i in seq_along(FINAL_ANSWERS)){
        it <- str_replace(it, paste0("ANSWER", i), FINAL_ANSWERS[[i]])
    }
    
    # CORRECT -----------------------------------------------------------------
    it <- 
        str_replace(
            it, 
            "THECORRECT", 
            letters[which.max(as.numeric(answers_nodes %>% xml_find_all("valuetype") %>% xml_text()))]
        )

    # OUT ---------------------------------------------------------------------
    it
    
    # it %>% finish() %>% desktop()
}

f_multchoice_safely <- safely(f_multchoice)
