f <- function(one, thetitle){
    
    if(xml_name(one) == "multichoice"){
        out <- f_multchoice_safely(one, dig3(thetitle))
    } else if (xml_name(one) == "essay"){
        out <- f_essay_safely(one, dig3(thetitle))
    }
    
    out
}
