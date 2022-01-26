
library(tidyverse)

# this is the library that we will use to process the command line options into the script 
# it is based on the python optparse library
# you will need to install it ( conda install r-optparse) 
library(optparse)

# set up a list of possible command line options 
option_list = list(
  make_option(c("-f", "--file_path"), action="store", default='input_test.txt', type='character',
              help="file_path_for_input_file"),
  make_option(c("-n", "--name"), action="store", default='charlie', type='character',
              help="name of person"),
  make_option(c("-x", "--number"), action="store", default='100', type='character',
              help="a number of your choice"),
  make_option(c("-o", "--outfile"), action="store", default='~/test_rscript_params.txt',type='character',
              help="the name of the outputfile")
)


# This sets up the command line parser that will put the command line options into a list called opt
opt = parse_args(OptionParser(option_list=option_list))


# make 3 strings (one for each line)
new_line1 = sprintf(' This document is pointing to: %s ', opt$file_path) 
new_line2 = sprintf(' the name I have provided is: %s ', opt$name)
new_line3 = sprintf(' the number parameter is: %s', opt$number)

# write lines to file 
write_lines(c(new_line1, new_line2, new_line3), opt$outfile, sep ="\n", append = FALSE)

# run on command line using 
# Rscript test_params_rscript.R  --file_path='~/test_rmarkdown_param_input.txt'  --name=Hannah --number=30 --outfile='./output_test_parameterised_rscript.txt'

# you can also you the abbreviated flags 
# Rscript test_params_rscript.R  -f='~/test_rmarkdown_param_input.txt'  -n=Hannah -x=30 -o='./output_test_parameterised_rscript.txt'