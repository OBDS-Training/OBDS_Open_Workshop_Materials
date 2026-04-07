
############################################################################################################
cd /var/scratch/$USER
mkdir conda_installation
cd conda_installation
############################################################################################################


######################################## Downloading conda #################################################
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/condaforge-$(uname)-$(uname -m).sh"
## -L allows re-direction in case this link points somewhere else. -O is the argument for the remote
############################################################################################################


######################################## Running script to install conda ################################### 
bash condaforge-$(uname)-$(uname -m).sh -b -p conda
#-b tells the installation script to run without prompts and not to modify your .bashrc or .bash_profile file
#-p sets where you want conda to be installed
############################################################################################################


###################################### Activating the base environment #####################################
#
# let's check where we have installed it to help us with the next command
pwd 

# Activate conda installation - by sourcing the conda.sh script 
# we will need the full path to be correct - tabbing will help avoid errors
source /var/scratch/$USER/conda_installation/conda/etc/profile.d/conda.sh

# Activate base environment to move into the default conda software environment
conda activate base
############################################################################################################


############################################ Testing environment ###########################################
#
which conda
conda --help

############################################################################################################


#################################### Modifying your ~/.bash_aliases ########################################
#
# Add this
#    alias load_conda='source /var/scratch/$USER/conda_installation/conda/etc/profile.d/conda.sh && conda activate base' 

############################################################################################################


############################################## Testing conda ###############################################
conda info
conda list
conda update --all
############################################################################################################


########################################## Creating environment 1 ##########################################
#
conda env -h 
conda env list
conda env list -h

## create a new environment
conda create -n peaktools_env
conda env list
conda activate peaktools_env

## install packages
# check if you already have deeptools installed 
conda list deeptools
#search versions available to install
conda search deeptools 
#install deeptools
conda install deeptools 
# check you have installed it
which deeptools 

## install two packages at once
conda install samtools bedtools

# check packages
conda list
# see what would happen when you install a package without actually installing it (also known as a dry run)
conda install multiqc --dry-run

## remove a package
conda remove samtools
############################################################################################################


########################################## Creating environment 2 ##########################################
## deactivate the evironment we were in
conda deactivate
## create a new oackage
conda create -n test_tools_env samtools bedtools
## list the environments (it should be two of them)
conda env list

# move out of the environment (deactivate it)
conda deactivate

# remove the environment 
conda remove --name test_tools_env --all 

# Check your environments list    
conda env list
############################################################################################################


########################################## Creating environment 3 ##########################################
## copy yaml file
cp /storage/shared/resources/1_linux/3_conda/obds-rnaseq.yml .

## explore the file
less obds-rnaseq.yml


## create environment
conda env create -f obds-rnaseq.yml 

## and enter it
conda activate obds-rnaseq

python --version
conda list
conda env export -n obds-rnaseq
conda env export -n obds-rnaseq > my_obds_environment.yml

## Modify alias in ~/.bash_aliases, by adding
# alias load_conda='source /var/scratch/$USER/conda_installation/conda/etc/profile.d/conda.sh && conda activate base && conda activate obds-rnaseq'
# And get a new session or source .bash_rc or .bash_aliases

## Test
hisat2 -h
samtools --help

############################################################################################################
