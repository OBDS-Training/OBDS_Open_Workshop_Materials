Introduction to Conda 
=========================

This workshop material was origionally created by *Sebastian Luna Valero* and has been updated and modified by *Charlie George* and *David Sims*.

For more help using conda, please see: [https://conda.io/docs/]

## Section 1: Install conda

We want to set up our software environment for all the programs we will be using on the course on the cluster. 
To do this we will first install Conda, then use Conda (and Mamba) to install all the bioinformatics software we will need.  

**1) Log into the cluster using `ssh`**

Make sure you are connected to the VPN then: 

To ssh: 

    $ ssh <username>@cbrglogin2.molbiol.ox.ac.uk
    
    (replace <username> with your username)


**2) Now go to your home directory and lets set up a directory for your conda installation**
    
    $ cd
    $ mkdir conda
    $ cd conda
    

**3) Now we have made a directory for it, lets get a copy of the conda install script**

For Linux (the cluster) use:

    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
   
Please note if you ever need a specific versions of the conda installer (e.g. you know the latest one is not compatible with your system, or has a bug) you can get specific versions of conda from [https://repo.continuum.io/miniconda] and download as follows:
    
    $ curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh 
    
We always recommend downloading the latest version of the conda install script unless there are known issues with it.

**4) Now lets run the install script to install conda**

    $ bash Miniconda.sh -b -p obds_conda
    
`-b` tells the installation script not to modify your `.bashrc` or `.bash_profile` file 

`-p` sets where you want conda to be installed
    
**5) So that our terminal knows where to find the conda software, we need to add this location to our $PATH variable so that we can use it**

    # lets check where we have installed it to help us with the next command
    $ pwd 
    
    # Activate conda installation - by sourcing the conda.sh script 
    # we will need the full path to be correct - tabbing will help avoid errors
    $ source /ADD/THE/PATH/FROM/PWD/ABOVE/conda/obds_conda/etc/profile.d/conda.sh
    
    # Activate base environment to move into the default conda software environment
    $ conda activate base

**6) Test your source command has worked by trying:**

    $ which conda

We will see what conda environments are in a moment. 
The important bit to grasp here is that 'base' is the name of the the default conda environment every time you install conda. 
It contains the latest version of Python and a few basic Python packages.

**7) Lets add the 'source' and 'conda activate' commands to our .bashrc so that Conda is automatically activated every time we open a terminal on the cluster**
    
    # open your .bashrc in nano 
    $ nano ~/.bashrc 
    
    (your .bashrc is in your home directory - the shortcut for this path is '~' hence we can open our .bashrc from anywhere using ~/.bashrc)
    
After the line `module load git/2.31.1` copy the 'source' command (from step 5)
then at the end we will add an alias shortcut for 'conda activate base' command to get something like the following:


    # Source global definitions from system bashrc file
    if [ -f /etc/bashrc ]; then
     . /etc/bashrc
    fi

    # Non-interactive shells inherit the path and other variables
    # from the calling shell, so this setup is not needed.
    # prevents conda env being reset when calling P.run()
    if [[ $PS1 ]]; then

        ### Load environment modules

        # Load the latest version of Git (system version is old)
        module load git/2.31.1
        
        ### Conda setup
        source ~/conda/obds_conda/etc/profile.d/conda.sh

        ### Set environment variables

        # Set DRMAA path for Ruffus / cgatcore pipelines to talk to slurm
        export DRMAA_LIBRARY_PATH=/usr/lib64/libdrmaa.so

        # Set temporary folders for Ruffus / cgatcore pipelines
        export TMPDIR=/tmp
        export SHARED_TMPDIR=/t1-data/user/${USER}/tmp

        ### User defined aliases (shortcuts)

        # change to OBDS course folder
        alias obds='cd /t1-data/project/obds/shared && pwd && ls'
       
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

## Section 2: Using Conda

**1) To get help for Conda, type:**

    $ conda --help

**2) To get information about your current install, type:**

    $ conda info

**3) We can use Conda to search for software packages to install, however in order to find the packages, Conda needs the address of certain sites on the internet to look at - these are called 'channels'. Let's add appropriate Conda channels to get all the software we need (and trust). The order that these channels are specified is important!**

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

**7) Now let us search and install a package. As more and more packages have been added to Conda it's ability to find the packages that match your enviroment has become slower - to speed this process up we will use conda to install a package called ['Mamba'](https://github.com/mamba-org/mamba) that speeds up the enviroment solving when you are installing packages. This will allow us to to install our packages more quickly in the rest of the tutorial. First lets check what versions are available** 

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
    
**11) Have a look at the `--help` menu for both `Conda` and `Mamba` - you'll see they are both very similar!**

This is because `Mamba` is a special speeded up version of Conda and you can use the `Mamba` command interchangably with the `Conda` command to do the same operations. `Mamba` can find packages and dependencies much more quickly than `Conda` but the documentation of how to use the commands is all detailed on the Conda site - hence we want to make you aware that all the commands below can be either `mamba` or `conda` and although we refer to `conda` throughout the course in practise we are going to use the `mamba` command for searching, installing and creating environments because its much quicker. 

**12) lets have a quick demo of using `mamba` inplace of `conda` to install `samtools` a program that lets you manipulate alignment files:**
    
    # instead of using 'conda install samtools' use 'mamba install samtools'
    $ mamba install samtools 

**13) It is also possible to see what would happen when you install a package without actually installing it (also known as a dry run)**

    $ mamba install pysam --dry-run

**14) In addition to the `conda search <name>` or `mamba search <name>` command, you can also visit the following websites to check for available conda packages - this is a much easier way of finding packages if you are unsure how they might be named in conda:**

- https://anaconda.org/bioconda/repo/
- https://conda-forge.org/feedstocks/

**15) Conda also makes it easy to remove packages and their dependencies - lets remove the samtools package**

    $ mamba remove samtools 
    
    # you could also use
    $ conda remove samtools 
    
    
    
## Section 3: Conda environments

So far we have been working with the (default) base environment. However, Conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with others (reproducible science). 

An example of where this is usefule is if you want to start a new project and install new tools, but don't want to risk changing any of your existing software. 
In this example we will create a environment specifically for some pieces of bioinformatic software for ChIP/ATAC-seq analysis. 
We install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version. 

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
    
Now that we have had some practice setting up conda environments, we want to create a software environment for the OBDS Training Programme that will contain the software that we will use in the taught lectures/workshops to process our RNASeq data.

Whilst it is possible and really handy to add conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages if you choose to install r and its associated packages via conda/mamba) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up a new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an `environment.yml` file, as this makes it easier for conda to workout what dependencies will be best for most of the software right from the start. 

### A) Setting up your Environment for the course

#### Bioinformatics software

- fastqc (QC of FASTQ raw sequence files)
- multiqc (collects summary statistics from other bioinformatic programs)
- hisat2 (quick read aligner (mapper) for spliced sequencing reads)
- kallisto (alignment-free RNA quantification tool)
- samtools (manipulate BAM/SAM alignment files)
- picard (QC of alignment files)
- subread (counting of reads in features)

**1) In the /t1-data/project/obds/shared/resources/1_linux/3_conda directory there is a file called `obds-rnaseq.yml`. Copy this file to your `~/conda` directory, we will use this file to create a new conda environment**

**2) Have a look inside the obds-rnaseq.yml file**

    $ less obds-rnaseq.yml
    
*Have a look at the formating of the packages and the channels. Note that you do not have to specify the versions of all the software packages - if you leave them blank, conda will work this out for you*

*Note that if there were additional packages you wanted to install you would just add these to the yml file using `nano`, making sure the formatting is the same as the other packages.*
    
**3) Create a new conda environment using the obds-rnaseq.yml file - again we will use `mamba` instead of `conda` here for speed**
    
    $ mamba env create -f obds-rnaseq.yml 
    
If you want, you can give your environment a name of your choice (e.g. obds_env) using the -n option (by default it will use the name specified at the top of the yml file which is obds-rnaseq):

    $ mamba env create -n obds-rnaseq -f obds-rnaseq.yml
    
**4) Activate your new conda environment**
    
    $ conda activate obds-rnaseq
    (or replace obds-rnaseq with the name of your environment if yoou wrote something different after -n)
    
**5) Check which version of python you have in this environment**

    $ python --version
    
**6) List all the packages in this environment**

    $ conda list
   
**7) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export conda environments:**

    $ conda env export -n obds-rnaseq
    
**8) You can redirect the output to a file that you can share and recreate your environment from**

    $ conda env export -n obds-rnaseq > my_obds_rnaseq_environment.yml
    
### C) Final steps - update your .bashrc to update an alias to activate your obds environment automatically when you load a terminal

    # open your .bashrc
    $ nano ~/.bashrc
    

Then on the line where we added `alias obdsenv='conda activate base'` at the beginning of this tutorial (step 7) add a second command to activate your obds environment (replace obds-rnaseq with whatever you called your obds env in step 3 above) 
*Note we always want to conda activate base and then activate your environment of interest as this then allows you to use the `which` command to get the conda path*

    alias obdsenv='conda activate base && conda activate obds-rnaseq'

*Note: Loading Conda environments can take a little while, so to avoid long waits or unusual behavoir on login we activate our conda environments after we open a terminal and log onto the system.

#### YAY! You now have a fully set up software environment that you can modify!! 

If you come across extra software in the course that wasn't installed via the YAML file you can use the `mamba install` command to add the software to your existing environment - or if you would like to test some new software out you can create a new minimal environment to test it in.

**Congratulations! You have now sucessfully installed conda on the cluster - this will make installing bioinformatics and datascience packages a million times easier and make sure that you can easilly check and reproduce your software environment which is vital for reproducible research** 
