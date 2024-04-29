Software Management with Mamba and Conda 
=========================================

This workshop material was created by *Sebastian Luna Valero*, *Charlie George* and *Lena Morrill Gavarró*


For more help using Mamba please see: 
- [Mamba documentation](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)
- [Conda documentation](https://conda.io/docs/) 

## Mamba vs conda

#### What is conda or anaconda? 

- Conda/anaconda is a package management system. That allows you to easily search for software and install it without having to worry about having to install all the correct dependencies, the pain of having to match up correct versions, etc. Whilst lots of package management systems are language or system specific (e.g. Apple App Store, pip for python packages, CRAN/Bioconductor for R packages), conda/anaconda can be used to install a huge number of software packages across multiple systems (Linux, Mac, Windows etc). They make it easy to install software onto any system and it's often used in introductory courses to set up your software environments so you might have previously installed it without really realising.

- Conda is the small lightweight command line tool that allows you to install packages easily, when you install it, it creates a `base` environment which contains itself and the minimal number of packages that enables it to run.

- Anaconda is a much larger installation that installs the conda command line tool itself and a load of other data science software, as well as a graphical interface so you can install stuff by clicking on things. It is much larger and takes up much more space, installing many packages that you will never actually use. It is for this reason we recommend installing the minimal conda/mamba packages instead. 

#### What is Mamba?

- As conda became more and more popular, more and more packages were added to its repositories and it became slower and slower to search through them and solve environments. Mamba was written in C++ as a reimplementation of conda to improve the performance and solve enviroments much faster than Conda can. You used to just install it as a separate package into your conda base environment (i.e.,paradoxically, conda installed mamba) but more recently it has been released as a package on its own, without the need to install conda first. 

#### What is microMamba?

- it is "a tiny version of the  mamba package manager". It has its own command line interface and does not come with a default Python version or need of a base environment. It supports a subset of the mamba/conda commands, but its documentation is a bit patchy so for our purposes at this time we'll stick with the Conda/Mamba install approach below (mambaForge).

#### Which are we using and why? 

- We are going to install conda and mamba together in a single step using the `mambaForge` script, which gives us the functionality of both Mamba and Conda. We will interface with it mainly by using `mamba` commands.

#### Why do you still refer to conda if we are not using it? 

- Mamba was based on conda and actually at this point the conda documentation and online help/troubleshooting is much better then the mamba documentation. It's useful to sometimes google your issues with "conda" in the title rather than "mamba" and, if you find a conda command as a solution, just replace `conda` with `mamba` at the beginning. Mamba also uses the conda channels and anaconda repository to find all its packages so you still need to know they are related.

## Section 1: Check for conda/mamba installs and install if needed

We want to set up our software environment for all the programs we will be using on the course on the cluster. To do this we will first install mamba to install all the bioinformatics software we will need. 

Let's sign into the `obds` cluster using `ssh` (you might need to sign into the VPN if not on the WIMM network using an ethernet cable)

#### 1) Log into the cluster using `ssh`: 

    $ ssh <SSO>@obds

<!---    $ ssh -J <SSO>@bastion.imm.ox.ac.uk <SSO>@obds --->
<!---    $ ssh <username>@login1.molbiol.ox.ac.uk --->
    
(replace <SSO> with your university SSO e.g. `abcd1234@lbastion.imm.ox.ac.uk`)
  

#### 2) Check for previous conda/mamba installs 

Conda/Mamba/Anaconda like to secretly modify your `~/.bashrc` when you install them, the easiest way of 
checking if you have a preexisting installation of any of these packages is looking at your `~/.bashrc` and checking for any lines of code activating conda 

```
$ less ~/.bashrc 
```

Lines that indicate you have a prexisiting conda/mamba/anaconda install are things like: 

```
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/charlie/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/charlie/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/charlie/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/charlie/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
```

OR 

```
source ~/conda/etc/profile.d/conda.sh 
```

If you have these lines - you already have a conda installation - its useful to stop and think here about if you really want to reinstall conda/mamba or continue with your previous versions. 

- **Reasons for reinstalling:**
    - Changing the location of installation - your home directory has a limited amount of space, as your projects progress and you install more packages a large amount of space will be taken up. For those at WIMM using the JADE cluster, it is now recommended to install Mamba in your `/project` folder, which can be easily increased in size. In the case of the OBDS Training course, you will be working in the folder `/project/$USER`, as you have already been.

- **Reasons to continue with your previous version:**
    - you already have a load of environments set up and it is working perfectly fine 

**Important**: Conda & mamba can exhibit strange behavoirs with their `$PATH` variable and switching between environments if you have multiple versions of Conda/Anaconda in your `$PATH`. Depending on your situation it might be best to comment out (put a `#` in from of them) any lines from previous conda installations - if you comment them out you can always remove the `#` to add them back in later if you need them. 


#### 3) Installing Miniforge=Mambaforge

Let's make a directory for the conda/mamba installation - as in the rest of the course, you will be using the directory `/project/$USER/`. You can also replace $USER with your SSO, e.g. `/project/abcd1324/`

```
    $ cd /project/$USER/
    $ mkdir mamba_installation
    $ cd mamba_installation
 ```   

Now we have made a directory for it, let's get a copy of the mamba install script**:

```
    $ curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
    
```
    
We always recommend downloading the latest version of the install script unless there are known issues with it.
**NOTE: If you are installing software on Windows or Mac machines your will need to download the correct installation script for these your system - see https://github.com/conda-forge/miniforge#mambaforge for the correct download url to use. The command above that automatically detects the right system/chip for our linux system (i.e using the uname, and uname -m commands) but might not work for M1/2 apple chips etc**

The Mamba forge script will download conda & mamba and preconfigure it to use the conda-forge channel (we will adjust this later)

**4) Now let's run the install script to install conda**

    $ bash Mambaforge-$(uname)-$(uname -m).sh -b -p conda
    
`-b` tells the installation script to run without prompts and not to modify your `.bashrc` or `.bash_profile` file 

`-p` sets where you want conda to be installed

**NOTE: again if you are installing on your own mac/windows machine the above command might not work. Might need to correct the Mambaforge .sh filename to the correct OS/architecture.**
    
**5) So that our terminal knows where to find the conda software, we need to add this location to our $PATH variable so that we can use it**

    # let's check where we have installed it to help us with the next command
    $ pwd 
    
    # Activate conda installation - by sourcing the conda.sh script 
    # we will need the full path to be correct - tabbing will help avoid errors
    $ source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh

    # Activate mamba installation - by sourcing the mamba.sh script 
    $ source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh

    # Activate base environment to move into the default conda/mamba software environment
    $ mamba activate base


You should see `(base)` has appeared at the beginning of your prompt - e.g `(base) abcd1234@obds:$`

We will see what conda environments are in a moment. The important bit to grasp here is that 'base' is the name of the the default conda environment every time you install conda. It contains python, conda, mamba and a few basic python packages.

**6) Test your source command has worked by trying:**

```
    $ which conda
    $ which mamba 
    $ conda --help 
    $ mamba --help 
```

You should be able to see the conda and mamba help menus are the same! 


**7) Let's add the 'source' and  'mamba activate' commands to our `.bash_aliases` so that we can activate conda easily when we log onto the server**
    
 copy your 'source' commands from step 5 above somewhere so that we can use them again in a minute

```
    # open your ~/.bash_aliases in nano 
    $ nano ~/.bash_aliases 
```

(reminder: your `.bash_aliases` is in your home directory - the shortcut for this path is `~` hence we can open our `.bash_aliases` from anywhere using `~/.bash_aliases`)

```
    # Create an alias to load conda/mamba
    alias load_mamba='source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base' 
```

It's good practice to add in some comment lines (lines starting with a #) above the commands to remind us what they do.

Close and save your `.bash_aliases`.

<!---
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
--->

    

## Section 2: Using mamba

**1) To get help for mamba, type:**

    $ mamba --help

**2) To get information about your current install, type:**

    $ mamba info

**3) We can use mamba to search for software packages to install, however in order to find the packages, mamba needs the address of certain sites on the internet to look at - these are called 'channels'. Let us add appropriate channels to get all the software we need (and trust). The order that these channels are specified is important!** As we used mamba forge to install mamba these should already be configured in the right order just in case but we will go through these steps just in case. NOTE that this is one of the only times we use the `conda` command instead of `mamba`

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda

*Note: Mac users may have problems copying and pasting the config commands above, with strange error messages. If that's the case, please enter these commands manually and try again.*

We have added 3 channels here:  
- defaults channel: this contains major common software that has been packaged for conda/mamba by people at conda and anaconda themselves  
- conda-forge: this contains lots of general programming packages that have been packaged for conda/mamba by people in the programming/computational community  
- bioconda: this contains biology-specific programmes that have been packaged for conda/mamba by people in the computational biology community  
  
**4) Check that these channels have been added to your conda installation with:**

    $ mamba info

**5) List currently installed packages**

    $ mamba list
    
**6) Check whether your packages are up-to-date**

    $ mamba update --all

As you have added new channels it is likely that several packages will be upgraded or downgraded at this stage, and some new packages may be added. Please accept the changes by typing `y` at the prompt.


## Section 3: Conda environments

### Environment #1

So far we have been working with the default (base) environment. However, conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with others (reproducible science). 

We will first create a environment specifically for some pieces of bioinformatic software that we want to test later in the course, we install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version or use different versions of python. 

**1) In order to get help about conda environments, do:**
    
    $ mamba env -h 
    
**2) To get a list of existing environments, type:**
    
    $ mamba env list
    
**3) It is also possible to get specific help and examples of a subcommand:**
    
    $ mamba env list -h

**4) We are going to create an environment we will call `peaktools` for some ChIP-Seq & ATAC-Seq tools including the peakcaller `MACS2` and the package `deepTools`: this is a set of bioinformatic tools that come in handy for creating genome browser tracks and also looking at peak data from ChIP-Seq and ATAC-Seq files**

First let's check what environments we have: 

    $ mamba env list

Now let's create a our new enviroment: 

    $ mamba create -n peaktools_env
    
*Note that you could do `conda create -n peaktools_env` here to do exactly the same thing - but we are going to use mamba to do 'search', 'install' and 'create' commands as it is much quicker* 
    
Check it your environment list again:
    
    $ mamba env list
    
    
**5) To move into the `peaktools_env` environment and use the tools, you need to 'activate' it**

    $ mamba activate peaktools_env
    
**6) Now you are in the peaktools_env you can search and install packages**

```
    # check if you already have deeptools installed 
    $ mamba list deeptools

    # search versions available to install
    $ mamba search deeptools 

    # install deeptools
    $ mamba install deeptools 

    # check you have installed it
    $ which deeptools 

```

If you don't specify a version, the latest available one will be installed. However, you can also ask for a specific version of a by specifying the version number e.g.:

    $ mamba install deeptools=2.1.3 

You can also install multiple packages at the same time e.g. `samtools` & `bedtools`**

```
    # you can install things individually (don't run this its just an example)
    $ mamba install samtools
    $ mamba install bedtools
    
    # or in a single command (run this instead)
    $ mamba install samtools bedtools
```


**7) Now double-check that the packages have been installed**

    $ mamba list

**8) It is also possible to see what would happen when you install a package without actually installing it (also known as a dry run)**

    $ mamba install multiqc --dry-run

**9) In addition to the `mamba search <name>` command, you can also visit the following websites to check for available conda/mamba packages - this is a much easier way of finding packages if you are unsure how they might be named in conda/mamba - remember just replace `conda` with `mamba` in the command and leave out the channel e.g instead of `conda install bioconda::fastqc` type `mamba install fastqc`  :**

- https://anaconda.org/bioconda/repo/
- https://conda-forge.org/feedstocks/

**10) Conda/mamba also makes it easy to remove packages and their dependencies - let's remove the samtools package**

    $ mamba remove samtools 
    
       
**11) A good way of checking that tools work is by accessing their `--help` functions**

    $ bedtools --help
    
    $ deeptools --help 

### Environment #2

**12) Instead of creating an environment and installing the packages in separate steps you can combine these steps by specifying the packages in your `create` command. We will do this to create a `test_tools_env` were we will install two programs used to manipulate genomic files `samtools` and `bedtools` as an example**

    # First move out of the environment by `deactivating it` 
    $ mamba deactivate
    # you should now be in (base)
    
    $ mamba create -n test_tools_env samtools bedtools
    
**9) Again to use the tools in this environment you need to go into it by 'activating' it**
    
    # activate environment
    $ mamba activate test_tools_env
    
    # check the software works
    $ samtools --help
    
**10) Let's pretend we've tested our tools in our `test_tools_env` and we have decided not to use them in our analysis. Conda makes it really easy to delete environments cleanly**

    # First move out of the environment by `deactivating it` 
    $ mamba deactivate
    
    # remove the environment 
    $ mamba remove --name test_tools_env --all 
    
    # Check your environments list    
    $ mamba env list
    
Now that we have had some practice setting up mamba environments, we want to create an environment for the OBDS Training Programme that will contain the software that we will use in the taught lectures/workshops over the next couple of days.

Whilst it is possible and really handy to add conda/mamba packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages if you choose to install r and its associated packages via conda/mamba) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up a new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an `environment.yml` file, as this makes it easier for mamba to workout what dependencies will be best for most of the software right from the start. 

### Environment #3 (environment for the course)

#### Bioinformatics software
  
- fastqc (QC of FASTQ raw sequence files)
- multiqc (collects summary statistics from other bioinformatic programs)
<!--- - trimmomatic (read trimming tool) -- not used here --->
- hisat2 (quick read aligner (mapper) for spliced sequencing reads)
<!--- - - bowtie2 (slower read aligner for unspliced sequencing reads) -- not used here --->
- samtools (manipulate BAM/SAM alignment files)
- kallisto (alignment-free RNA quantification tool)
- picard (QC of alignment files) -- not used here
- subread (counting of reads in features)
- bedtools (comparison, manipulation and annotation of genomic features)

**1) In the `/project/shared/resources/1_linux/3_conda/` directory there is a file called `obds-rnaseq.yml`. Copy this file to your `/project/$USER/mamba_installation` directory, we will use this file to create a new conda environment**

**2) Have a look inside the obds-rnaseq.yml file**

    $ less obds-rnaseq.yml
    
*Have a look at the formating of the packages and the channels. Note that you do not have to specify the versions of all the software packages - if you leave them blank, conda will work this out for you*

*Note that if there were additional packages you wanted to install you would just add these to the yml file using `nano`, making sure the formatting is the same as the other packages.*
    
**3) Create a new environment using the obds-rnaseq.yml file**
    
    $ mamba env create -f obds-rnaseq.yml 
    
If you want, you can give your environment a name of your choice (e.g. `alternative_name_env`) using the -n option (by default it will use the name specified at the top of the yml file, which is `obds_env`). You do not have to run the line below, but you can use it for reference (although it is clearer to specify the env name in the yaml file).

    $ mamba env create -n alternative_name_env -f obds-rnaseq.yml

**4) Activate your new conda environment**
    
    $ mamba activate obds-rnaseq
    (or replace obds-rnaseq with the name of your python environment)
    
**5) Check which version of python you have in this environment**

    $ python --version
    
**6) List all the packages in this environment**

    $ mamba list
   
**7) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export conda environments:**

    $ mamba env export -n obds-rnaseq
    
**8) You can redirect the output to a file that you can share and recreate your environment from**

    $ mamba env export -n obds-rnaseq > my_obds_environment.yml
    
**9) Final steps - update your `.bash_aliases` to activate your obds enviroment automatically when you load a terminal**

    # open your .bash_aliases
    $ nano ~/.bash_aliases
    
Then on the line where we added `alias load_mamba` at the beginning of this tutorial add `&& mamba activate obds-rnaseq` at the end to activate your obds environment. *Note we always want to conda activate base first and then activate your environment of interest as this then allows you to use the `which` command to get the conda path - this is useful later in pipelines*

```
alias load_mamba='source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base && mamba activate obds-rnaseq' 
```

#### YAY! You now have a fully set up software environment that you can modify!! 

If you come across extra software in the course that wasn't installed via the YAML file you can use the `mamba install` command to add the software to your existing environment - or if you would like to test some new software out you can create a new minimal environment to test it in.

