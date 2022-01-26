
# import tidyverse
library(tidyverse)

# set values of paramters
file_path <- './test_rscript_noparam_input.txt'
name      <- 'Bob'
number    <- '1203'
outfile   <- './test_rscript_noparam_output.txt'

# make 3 strings (one for each line)
new_line1 = sprintf(' This document is pointing to: %s ', file_path) 
new_line2 = sprintf(' the name I have provided is: %s ', name)
new_line3 = sprintf(' the number parameter is: %s', number)

# write lines to file 
write_lines(c(new_line1, new_line2, new_line3), outfile, sep ="\n", append = FALSE)

# run on command line using 
# Rscript test_noparams_rscript.R  