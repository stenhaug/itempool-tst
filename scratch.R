# test --------------------------------------------------------------------
# multichoice
one <- questions_nodeset[[31]]
one %>% f_multchoice() %>% finish() %>% desktop()

# essay
one <- questions_nodeset[[1]]