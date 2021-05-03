Introduction to Conda 
=========================

This workshop material was created by *Sebastian Luna Valero* with modifications by *Charlie George* and *Lucy Garner* 

For more help using conda, please see: [https://conda.io/docs/]

## Section 1: Install conda

We want to set up our software environment for all the programs we will be using on the course on the cluster. 
To do this we will first install conda, then use conda (and mamba) to install all the bioinformatics software we will need. 
Lets sign into the cluster. You can use ssh if your internet and vpn connection is stable, 
however if its not we will sign in using microsoft remote desktop as this will keep your session running 
(and conda downloading/installing programs) even if your internet connection breaks. 

**1) Log into the cluster using `ssh` OR Microsoft Remote Desktop**

Make sure you are connected to the VPN then: 

To ssh: 

    $ ssh <username>@cbrglogin2.molbiol.ox.ac.uk
    
    (replace <username> with your username)
    
    
Or for microsoft remote desktop:
  
    - open microsoft remote desktop
    - click on your session
    - Open a terminal (click on terminal symbol on bar at the very top of the screen) 


**2) Now go to your working directory in the obds folder (e.g. /t1-data/project/obds/{USERNAME}) and lets set up a directory for your conda installation**
    
    $ /t1-data/project/obds/{USERNAME}    # replace USERNAME with your username
    $ mkdir conda
    $ cd conda
    

**3) Now we have made a directory for it, lets get a copy of the conda install script**

For Linux (the cluster) use:

    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
   
Please note if you ever need a specific versions of the conda installer (e.g. you know the latest one is not compatible with your system, or has a bug) you can get specific versions of conda from [https://repo.continuum.io/miniconda] and download as follows:
    
    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh 
    
We always recommend downloading the latest version of the conda install script unless there are known issues with it.
If you are installing software on Windows or Mac machines your will need to download the correct installation script for these systems (see later). 

**4) Now lets run the install script to install conda**

    $ bash Miniconda.sh -b -p obds_conda
    
`-b` tells the installation script not to modify your `.bashrc` or `.bash_profile` file 

`-p` sets where you want conda to be installed
    
**5) So that our terminal knows where to find the conda software, we need to add this location to our $PATH variable so that we can use it**

    # lets check where we have installed it to help us with the next command
    $ pwd 
    
    # Activate conda installation - by sourcing the conda.sh script 
    # we will need the full path to be correct - tabbing will help avoid errors
    $ source /t1-data/project/obds/{USERNAME}/conda/obds_conda/etc/profile.d/conda.sh
    
    # Activate base environment to move into the default conda software environment
    $ conda activate base

**6) Test your source command has worked by trying:**

    $ which conda

We will see what conda environments are in a moment. 
The important bit to grasp here is that 'base' is the name of the the default conda environment every time you install conda. 
It contains the very latest version of python and a few basic python packages.

**7) Lets add the 'source' and  'conda activate commands to our .bashrc so that conda is automatically activated every time we open a terminal on the cluster**
    
 copy your 'source' commands from step 5 above somewhere so that we can use them again in a minute
    
    # open your .bashrc in nano 
    $ nano ~/.bashrc 
    
    (your .bashrc is in your home directory - the shortcut for this path is '~' hence we can open our .bashrc from anywhere using ~/.bashrc)
    
After the line `module load git/2.31.1` copy the 'source' command (from step 5)
then at the end we will add an alias shortcut for 'conda activate base' command to get something like the following:

    # Set umask for default file permissions
    umask 002

    ### Load environment modules

    # Load the latest version of Git (system version is old)
    module load git/2.31.1
    
    ### Source conda
    source  source /t1-data/project/obds/cgeorge/conda/obds_conda/etc/profile.d/conda.sh

    ### Set environment variables

    # Set DRMAA path for Ruffus / cgatcore pipelines to talk to slurm
    export DRMAA_LIBRARY_PATH=/usr/lib64/libdrmaa.so

    # Set temporary folders for Ruffus / cgatcore pipelines
    export TMPDIR=/tmp
    export SHARED_TMPDIR=/t1-data/user/${USER}/tmp

    ### User defined aliases (shortcuts)

    # change to OBDS course folder
    alias obds='cd /t1-data/project/obds/may21 && pwd && ls'
    
    # activate conda environment
    alias obdsenv='conda activate base' 


Its good practise to add in some comment lines (lines starting with a #) above the commands to remind us what they do.

Close and save your .bashrc


*Note - sourcing conda is not necessary if you have the following in your .bashrc. This may be added automatically during the Miniconda install. If you didn't use -b*

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

**7) Now let us search and install a package. As more and more packages have been added to conda it's ability to find the packages that match your enviroment has become slower - to speed this process up we will use conda to install a package called ['mamba'](https://github.com/mamba-org/mamba) that speeds up the enviroment solving when you are installing packages. This will allow us to to install our packages more quickly in the rest of the tutorial. First lets check what versions are available** 

    $ conda search mamba 

**8) Check whether or not you already have it installed**

    # find mamba if its in our current environment
    $ conda list mamba
    
    # or:
    $ which mamba
    
**9) Once you have found the package you are after, you just need to install it by doing:**

    $ conda install mamba
    
If you don't specify a version, the latest available one will be installed. However, you can also ask for a specific version of a by specifying the version number e.g.:

    $ conda install mamba=0.7.8 

**10) Now double-check that the package has been installed**

    # use conda
    $ conda list mamba
    
    # or:
    $ which mamba
    
    # or use your software:
    $ mamba --help
    
**11) Have a look at the `--help` menu for both `conda` and `mamba` - you'll see they are both very similar!**

This is because `mamba` is a special speeded up version of conda and you can use the `mamba` command interchangably with the `conda` command to do the same operations. `mamba` can find packages and dependencies much more quickly then `conda` but the documentation of how to use the commands is all detailed on the conda site - hence we want to make you aware of both and that all the commands below can be either `mamba` or `conda` and although we refer to `conda` throughout the course in practise we are going to use the `mamba` command for searching, installing and creating environments because its much quicker. 

**12) lets have a quick demo of using `mamba` inplace of `conda` to install `samtools` a program that lets you manipulate alignment files:**
    
    # instead of using 'conda install samtools' use 'mamba install samtools'
    $ mamba install samtools 

**13) It is also possible to see what would happen when you install a package without actually installing it (also known as a dry run)**

    $ mamba install pysam --dry-run

**14) In addition to the `conda search <name>` or `mamba search <name>` command, you can also visit the following websites to check for available conda packages - this is a much easier way of finding packages if you are unsure how they might be named in conda:**

- https://anaconda.org/bioconda/repo/
- https://conda-forge.org/feedstocks/

**15) Conda also makes it easy to remove packages and thier dependencies - lets remove the samtools package**

    $ mamba remove samtools 
    
    # you could also use
    $ conda remove samtools 
    
    
    
## Section 3: Conda environments

So far we have been working with the (default) base environment. However, conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with others (reproducible science). 

We will first create a environment specifically for some pieces of bioinformatic software that we want to test later in the course, we install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version or use different versions of python. 

**1) In order to get help about conda environments, do:**
    
    $ conda env -h 
    
**2) To get a list of existing environments, type:**
    
    $ conda env list
    
**3) It is also possible to get specific help and examples of a subcommand:**
    
    $ conda env list -h

**4) We are going to create an environment we will call `peaktools` for some chipseq & atacseq tools including the peakcaller `macs2` and the package `deeptools` this is a set of bioinformatic tools that come in handy for creating genome browser tracks and also looking at peak data from ChIP-seq and ATAC-seq files**

First lets check what environments we have: 

    $ conda env list

Now lets create a our new enviroment: 

    $ mamba create -n peaktools_env
    
*Note that you could do `conda create -n peaktools_env` here to do exactly the same thing - but we are going to use mamba to do 'search', 'install' and 'create' commands as it is much quicker* 
    
Check it your environment list again:
    
    $ conda env list
    
    
**5) To move into the `peaktools_env` environment and use the tools, you need to 'activate' it**

    $ conda activate peaktools_env
    
**6) Now you are in the peaktools_env you can install `deeptools` & `macs2`**

    # you can install things individually (don't run this its just an example)
    $ mamba install deeptools
    $ mamba install macs2
    
    # or in a single command (run this instead)
    $ mamba install deeptools macs2
    
    
**7) Check these tools work by accessing thier --help functions**

    $ macs2 --help
    
    $ deeptools --help 
    
**8) Instead of creating an environment and installing the packages in separate steps you can combine these steps by specifying the packages in your `create` command. We will do this to create a `test_tools_env` were we will install two programs used to manipulate genomic files `samtools` and `bedtools` as an example**
    
    $ mamba create -n test_tools_env samtools bedtools
    
**9) Again to use the tools in this environment you need to go into it by 'activating' it**
    
    # activate environment
    $ conda activate test_tools_env
    
    # check the software works
    $ samtools --help
    
**10) Lets pretend we've tested our tools in our `test_tools_env` and we have decided not to use them in our analysis. Conda makes it really easy to delete environments cleanly**

    # First move out of the environment by `deactiviating it` 
    $ conda deactivate
    
    # remove the environment 
    $ conda remove --name test_tools_env --all 
    
    # Check your environments list    
    $ conda env list
    
Now that we have had some practice setting up conda environments, we want to create a Python 3 environment for the OBDS Training Programme that will contain the software that we will use in the taught lectures/workshops over the next few weeks.

Whilst it is possible and really handy to add conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages if you choose to install r and its associated packages via conda/mamba) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up a new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an `environment.yml` file, as this makes it easier for conda to workout what dependencies will be best for most of the software right from the start. 

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

**1) In the /t1-data/project/obds/shared/resources/1_linux/conda directory there is a file called `obds-py3.yml`. Copy this file to your /t1-data/project/obds/{user}/conda directory, we will use this file to create a new conda environment**

**2) Have a look inside the obds-py3.yml file**

    $ less obds-py3.yml
    
*Have a look at the formating of the packages and the channels. Note that you do not have to specify the versions of all the software packages - if you leave them blank, conda will work this out for you*

*Note that if there were additional packages you wanted to install you would just add these to the yml file using `nano`, making sure the formatting is the same as the other packages.*
    
**3) Create a new conda environment using the obds-py3.yml file - again we will use `mamba` instead of `conda` here for speed**
    
    $ mamba env create -f obds-py3.yml 
    
If you want, you can give your environment a name of your choice (e.g. obds_env) using the -n option (by default it will use the name specified at the top of the yml file which is obds-py3):

    $ mamba env create -n obds_env -f obds-py3.yml
    
**4) Activate your new conda environment**
    
    $ conda activate obds-py3
    (or replace obds-py3 with the name of your python environment)
    
**5) Check which version of python you have in this environment**

    $ python --version
    
**6) List all the packages in this environment**

    $ conda list
   
**7) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export conda environments:**

    $ conda env export -n obds-py3
    
**8) You can redirect the output to a file that you can share and recreate your environment from**

    $ conda env export -n obds-py3 > my_obds_environment.yml
    
### C) Final steps - update your .bashrc to activate your obds enviroment automatically when you load a terminal

    # open your .bashrc
    $ nano ~/.bashrc
    

Then on the line where we added `alias obdsenv='conda activate base'` at the beginning of this tutorial (step 7) add a second command to activate your obds environment (replace obds-py3 with whatever you called your obds env in step 3 above) 
*Note we always want to conda activate base and then activate your environment of interest as this then allows you to use the `which` command to get the conda path - this is useful later on in pipelines*

    alias obdsenv='conda activate base && conda activate obds-py3'

*Note: If you are on a differnt cluster or your own laptop you can set your .bashrc to automatically activate the base (and any other environment) without having to type your alias shortcut. 
The CCB cluster terminal and Microsoft remote desktop sometimes have issues becuase the environments can take a little while to activate sometimes, so to avoid wierd error messages and behavoir we activate our conda enviromentments after we open a terminal and log onto the system. 
If your working on your home computers or another cluster you can add the following commands after your `source` command.*

    ### Source conda
    source  source /t1-data/project/obds/cgeorge/conda/obds_conda/etc/profile.d/conda.sh
    # activate base
    conda activate base
    # activate your favorite conda env (e.g. obds-py3)
    conda activate obds-py3


#### YAY! You now have a fully set up software environment that you can modify!! 

If you come across extra software in the course that wasn't installed via the YAML file you can use the `mamba install` command to add the software to your existing environment - or if you would like to test some new software out you can create a new minimal environment to test it in.


## Section 4: Install conda and create a new conda environment on your local machine

**1) Check for and remove any previous installations of Anaconda (if not needed). Alternatively, if you already have an anaconda or miniconda install on your laptop you can skip the Miniconda installation step, go to section 3 and just create a new environment for the course.**

**2) Navigate to a directory of your choice on your local machine (e.g. home directory) and make a new directory called conda. Move into the conda directory.**

**3) Download a copy of the conda install script to your local machine and install it**

For macOS use:

    # download Miniconda.sh script
    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh 
    
    # run the installation script - this will create a sudirectory called obds_conda that will contain all the conda installation files
    $ bash Miniconda.sh -b -p obds_conda

For Windows, click on the link below:

    https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
    
    # This will download a file called Miniconda3-latest-Windows-x86_64.exe from your browser
    # click on the file and follow the on screen instructions - do not change any of the default settings 
    # by default it will create a `miniconda3` directory containing all the conda installation files in your home directory
    
For linux machines (e.g. Ubuntu) use: 

    # download Miniconda.sh script
    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
    
    # run the installation script - this will create a sudirectory called obds_conda that will contain all the conda installation files
    $ bash Miniconda.sh -b -p obds_conda
    
    
**4) So that our terminal knows where to find the conda software we need to add this location to our $PATH variable so that we can use it**

    # Activate conda installation - you will need to change '/full/file/path/to/where/you/have/installed/' to your relevant path
    $ source /full/file/path/to/where/you/have/installed/obds_conda/etc/profile.d/conda.sh
    
    # remember to replace '/full/file/path/to/where/you/have/installed/obds_conda/' with where your conda installation files are
    # if your stuck here are some examples of where your installation might be if you followed the instructions above
    # the mac/linux command might be 'source ~/obds_conda/etc/profile.d/conda.sh' if you downloaded the miniconda.sh to your home directory
    # the windows command might be ~/miniconda3/etc/profile.d/conda.sh if you followed the default installation instructions

    
    # Activate base environment to move into the default conda software environment
    $ conda activate base

**5) Test your source command has worked by trying:**

    $ conda --help
    
    $ which conda

**6) Configure your conda channels:**

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda

**7) Install mamba in your base environment:**

    $ conda install mamba

**8) For Mac AND Linux users, copy `obds-py3-mac.yml` from the week1/conda directory on the server to your local computer. Use this to create a new conda environment. Remember you can use the -n option to give the environment a name of your choice (it will be called `obds_py` by default)**

    $ mamba env create -f obds-py3-mac.yml
    
**9) For Windows users, copy `obds-py3-windows.yml` from the week1/conda directory on the server to your local computer. Use this to create a new conda environment. Remember you can use the -n option to give the environment a name of your choice (it will be called `obds_py` by default)**
    
    $ mamba env create -f obds-py3-windows.yml

**10) Now we can add our `source` and `conda activate` comands to our `.bashrc` file (or equivalent - see below) so that it is automatically loaded when we open a new terminal**

We want to add these 3 lines to our `.bashrc` or equivalent file (mac users see below) - replace `/blah/blah/blah` with the path to your conda installation (in step 4): 

    source /blah/blah/blah/obds_conda/etc/profile.d/conda.sh 
    conda activate base
    conda activate obds-py3
    

Note that you only need to add the `source` line if you have just installed conda - do not add this line if you already had conda on your local machine (i.e. you didnt do step 1-5 of section 4) 

Sourcing conda is also not necessary if you already have the following in your .bashrc. This may be added automatically during the Miniconda install. However you still might want to add the `conda activate` lines below it

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

The file that you need to place these lines in will depend on what terminal you are using on your local machine. To check this open a new terminal on your local machine and look in the bar at the top of the terminal

- for Mac 
    - if it says `zsh` the file you need to edit is your `~/.zshrc` file 
    - if it says `bash` the file you need to edit is your `~/.bash_profile` file 
    - if you use both `zsh` and `bash` you can create a `~/.profile` file that should be able to be read by both `zsh` and `bash` 

- Windows  
    - you are using the windows subsystem for linux you need to edit the `~/.bashrc`
    
- Linux e.g. Ubuntu  
    - you need to edit the `~/.bashrc`
    
**12) Once you have modified your .bashrc for relevent file, open a new terminal and test that conda and your obds environment are working.**

    $ conda env list  #there should be an asterix by the obds_env if you've activated it in your .bashrc
    
    # if you havent set up your bashrc to automatically activate your obds_env activate it (replace obds-py3 with whatever you have called it) 
    $ conda activate obds-py3
    
    # test jupyter is installed
    $ jupyter --help


**Congratulations! You have now sucessfully installed conda on the cluster and on your local machine - this will make installing bioinformatics and datascience packages a million times easier and make sure that you can easilly check and reproduce your software environment which is vital for reproducible research** 
