f_solve <- function(one, thetitle, useexp, THELEFT, THERIGHT){
    
    # EXPLANATION -------------------------------------------------------------
    if (useexp){
        it <- t_solve#_exp
        
        it <-
            # str_replace(
            #     it,
            #     "THEEXPLANATION",
            #     whatwehave %>% paste0(collapse = ",")
            # ) %>% 
            str_replace(
                it, 
                "THETITLE",
                thetitle
            )
    } else {
        it <- 
            t_freeresponse %>% 
            str_replace(
                "THETITLE",
                thetitle
            )
    }
    
    # TAGS --------------------------------------------------------------------
    tags <- get_tags(one)
    it <- str_replace(it, "THETAGS", flatten_tags(c(tags, "_solve", paste0("-exam-", addtotitle))))
    
    # QUESTION ----------------------------------------------------------------
    QUESTION_TEXT <- 
        one %>% 
        xml_find_all("questiontext") %>% 
        xml_text() %>% 
        str_replace_all('\"', '\\\\\\\\\\\\\\\\\\\\\\\"') %>% 
        str_remove_all("\\n") %>% # NEED TO MAKE SEPARATE PARAGRAPHS IN THE FUTURE
        str_split("\\[IMAGE\\]") %>% 
        map(make_text)
    
    qtv <- QUESTION_TEXT[[1]]
    image_paths <- one %>% xml_find_all("questiontexthtml") %>% xml_text() %>% str_extract_all("images/\\w+\\.png") %>% .[[1]]
    
    if (length(image_paths) > 0){
        
        woven <- blend_text_and_latex_question(qtv, image_paths)
        
        it <- 
            str_replace(
                it,
                "THEQUESTION", 
                woven
            )
    } else {
        it <- 
            str_replace(
                it,
                "THEQUESTION", 
                QUESTION_TEXT[[1]]
            )
    }
    
    # OUT ---------------------------------------------------------------------
    it %>% 
        str_replace("THELEFT", THELEFT) %>% 
        str_replace("THERIGHT", THERIGHT)
        # it %>% finish() %>% desktop()
}

f_solve_safely <- safely(f_solve)
