f <- function(one, thetitle){
    
    MYTITLE <- paste0(dig3(thetitle), " - ", addtotitle)
    
    if(xml_name(one) == "multichoice"){
        
        out <- f_multchoice_safely(one, MYTITLE)
        
    } else if (xml_name(one) == "essay"){
        
        x <- one %>% xml_find_all("rationale") %>% xml_find_all("rationalehtml") %>% xml_text()
        
        useexp <- FALSE
        if(length(x) == 1){
            if(str_count(x, "font-family") == 1){
                useexp <- TRUE
            }
        }
        
        if (useexp){
            okay <- 
                str_sub(x, str_locate(x, "font-style: normal")[1, 2] + 3, str_locate(x,  "</span></div>")[1, 1] - 1) %>% 
                str_remove_all("\"") %>% 
                str_split("<|/>") %>% 
                .[[1]] %>% 
                map_chr(str_trim)
            new <- okay[okay != ""]
            whatwehave <- new %>% map_chr(handle)
            
            if(length(whatwehave) == 1){
                if(str_detect(whatwehave, "latex")){
                    if(str_detect(str_sub(whatwehave, 38, -40), ",") | str_detect(str_sub(str_to_lower(whatwehave), 38, -40), "and")){
                        out <- f_freeresponse_safely(one, MYTITLE, useexp, whatwehave)
                    } else {
                        out <- f_expression_safely(one, MYTITLE, useexp = TRUE, THEEXP = str_sub(whatwehave, 38, -40))
                    }
                } else {
                    image_paths <- one %>% xml_find_all("questiontexthtml") %>% xml_text() %>% str_extract_all("images/\\w+\\.png") %>% .[[1]]
                    
                    if (length(image_paths) == 1){
                        thisisall <- get_latex(paste0(path, image_paths))
                        justtheletters <- thisisall %>% str_remove_all("sqrt") %>% str_remove_all("frac")
                        
                        whichletters <- str_detect(justtheletters, letters)
                        
                        if(sum(whichletters) == 1){
                            out <- f_solve_safely(one, MYTITLE, useexp = TRUE, THELEFT = letters[whichletters], THERIGHT = new)
                        } else {
                            out <- f_expression_safely(one, MYTITLE, useexp = TRUE, THEEXP = new)
                            # out <- f_freeresponse_safely(one, MYTITLE, useexp, whatwehave)
                        }
                    } else {
                        
                        if(str_detect(new, ",") | str_detect(new, "and")){
                            out <- f_freeresponse_safely(one, MYTITLE, useexp, whatwehave)
                        } else {
                            out <- f_expression_safely(one, MYTITLE, useexp = TRUE, THEEXP = new)
                        }

                    }
                }
            } else {
                out <- f_freeresponse_safely(one, MYTITLE, useexp, whatwehave)
            }
        } else {
            out <- f_freeresponse_safely(one, MYTITLE, useexp)
        }
    }
    
    nthitem <<- nthitem + 1
    print(paste0("COMPLETED ", nthitem))
    
    out
}
