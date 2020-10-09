get_latex <- function(image_path){
    x <- try(image_path %>% map_chr(~ mathpix(., insert = FALSE, retry = TRUE)))
    
    if (x[1] == "Error : Still unable to process image after retrying. Exiting\n"){
        return(image_path)
    }
    
    x %>% 
        str_remove_all("\\$\\$") %>% 
        str_remove_all("\\n") %>% 
        str_remove_all("\\\\hline")
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