get_tags <- function(one){
    one %>% 
        xml_find_all("standards") %>% 
        xml_children() %>% 
        xml_text() %>% 
        str_remove_all(":|-") %>% 
        str_trim() %>% 
        str_to_lower() %>% 
        str_replace_all(" ", "-") %>% 
        str_replace_all("keywords", "keywords-") %>% 
        str_replace_all("nationalstandard", "standard-cc-") %>% 
        str_replace_all("statestandardny", "standard-ny") %>% 
        str_replace_all("reference", "z-reference-") %>% 
        str_replace_all("topic", "bucket-")
}

fix_folder <- function(folder){
    str_remove(str_remove(folder, "\\.tst|\\.bnk"),"Exam|EXAMs|exam|Exams")
}

handle <- function(x){
    if (str_detect(x, "images/\\w+\\.png")){
        return(paste0(path, str_extract(x, "images/\\w+\\.png")) %>% get_latex() %>% make_latex())
    } else{
        return(x %>% make_text())
    }
}

blend_text_and_latex_question <- function(qtv, image_paths){
    QUESTION_LATEX <- paste0(path, image_paths) %>% get_latex()
    QUESTION_LATEX_FINAL <- QUESTION_LATEX %>% map_chr(make_latex)
    interleave(qtv, QUESTION_LATEX_FINAL) %>% paste0(collapse = ",")
}

blend_text_and_latex_answer <- function(a_text, a_image){
    ANSWER_LATEX <- paste0(path, a_image) %>% get_latex()
    ANSWER_LATEX_FINAL <- ANSWER_LATEX %>% map_chr(make_latex_answer)
    interleave(a_text, ANSWER_LATEX_FINAL) %>% paste0(collapse = ",")
}

get_latex <- function(image_path){
    x <- image_path %>% map_chr(~ try(mathpix(., insert = FALSE, retry = TRUE)))
    
    x <- 
        x %>% 
        str_remove_all("\\$\\$") %>% 
        str_remove_all("\\n") %>% 
        str_remove_all("\\\\hline")
    
    x %>% str_replace("Error : Still unable to process image after retrying. Exiting", "MISSING IMAGE")
}

make_latex <- function(equation){
    if (is.null(equation)){return(NULL)}
    
    if (str_detect(equation, "\\.png$")){
        return(make_text(equation))
    }
    
    str_replace(
        '{"text": ""},{"type":"math","latex":"LATEXEQUATION","children":[{"text":""}]},{"text":""}',
        "LATEXEQUATION",
        equation %>% str_replace_all("\\\\", "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
    )
}

make_text <- function(text){
    if (is.null(text)){return(NULL)}
    
    str_replace(
        '{"text": "THETEXT"}',
        "THETEXT",
        text 
    )
}

make_text_answer <- function(text){
    if (is.null(text)){return(NULL)}
    
    str_replace(
        '{\\\\"text\\\\":\\\\"THETEXT\\\\"}',
        "THETEXT",
        text 
    )
}

make_latex_answer <- function(equation){
    if (is.na(equation)){return(NA)}
    if (is.null(equation)){return(NULL)}
    if (str_detect(equation, "\\.png$")){
        return(make_text_answer(equation))
    }
    
    str_replace(
        '{\\\\"text\\\\":\\\\"\\\\"},{\\\\"type\\\\":\\\\"math\\\\",\\\\"latex\\\\":\\\\"LATEXEQUATION\\\\",\\\\"children\\\\":[{\\\\"text\\\\":\\\\"\\\\"}]},{\\\\"text\\\\":\\\\"\\\\"}',
        "LATEXEQUATION",
        equation %>% str_replace_all("\\\\", "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
    )
}

interleave <- function(x, y){
    m <- length(x)
    n <- length(y)
    xi <- yi <- 1
    len <- m + n
    err <- len %/% 2
    res <- vector()
    for (i in 1:len)
    {
        err <- err - m
        if (err < 0)
        {
            
            res[i] <- x[xi]
            xi <- xi + 1
            err <- err + len
        } else
        {
            res[i] <- y[yi]
            yi <- yi + 1
        }
    }
    res
}

flatten_tags <- function(tags){
    paste0(paste0('"', tags, '"'), collapse = ",")
}

dig3 <- function(x){
    x <- ifelse(nchar(x) == 1, paste0("00" , x), x)
    x <- ifelse(nchar(x) == 2, paste0("0" , x), x)
    x
}

desktop <- function(text, name = ""){
    if (name == ""){
        thelastfile <- list.files("~/Desktop") %>% str_subset("\\.txt") %>% str_remove("\\.txt") %>% last()
        name <- ifelse(is.na(thelastfile), "", thelastfile)
        name <- paste0("zzz_", name)
    }
    text %>% writeLines(paste0("~/Desktop/", name, ".txt"))
}

finish <- function(.list){.list %>% paste0(collapse = "ITEM FENCEPOST")}

