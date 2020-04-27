Introduction to Conda 
=========================

This workshop material was created by *Sebastian Luna Valero* with modifications by *Charlie George* and *Lucy Garner* 

For more help using conda, please see: [https://conda.io/docs/]

## Section 1: Install conda

Installing things can involve a lot of reading/writing of files and therefore can be memory intensive
so ideally we want to do this on the cluster. Lets sign into the head node (e.g. cgath1, deva or klyn) and log into a compute node on the cluster.

**1) Log into the cluster using ssh**

    $ ssh <username>@cgatui.imm.ox.ac.uk
    
    (replace <username> with your username)

**2) Lets move onto a compute node on the cluster**

    $ qrsh

**3) Now go to your working directory (e.g. /ifs/obds-training/{cohort}/{USER} if you are on the CGAT system or /t1-data/user/{USER} if you are on the CBRG system) and lets set up a directory for your conda installation**

    $ mkdir conda
    $ cd conda
    
**4) Now we have made a directory for it, lets get a copy of the conda install script**

For Linux (the cluster) use:

    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
   
Please note you can get specific versions of the conda installer from [https://repo.continuum.io/miniconda] and download as follows:
    
    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh 
    
We always recommend downloading the latest version of the conda install script unless there are known issues with it 

**5) Now lets run the install script to install conda**

    $ bash Miniconda.sh -b -p obds_conda
    
**6) So that our terminal knows where to find the conda software, we need to add this location to our $PATH variable so that we can use it**

    # Activate conda installation
    $ source /full/path/to/obds_conda/etc/profile.d/conda.sh
    
    # Activate base environment to move into the default conda software environment
    $ conda activate base

**7) Test your source command has worked by trying:**

    $ which conda

We will see what conda environments are in a moment. The important bit to grasp here is that 'base' is the name of the the default conda environment every time you install conda. It contains the very latest version of python and a few basic python packages.

## Section 2: Using conda

**1) To get help for conda, type:**

    $ conda --help

**2) To get information about your current install, type:**

    $ conda info

**3) We can use conda to search for software packages to install, however in order to find the packages, conda needs the address of certain sites on the internet to look at - these are called 'channels'. Let us add appropriate conda channels to get all the software we need (and trust). The order that these channels are specified is important!**

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda

*Note: Mac users may have problems copying and pasting the config commands above, with strange error messages. If that's the case, please enter these commands manually and try again.*

We have added 3 channels here:\
- defaults channel: this contains major common software that has been packaged for conda by people at conda and anaconda themselves\
- conda-forge: this contains lots of general programming packages that have been packaged for conda by people in the programming/computational community\
- bioconda: this contains biology-specific programmes that have been packaged for conda by people in the computational biology community
  
**4) Check that these channels have been added to your conda installation with:**

    $ conda info

**5) List currently installed packages**

    $ conda list
    
**6) Check whether your packages are up-to-date**

    $ conda update --all

As you have added new channels it is likely that several packages will be upgraded or downgraded at this stage, and some new packages may be added. Please accept the changes by typing `y` at the prompt.

**7) Now let us search and install a package. Our example here is FastQC, a command-line tool to profile quality scores in a fastq file.** 

    $ conda search fastqc 

**8) Check whether or not you already have it installed**

    # find fastqc
    $ conda list fastqc
    
    # or:
    $ which fastqc
    
**9) Once you have found the package you are after, you just need to install it by doing:**

    $ conda install fastqc
    
If you don't specify a version, the latest available one will be installed. However, you can also ask for a specific version of a package with:

    $ conda install fastqc=0.11.7

**10) Now double-check that the package has been installed**

    # use conda
    $ conda list fastqc
    
    # or:
    $ which fastqc
    
    # or use your software:
    $ fastqc --help

**11) Now that we have checked it is installed and usable (i.e. you can access the help), you can remove it:**

    $ conda remove fastqc

**12) It is also possible to see what would happen when you install a package without actually installing it (also known as a dry run)**

    $ conda install pysam --dry-run

**13) In addition to the `conda search <name>` command, you can also visit the following websites to check for available conda packages:**

- https://anaconda.org/bioconda/repo/
- https://conda-forge.org/feedstocks/

## Section 3: Conda environments

So far we have been working with the (default) base environment. However, conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with others (reproducible science). 

Now that we have had some practice setting up conda environments, we want to create a Python 3 environment and an R environment for the OBDS Training Programme that will contain the software that we will use in the taught lectures/workshops over the next few weeks.

Whilst it is possible and really handy to add conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up a new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an  environment.yml file, as this makes it easier for conda to workout what dependencies will be best for most of the software right from the start. 

### A) Setting up your Python 3 environment for the course

#### Python & associated libraries

- python
- numpy (a python package for doing fast mathematical calculations and manipulations)
- pandas (a python package for making/using dataframes)
- scipy (a collection of python packages for data analysis - includes ipython, pandas etc.)
- matplotlib (a python package for plotting)
- seaborn (a much prettier python package for plotting)
- ggplot (python version of ggplot)
- plotly (interactive and browser-based graphing library for Python)
- scikit-learn (a python package for machine learning)
- pysam (a python package for working with BAM/SAM alignment files)
- pybedtools (a python wrapper for bedtools meaning that you can use bedtools functionality in python scripts)
- ruffus (a python pipelining program that we will use to write pipelines)
- drmaa (for the management of submitting jobs to the cluster)
- cgatcore (a library from cgat to make pipelines usable with a computer cluster)
- spyder (an interactive development environment (IDE) for python similar to RStudio)
- jupyter (interactive notebooks for python)
        
#### Bioinformatics software

- fastqc (QC of FASTQ raw sequence files)
- multiqc (collects summary statistics from other bioinformatic programs)
- trimmomatic (read trimming tool)
- hisat2 (quick read aligner (mapper) for spliced sequencing reads)
- bowtie2 (slower read aligner for unspliced sequencing reads)
- kallisto (alignment-free RNA quantification tool)
- samtools (manipulate BAM/SAM alignment files)
- bedtools (comparison, manipulation and annotation of genomic features)
- picard (QC of alignment files)
- subread (counting of reads in features)

**1) In order to get help about conda environments, do:**
    
    $ conda env -h 
    
**2) To get a list of existing environments, type:**
    
    $ conda env list
    
**3) It is also possible to get specific help and examples of a subcommand:**
    
    $ conda env list -h
    
**4) In the week1/conda directory there are two files called `obds_py3.yml` and `obds_r.yml`. Copy these to your conda directory and use these files to create two new conda enviroments - we will start with the python environment.**

**5) Have a look inside the obds_py3.yml file**

    cat obds_py3.yml
    
*Note that you do not have to specify the versions of all the software packages - if you leave them blank, conda will work this out for you*
    
**6) Create a new conda environment using the obds_py3.yml file**
    
    $ conda env create -f obds_py3.yml 
    
If you want, you can give your environment a name of your choice (e.g. python_env) using the -n option:

    $ conda env create -n python_env -f obds_py3.yml
    
**7) Activate your new conda environment**

    $ conda activate obds_py3

    (or replace obds_py3 with the name of your python environment)
    
**8) Check which version of python you have in this enviroment**

    $ python --version
    
**9) List all the packages in this environment**

    $ conda list
   
**10) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export conda environments:**

    $ conda env export -n obds_py3
    
**11) You can redirect the output to a file that you can share**

    $ conda env export -n obds_py3 > my_environment.yml

### B) Setting up your R environment for the course

We also want to create a new enviroment for R and Bioconductor. Again this has been provided for you and includes the following packages (and others).

#### R & associated packages

- R - note that r is called `r-base` in conda - search it and check you can find it 
- rstudio (IDE for R) 
- tidyverse library (family of R packages that have useful data processing functionality)
- deseq2 (R Bioconductor statistical package for differential expression analysis)
- edger (R Bioconductor statistical package for differential expression analysis)
- seurat (R CRAN package for single cell analysis)
- goseq (R Bioconductor package for gene ontology analysis)
- fgsea (R package for gene set enrichment analysis)

**1) As you did for `obds_py3.yml`, generate the R/Bioconductor environment using `obds_r.yml`**

**2) Move into the conda environment and list the packages**

    conda activate obds_r
    conda list

### C) Final steps

**Once you have created the two environments, you might want to modify your `.bashrc` file to do the following:**

1) Point to your conda installation by adding the source command we did right at the beginning to your `.bashrc`

2) Use an alias to load your conda environments. *Note we always want to conda activate base and then activate your environment of interest as this then allows you to use the `which` command to get the conda path - this is useful later on in pipelines*

Step 1 and 2 can be done in an individual step by adding an alias that sources and activates conda.  e.g.
    
    alias obds_py3='source <conda path> && conda activate base && conda activate obds_py3'
    
*Note - sourcing conda is not necessary if you have the following in your .bashrc. This may be added automatically during the Miniconda install.*

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/full/path/to/obds_conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/full/path/to/obds_conda/etc/profile.d/conda.sh" ]; then
            . "/full/path/to/obds_conda/etc/profile.d/conda.sh"
        else
            export PATH="/full/path/to/obds_conda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

#### YAY! You now have a fully set up software environment that you can modify!! 

If you come across extra software in the course that wasn't installed via the YAML file you can use the `conda install` command to add the software to your existing environment - or if you would like to test some new software out you can create a new minimal environment to test it in.

## Section 4: Install conda and create a new conda environment on your local machine

**1) Check for and remove any previous installations of Anaconda (if not needed). Alternatively, you can skip the Miniconda installation step and create a new environment in Anaconda for the course.**

**2) Navigate to a directory of your choice on your local machine (e.g. home directory) and make a new directory called conda. Move into the conda directory.**

**3) Download a copy of the conda install script to your local machine**

For macOS use:

    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh 

For Windows, click on the link below:

https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
    
**4) Run the install script to install conda**

    $ bash Miniconda.sh -b -p obds_conda
    
**5) So that our terminal knows where to find the conda software we need to add this location to our $PATH variable so that we can use it**

    # Activate conda installation
    $ source /full/file/path/to/where/you/have/installed/obds_conda/etc/profile.d/conda.sh
    
    # Activate base environment to move into the default conda software environment
    $ conda activate base

**6) Test your source command has worked by trying:**

    $ conda --help
    
    $ which conda

**7) Configure your conda channels**

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    
**8) For Mac users, copy `obds_py_mac.yml` (Mac users) from the week1/conda directory on the server to your local computer. Use this to create a new conda environment. Remember you can use the -n option to give the environment a name of your choice.**

    conda env create -f obds_py_mac.yml
    
**9) For Windows users, create a new conda environment containing the spyder package.**
    
    conda create -n <name_of_choice> spyder

**10) Modify your .bashrc as in Section 3C.**
\
\
