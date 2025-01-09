Software Management with Mamba and Conda 
=========================================

This workshop material was created by *Sebastian Luna Valero*, *Charlie George*, *Lena Morrill Gavarró*, *David Sims*, and *Kevin Rue-Albrecht*.

For more help using Conda/Mamba please see:

- [Mamba documentation](https://mamba.readthedocs.io/en/latest/user_guide/mamba.html) - this is pretty brief!
- [Conda documentation](https://docs.conda.io/projects/conda/en/stable/) -  more comprehensive and more detailed tutorials.

## Mamba vs Conda

#### What is Conda or Anaconda? 

_Conda_ and _Anaconda_ are package management systems.
It allows you to easily search for software and install it without having to worry about having to install all the correct dependencies, the pain of having to match up correct versions, etc.
Whilst lots of package management systems are language or system specific (e.g., Apple App Store, pip for python packages, CRAN and Bioconductor for R packages), _Conda_ and _Anaconda_ can be used to install a huge number of software packages across multiple operating systems (e.g., Linux, Mac, Windows).
They make it easy to install software onto any system and it's often used in introductory courses to set up your software environments so you might have previously installed it without realising.

_Conda_ is the small lightweight command line tool that allows you to install packages easily, when you install it, it creates a `base` environment which contains `conda` itself and the minimal number of packages that enables it to run.

_Anaconda_ is a much larger installation that installs the `conda` command line tool and many other Python data science packages.
_Anaconda_ comes with a graphical user interface so you can install packages and environments interactively.
We recommend minimally installing the key packages `conda` and `mamba` on remote servers, but you may wich to install _Anaconda_ on your own laptop.

#### What is Mamba?

As _Conda_ became increasingly popular, more packages were added to its repositories and Conda became slower to search through them and their many versions to solve environments.
_Mamba_ was written in C++ as a reimplementation of Conda to improve the performance.
It contains all of the same functionality as _Conda_, but resolves and install environments much faster, making it now the preferred option.

#### What is MicroMamba?

_MicroMamba_ is "a tiny version of the Mamba package manager".
It has its own command line interface and does not come with a default Python version or need of a `base` environment.
It supports a subset of the commands found in _Mamba_ and _Conda_, and its documentation is still being developed.
This makes it a bit more challenging to learn, so at this time we'll stick with the Conda/Mamba installation process below, using _miniForge_.

#### Which are we using and why? 

We are going to install Conda and Mamba together in a single step using the `miniForge` script.
We will use it mainly via the `mamba` commands.

#### Why do you still refer to Conda if we are not using it? 

_Mamba_ is based on _Conda_ and actually at this point the _Conda_ documentation and online help and troubleshooting is much more comprehensive than the _Mamba_ documentation.
It is often more efficient to Google your issues using the "conda" keyword even if you actually use "mamba" and -- if you find a Conda command as a online suggestion -- you can generally replace `conda` with `mamba` in that command (do critically read and analyse any command you find online before runnning it yourself!).
_Mamba_ also uses the same _Conda_ channels and _Anaconda_ repository to find all its packages, so that is another reason to remember that they are related in this way.

## Section 1: Installing Conda/Mamba

Now, we want to set up a software environment for all the programs we will be using on the course.
To do this, we must first install _Mamba_ before moving on to install all the bioinformatics software we will need. 

Let's log into the `obds` server using `ssh` (remember to turn on OpenVPN).

#### 1) Log into the cluster using `ssh`: 

```bash
ssh obds
```

#### 2) Installing Miniforge - Conda and Mamba in one easy step

Let's create a new directory for the Conda/Mamba installation.
As in the rest of the course, you will be working under the directory `/project/$USER/`.
Remember that `$USER` is an environment variable that automatically resolves to your own username which is your SSO, but you can also explicitly replace `$USER` by your SSO in any of the commands, e.g. `cd /project/abcd1324/`.

```bash
cd /project/$USER/
mkdir mamba_installation
cd mamba_installation
```   

Now we have made a directory for it, let's get a copy of the miniForge installation script:

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

**NOTE:** If you are installing software on Windows or Mac computers, your will need to download the appropriate installation script for your specific operating system (see <https://github.com/conda-forge/miniforge#mambaforge> for the correct download url to use).
The command above automatically detects the right system and type of CPU architecture on our Linux system using the `uname` and `uname -m` commands, but might not work for certain operating systems or CPUs.

We recommend downloading the latest version of the install script unless there are known issues with it.

The downloaded script will download Conda and Mamba and preconfigure it to use the `conda-forge` channel (we will adjust this configuration later).

#### 3) Now let's run the install script to install Conda**

```bash
bash Miniforge3-$(uname)-$(uname -m).sh -b -p conda
```

`-b` tells the installation script to run without prompts and not to modify your `.bashrc` or `.bash_profile` file (b stands for "batch mode").

`-p` sets the path where you want conda to be installed.
This can be an absolute or relative path.
In this example, the command will create a `conda` directory in the working directory, and install everything within it.

**NOTE:** Again, if you are installing on your own MacOS or Windows computer, the above command might not work.
You might need to adjust the filename of the Miniforge script for the correct operating system and/or CPU architecture (i.e., replace the `$(uname)` and/or `$(uname -m)`).
    
#### 4) Let's tell terminal where to find the Conda software, by adding its location to our $PATH variable**

```
# let's check where we have installed it to help us with the next command
pwd 

# Activate conda installation - by sourcing the conda.sh script 
# we will need the full path to be correct - use tab autocompletion to help avoid errors
source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh

# Activate mamba installation - by sourcing the mamba.sh script 
source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh

# Activate base environment to move into the default conda/mamba software environment
mamba activate base
```

After the last command above, you should see `(base)` has appeared at the beginning of your prompt - e.g `(base) olin0164@obds:/project/abcd1234/mamba_installation`

The 'base' environment is the name of the the default Conda environment created when you install Conda.
It contains Conda, Mamba, Python, and several essential Python packages.

#### 5) Test your source command has worked by trying:**

```bash
which conda
which mamba 
conda --help 
mamba --help 
```

You should be able to see the conda and mamba help menus are the same!


#### 6) Add aliases to activate Conda more easily in new Bash sessions

Let's add the `source` and `mamba activate` commands from the previous section to our `~/.bash_aliases` files, so that we can activate Conda easily when we log onto the server
    
Copy your `source` commands from step 4 above paste into the `.bash_aliases` file in your home directory.

```bash
# open your ~/.bash_aliases in nano 
nano ~/.bash_aliases 
```

Then, paste the following lines in the file, in the editor.

```bash
# Create an alias to load conda/mamba
alias load_mamba='source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base'
```

**Note:** It's good practice to add some comment lines (lines starting with a `#`) above the commands to remind us what they do, for future reference.

Close and save your `.bash_aliases` (`Control-X`, `Y`, `Return`).

## Section 2: Using Mamba

**1) To get help for mamba, type:**

```bash
mamba --help
```

**2) To get information about your current install, type:**

```bash
mamba info
```

**3) We can use mamba to search for software packages to install, however in order to find the packages, mamba needs the address of certain sites on the internet to look at - these are called 'channels'. Let us add appropriate channels to get all the software we need (and trust). The order that these channels are specified is important!** As we used mamba forge to install mamba these should already be configured in the right order just in case but we will go through these steps just in case. NOTE that this is one of the only times we use the `conda` command instead of `mamba`

```bash
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```
*Note: Mac users may have problems copying and pasting the config commands above, with strange error messages. If that's the case, please enter these commands manually and try again.*

We have added 3 channels here:  
- defaults channel: this contains major common software that has been packaged for conda/mamba by people at conda and anaconda themselves  
- conda-forge: this contains lots of general programming packages that have been packaged for conda/mamba by people in the programming/computational community  
- bioconda: this contains biology-specific programmes that have been packaged for conda/mamba by people in the computational biology community  
  
**4) Check that these channels have been added to your conda installation with:**

```bash
mamba info
```

**5) List currently installed packages**

```bash
mamba list
```

**6) Check whether your packages are up-to-date**

```bash
mamba update --all
```

As you have added new channels it is likely that several packages will be upgraded or downgraded at this stage, and some new packages may be added. Please accept the changes by typing `y` at the prompt.

## Section 3: Conda environments

### Environment #1

So far we have been working with the default (base) environment. However, Conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) environments with others (reproducible science). 

We will first create a environment specifically for some pieces of bioinformatic software that we want to test later in the course, we install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version or use different versions of python. 

**1) In order to get help about conda environments, do:**

```bash
mamba env -h 
```

**2) To get a list of existing environments, type:**

```bash
mamba env list
```

**3) It is also possible to get specific help and examples of a subcommand:**

```bash
mamba env list -h
```

**4) We are going to create an environment we will call `peaktools` for some ChIP-Seq & ATAC-Seq tools including the peakcaller `MACS2` and the package `deepTools`: this is a set of bioinformatic tools that come in handy for creating genome browser tracks and also looking at peak data from ChIP-Seq and ATAC-Seq files**

First let's check what environments we have: 

```bash
mamba env list
```

Now let's create a our new enviroment: 

```bash
mamba create -n peaktools_env
```

*Note that you could also type `conda create -n peaktools_env` here to do exactly the same thing - but we are going to use mamba to do 'search', 'install' and 'create' commands as it is much quicker* 
    
Check it your environment list again:

```bash
mamba env list
```

**5) To move into the `peaktools_env` environment and use the tools, you need to 'activate' it**

```bash
mamba activate peaktools_env
```

**6) Now you are in the peaktools_env you can search and install packages**

```bash
# check if you already have deeptools installed 
mamba list deeptools

# search versions available to install
mamba search deeptools 

# install deeptools
mamba install deeptools 

# check you have installed it
which deeptools 
```

If you don't specify a version, the latest available one will be installed. However, you can also ask for a specific version of a by specifying the version number e.g.:

```bash
mamba install deeptools=2.1.3 
```

You can also install multiple packages at the same time e.g. `samtools` & `bedtools`**

```bash
# you can install packages individually (don't run this its just an example)
mamba install samtools
mamba install bedtools

# or in a single command (run this instead)
mamba install samtools bedtools
```

**7) Now double-check that the packages have been installed**

```bash
mamba list
```

**8) It is also possible to see what would happen when you install a package without actually installing it (also known as a dry run)**

```bash
mamba install multiqc --dry-run
```

**9) In addition to the `mamba search <name>` command, you can also visit the following websites to check for available conda/mamba packages - this is a much easier way of finding packages if you are unsure how they might be named in conda/mamba - remember just replace `conda` with `mamba` in the command and leave out the channel e.g instead of `conda install bioconda::fastqc` type `mamba install fastqc`  :**

- https://anaconda.org/bioconda/repo/
- https://conda-forge.org/feedstocks/

**10) Conda/mamba also makes it easy to remove packages and their dependencies - let's remove the samtools package**

```bash
mamba remove samtools 
```

**11) A good way of checking that tools work is by accessing their `--help` functions**

```bash
bedtools --help
deeptools --help 
```

### Environment #2

**1) Instead of creating an environment and installing the packages in separate steps you can combine these steps by specifying the packages in your `create` command. We will do this to create a `genomics_tools_env` were we will install two programs used to manipulate genomic files `samtools` and `bedtools` as an example**

```bash
# First move out of the environment by `deactivating it` 
mamba deactivate
# you should now be in (base)
mamba create -n test_tools_env samtools bedtools
```

**2) Again to use the tools in this environment you need to go into it by 'activating' it**

```bash
# activate environment
mamba activate genomics_tools_env
# check the software works
samtools --help
```

**10) Let's pretend we've tested our tools in our `genomics_tools_env` and we have decided not to use them in our analysis. Conda makes it really easy to delete environments cleanly**

```bash
# First move out of the environment by `deactivating it`
mamba deactivate

# remove the environment 
mamba remove --name genomics_tools_env --all

# Check your environments list
mamba env list
```

Now that we have had some practice setting up mamba environments, we want to create an environment for the Linux course that will contain the software that we will use in the taught lectures/workshops over the next couple of days.

Whilst it is possible and really handy to add conda/mamba packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages if you choose to install r and its associated packages via conda/mamba) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up a new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an `environment.yml` file, as this makes it easier for Mamba to workout what dependencies will be best for all of the software right from the start. 

### Environment #3 (environment for the course)

#### Bioinformatics software
  
- fastqc (QC of FASTQ raw sequence files)
- multiqc (collects summary statistics from other bioinformatic programs)
- hisat2 (quick read aligner (mapper) for spliced sequencing reads)
- samtools (manipulate BAM/SAM alignment files)
- subread (counting of reads in features)
- kallisto (alignment-free RNA quantification tool)

**1) In the `/project/shared/1_linux/3_conda/` directory there is a file called `obds-rnaseq.yml`. Copy this file to your `/project/$USER/mamba_installation` directory, we will use this file to create a new conda environment**

**2) Have a look inside the obds-rnaseq.yml file**

```bash
less obds-rnaseq.yml
```

*Have a look at the formating of the packages and the channels. Note that you do not have to specify the versions of all the software packages - if you leave them blank, conda will work this out for you*

*Note that if there were additional packages you wanted to install you would just add these to the yml file using `nano`, making sure the formatting is the same as the other packages.*
    
**3) Create a new environment using the obds-rnaseq.yml file**

```bash
mamba env create -f obds-rnaseq.yml 
```

If you want, you can give your environment a name of your choice (e.g. `alternative_name_env`) using the -n option (by default it will use the name specified at the top of the yml file, which is `obds_env`). You do not have to run the line below, but you can use it for reference (although it is clearer to specify the env name in the yaml file).

```bash
mamba env create -n alternative_name_env -f obds-rnaseq.yml
```

**4) Activate your new conda environment**

```bash
mamba activate obds-rnaseq
# (or replace obds-rnaseq with the name of your python environment)
```

**5) Check which version of python you have in this environment**

```bash
python --version
```

**6) List all the packages in this environment**

```bash
mamba list
```

**7) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export conda environments:**

```bash
mamba env export -n obds-rnaseq
```

**8) You can redirect the output to a file that you can share and recreate your environment from**

```bash
mamba env export -n obds-rnaseq > my_obds_environment.yml
```

**9) Final steps - update your `.bash_aliases` to activate your obds enviroment automatically when you load a terminal**

```bash
# open your .bash_aliases
nano ~/.bash_aliases
```

Then on the line where we added `alias load_mamba` at the beginning of this tutorial add `&& mamba activate obds-rnaseq` at the end to activate your obds environment. *Note we always want to conda activate base first and then activate your environment of interest as this then allows you to use the `which` command to get the conda path - this is useful later in pipelines*

```bash
alias load_mamba='source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base && mamba activate obds-rnaseq' 
```

#### YAY! You now have a fully set up software environment that you can modify!

If you come across extra software in the course that wasn't installed via the YAML file you can use the `mamba install` command to add the software to your existing environment - or if you would like to test some new software out you can create a new minimal environment to test it in.
