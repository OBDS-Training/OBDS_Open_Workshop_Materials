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
    
    $ cd /ifs/obds-training/{cohort}/{USER} 
    $ mkdir conda
    $ cd conda
    
**4) Now we have made a directory for it, lets get a copy of the conda install script**

For Linux (the cluster) use:

    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
   
Please note if you ever need a specific versions of the conda installer (e.g. you know the latest one is not compatible with your system, or has a bug) you can get specific versions of conda from [https://repo.continuum.io/miniconda] and download as follows:
    
    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh 
    
We always recommend downloading the latest version of the conda install script unless there are known issues with it 

**5) Now lets run the install script to install conda**

    $ bash Miniconda.sh -b -p obds_conda
    
`-b` tells the installation script not to modify your `.bashrc` or `.bash_profile` file 

`-p` sets where you want conda to be installed
    
**6) So that our terminal knows where to find the conda software, we need to add this location to our $PATH variable so that we can use it**

    # Activate conda installation
    $ source /full/path/to/your/obds_conda/etc/profile.d/conda.sh
    
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

We have added 3 channels here:  
- defaults channel: this contains major common software that has been packaged for conda by people at conda and anaconda themselves  
- conda-forge: this contains lots of general programming packages that have been packaged for conda by people in the programming/computational community  
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

**14) As more and more packages have been added to conda it's ability to find the packages that match your enviroment has become slower - to speed this process up we will use conda to install a package called 'mamba' that speeds up the enviroment solving when you are installing packages.** 

    $ conda install mamba
    $ mamba --help 
    
You can see that the mamba commands are identical to the conda commands 

**15) Instead of using `conda` in our create install and remove commands we can now use `mamba` to do the same thing but much more quickly**

    $ mamba install fastqc
    $ mamba remove fastqc
    
## Section 3: Conda environments

So far we have been working with the (default) base environment. However, conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with others (reproducible science). 

We will first create a environment specifically for some pieces of bioinformatic software that we want to test later in the course, we install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version or use different versions of python. 

**1) In order to get help about conda environments, do:**
    
    $ conda env -h 
    
**2) To get a list of existing environments, type:**
    
    $ conda env list
    
**3) It is also possible to get specific help and examples of a subcommand:**
    
    $ conda env list -h

**4) We are going to create an enviroment we will call `peaktools` for some chipseq & atacseq tools including the peakcaller `macs2` and the package `deeptools` this is a set of bioinformatic tools that come in handy for creating genome browser tracks and also looking at peak data from ChIP-seq and ATAC-seq files**

First lets check what environments we have: 

    $ conda env list

Now lets create a our new enviroment: 

    $ mamba create -n peaktools_env
    
*Note that you could do `conda create -n deeptools_env` here to do exactly the same thing - but we are going to use mamba to do 'search', 'install' and 'create' commands as it is much quicker* 
    
Check it your environment list again:
    
    $ conda env list
    
    
**5) To move into the `peaktools_env` environment and use the tools, you need to 'activate' it**

    $ conda activate peaktools_env
    
**6) Now you are in the peaktools_env you can install `deeptools` & `macs2`**

    $ mamba install deeptools
    
    $ mamba install macs2
    
**7) Check these tools work by accessing thier --help functions**

    $ macs2 --help
    
    $ deeptools --help 
    
**5) Instead of creating an environment and installing the packages in separate steps you can combine these steps by specifying the packages in your `create` command. We will do this to create a `peaktools_env_2`. We will also specify that we want our python version to be greater than 3.6 because we want the newer version of `macs2`.**
    
    $ mamba create -n peaktools_env_2 deeptools macs2>3.6
    
**6) Again to use the tools in this environment you need to go into it by 'activating' it**
    
    # activate environment
    $ conda activate peaktools_env_2
    
    # check macs2 works
    $ macs2 --help
    
**7) Lets pretend we've tested our tools in our `peaktools_env_2` and we have decided not to use them in our analysis. Conda makes it really easy to delete environments cleanly**

    # First move out of the environment by `deactiviating it` 
    $ conda deactivate
    
    # remove the environment 
    $ conda remove --name peaktools_env_2 --all 
    
    # Check your environments list    
    $ conda env list
    
Now that we have had some practice setting up conda environments, we want to create a Python 3 environment for the OBDS Training Programme that will contain the software that we will use in the taught lectures/workshops over the next few weeks.

Whilst it is possible and really handy to add conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages if you choose to install r and its associated packages via conda) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up a new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an environment.yml file, as this makes it easier for conda to workout what dependencies will be best for most of the software right from the start. 

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

**1) In the /shared/week1/conda directory there is a file called `obds_py3.yml`. Copy this file to your week1/conda directory, we will use this file to create a new conda environment**

**2) Have a look inside the obds_py3.yml file**

    $ less obds_py3.yml
    
*Have a look at the formating of the packages and the channels. Note that you do not have to specify the versions of all the software packages - if you leave them blank, conda will work this out for you*

We have 2 packages we need to add, `hdbscan` and `umap-learn`. Add these to the yml file using `nano`, making sure the formatting is the same as the other packages.
    
**3) Create a new conda environment using the obds_py3.yml file - again we will use `mamba` instead of `conda` here for speed**
    
    $ mamba env create -f obds_py3.yml 
    
If you want, you can give your environment a name of your choice (e.g. python_env) using the -n option (by default it will use the name specified at the top of the yml file):

    $ mamba env create -n python_env -f obds_py3.yml
    
**4) Activate your new conda environment**
    $ conda activate obds_py3

    (or replace obds_py3 with the name of your python environment)
    
**5) Check which version of python you have in this environment**

    $ python --version
    
**6) List all the packages in this environment**

    $ conda list
   
**7) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export conda environments:**

    $ conda env export -n obds-py3
    
**8) You can redirect the output to a file that you can share and recreate your environment from**

    $ conda env export -n obds-py3 > my_environment.yml

### C) Final steps

**Once you have created your environment, you might want to modify your `.bashrc` file to do the following:**

1) Point to your conda installation by adding the source command we did right at the beginning to your `.bashrc`

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

2) Use an alias to load your conda environments. *Note we always want to conda activate base and then activate your environment of interest as this then allows you to use the `which` command to get the conda path - this is useful later on in pipelines*

Step 1 and 2 can be done in an individual step by adding an alias that sources and activates conda e.g.
    
    alias obds_py3='source <conda path> && conda activate base && conda activate obds-py3'

#### YAY! You now have a fully set up software environment that you can modify!! 

If you come across extra software in the course that wasn't installed via the YAML file you can use the `mamba install` command to add the software to your existing environment - or if you would like to test some new software out you can create a new minimal environment to test it in.

## Section 4: Install conda and create a new conda environment on your local machine

**1) Check for and remove any previous installations of Anaconda (if not needed). Alternatively, if you already have an anaconda or miniconda install on your laptop you can skip the Miniconda installation step, go to step 6 and just create a new environment for the course.**

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

**7) Configure your conda channels:**

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda

**8) Install mamba in your base environment:**

    $ conda install mamba

**9) For Mac users, copy `obds-py3-mac.yml` (Mac users) from the week1/conda directory on the server to your local computer. Use this to create a new conda environment. Remember you can use the -n option to give the environment a name of your choice**

    $ mamba env create -f obds-py3-mac.yml
    
**10) For Windows users, copy `obds_py3_windows.yml` from the week1/conda directory on the server to your local computer. Use this to create a new conda environment. Remember you can use the -n option to give the environment a name of your choice**
    
    $ mamba env create -f obds-py3-windows.yml

**11) Modify your `.bashrc` file as in Section 3C**

