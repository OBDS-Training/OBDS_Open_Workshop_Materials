
############################################################################################################
cd /var/scratch/$USER
mkdir mamba_installation
cd mamba_installation
############################################################################################################


######################################## Downloading conda #################################################
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
## -L allows re-direction in case this link points somewhere else. -O is the argument for the remote
############################################################################################################


######################################## Running script to install conda ################################### 
bash Mambaforge-$(uname)-$(uname -m).sh -b -p conda
#-b tells the installation script to run without prompts and not to modify your .bashrc or .bash_profile file
#-p sets where you want conda to be installed
############################################################################################################


###################################### Activating the base environment #####################################
#
# let's check where we have installed it to help us with the next command
pwd 

# Activate conda installation - by sourcing the conda.sh script 
# we will need the full path to be correct - tabbing will help avoid errors
source /var/scratch/$USER/mamba_installation/conda/etc/profile.d/conda.sh

# Activate mamba installation - by sourcing the mamba.sh script 
source /var/scratch/$USER/mamba_installation/conda/etc/profile.d/mamba.sh

# Activate base environment to move into the default conda/mamba software environment
mamba activate base
############################################################################################################


############################################ Testing environment ###########################################
#
which conda
which mamba
conda --help
mamba --help

############################################################################################################


#################################### Modifying your ~/.bash_aliases ########################################
#
# Add this
#    alias load_mamba='source /var/scratch/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /var/scratch/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base' 

############################################################################################################


############################################## Testing mamba ###############################################
mamba info
mamba list
mamba update --all
############################################################################################################


########################################## Creating environment 1 ##########################################
#
mamba env -h 
mamba env list
mamba env list -h

## create a new environment
mamba create -n peaktools_env
mamba env list
mamba activate peaktools_env

## install packages
# check if you already have deeptools installed 
mamba list deeptools
#search versions available to install
mamba search deeptools 
#install deeptools
mamba install deeptools 
# check you have installed it
which deeptools 

## install two packages at once
mamba install samtools bedtools

# check packages
mamba list
# see what would happen when you install a package without actually installing it (also known as a dry run)
mamba install multiqc --dry-run

## remove a package
mamba remove samtools
############################################################################################################


########################################## Creating environment 2 ##########################################
## deactivate the evironment we were in
mamba deactivate
## create a new oackage
mamba create -n test_tools_env samtools bedtools
## list the environments (it should be two of them)
mamba env list

# move out of the environment (deactivate it)
mamba deactivate

# remove the environment 
mamba remove --name test_tools_env --all 

# Check your environments list    
mamba env list
############################################################################################################


########################################## Creating environment 3 ##########################################
## copy yaml file
cp /storage/shared/resources/1_linux/3_conda/obds-rnaseq.yml .

## explore the file
less obds-rnaseq.yml


## create environment
mamba env create -f obds-rnaseq.yml 

## and enter it
mamba activate obds-rnaseq

python --version
mamba list
mamba env export -n obds-rnaseq
mamba env export -n obds-rnaseq > my_obds_environment.yml

## Modify alias inn ~/.bash_aliases, by adding
# alias load_mamba='source /var/scratch/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /var/scratch/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base && mamba activate obds-rnaseq'
# And get a new session or source .bash_rc or .bash_aliases

## Test
hisat2 -h
samtools --help

############################################################################################################
