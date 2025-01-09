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

#### 1) Help pages

To view the Mamba help pages in a terminal, type:

```bash
mamba --help
```

#### 2) Installation details

To get information about your current installation, type:

```bash
mamba info
```

#### 3) Channels configuration

We can use _Mamba_ to search for software packages to install.
However in order to find packages, _Mamba_ needs to know which online websites it can search for them -- those are called 'channels'.

Now, let us add appropriate channels from where we know we can get all the software we need (and trust).

The order that these channels are specified is important!
When suitable packages are available from multiple channels, channels earlier in the list will be prioritised.
As we used _Miniforge_ to install _Mamba_, these channels should already be configured in the right order for us, but we will go through these steps just in case.
Note that this is one of the few times we use the `conda` command instead of `mamba` today.

```bash
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```

*Note: MacOS users may have problems copying and pasting the config commands above, with strange error messages.
If that's the case, please enter these commands manually and try again.*

We have added 3 channels here:  

- `defaults`: this channel contains widely used software that has been packaged by the Conda and Anaconda teams themselves.
- `conda-forge`: this channel contains a wide variety of packages that have been packaged by diverse people in the programming/computational community.
- `bioconda`: this contains biology-oriented programs that have been packaged by diverse people in the computational biology community.
  
#### 4) Updated installation details

Check that these channels have been added to your conda installation with:

```bash
mamba info
```

In the list of channels, you should see first `bioconda`, then `conda-forge`, then `main` and finally `r` (the last two are the default channels pointing to the Anaconda repository).

#### 5) Installed packages

List currently installed packages with:

```bash
mamba list
```

#### 6) Check for updates

Check whether a new version is available for any of the installed packages:

```bash
mamba update --all
```

As you have just adjusted the list of channels, it is likely that several packages will be upgraded or downgraded at this stage, and some new packages may be added.
Please accept the changes by typing `y` at the prompt.

## Section 3: Conda environments

### Environment 'peaktools_env'

So far we have been working with the default environment (base).
However, _Conda_ environments provide a great way to isolate and manage environments to develop and test new software, or install different pieces of software with conflicting dependencies.
Environments are also useful to export and share reproducible environments with others. 

We will first create a environment specifically for some pieces of bioinformatic software that we want to test later in the course, we install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version or use different versions of python. 

#### 1) Help pages

In order to get help related to Conda environments, type:

```bash
mamba env -h
```

#### 2) List existing environments

To get a list of existing environments, type:

```bash
mamba env list
```

#### 3) Sub-commands for environments

It is also possible to get specific help and examples of a subcommand with:

```bash
mamba env list -h
```

#### 4) Create a new environment

We are going to create a new environment that we will call `peaktools` and in which we will install some command line tools for the analysis of ChIP-seq & ATAC-seq data, including the peakcaller _MACS2_ and the package _deepTools_.
This is a set of bioinformatic tools that comes in handy for creating genome browser tracks and also looking at peaks identified in ChIP-seq and ATAC-seq files data.

First let's check what environments we have: 

```bash
mamba env list
```

Now let's create a our new enviroment: 

```bash
mamba create -n peaktools_env
```
    
Check your list of environments again, to confirm that the new environment was indeed created:

```bash
mamba env list
```

#### 5) Activate an environment

To use software installed in an environment, you need to first 'activate' the environment with `mamba activate` followed by the name of the environment.

```bash
mamba activate peaktools_env
```

#### 6) Install packages in the active environment

Now that you are in the `peaktools_env` environment, you can search channels and install packages with the following commands:

```bash
# check if a package is already installed
mamba list deeptools

# search available versions of a package
mamba search deeptools

# install a package
mamba install deeptools
# type 'Y' at the prompt to confirm the installation

# check that the installed package is available on the PATH
which deeptools
```

Note that if you don't specify a specific version for the package, the latest one available will be installed.
However, you can also ask for a specific version of a by specifying the version number e.g.:

```bash
mamba install deeptools==2.3.1
# feel free to run the command but please do not install that version
```

You can also install multiple packages at the same time e.g. `samtools` & `bedtools`**

```bash
# to install packages individually (don't run this)
mamba install samtools
mamba install bedtools

# or to install both in a single command (run this instead)
mamba install samtools bedtools
# type 'Y' at the prompt to confirm the installation
```

#### 7) Updated list of installed packages

Now double-check that the packages have been installed with:

```bash
mamba list
```

#### 8) Dry-run commands


It is also possible to see what would happen if you installed a package without actually installing it (also known as a dry run) with the option `--dry-run`, for instance:

```bash
mamba install multiqc --dry-run
```

#### 9) Searching packages online

In addition to the `mamba search <package>` command, you can also visit the following websites to check for available conda/mamba packages:

- <https://anaconda.org/bioconda/repo/>
- <https://conda-forge.org/feedstocks/>

This is often a more comfortable way of searching for packages if you are unsure of the exact spelling of their name.

#### 10) Remove a package and its dependencies

Mamba also makes it easy to remove packages and their dependencies.
For instance, let's remove the `samtools` package:

```bash
mamba remove samtools
```

Note that dependencies are only removed if no other package in the environment needs them too.

11) Test installed packages

A good way of checking that tools work is by accessing their help pages, e.g.:

```bash
bedtools --help
deeptools --help 
```

### Environment 'test_tools_env'

#### 1) Simultaneously create an environment and install packages

Instead of creating an environment and installing the packages in separate steps you can combine these steps by specifying the packages in the `create` command.
We will do this to create a `genomics_tools_env` environment in which we will install two programs used to manipulate genomic files: `samtools` and `bedtools`.

```bash
# First deactivate the peaktools_env environment
mamba deactivate
# you should now be in the base environment
# the following command simultaneously creates an environment and installs packages
mamba create -n genomics_tools_env samtools bedtools
# type 'Y' to approve the installation
```

#### 2) Activate the environment and test the software

Again, to use the tools in this environment, you must first activate the environment:

```bash
# activate environment
mamba activate genomics_tools_env
# check that the desired software works
samtools --help
```

#### 10) Remove the environment

Let's pretend we've tested the tools in the `genomics_tools_env` and we have decided not to use the environment at all for our analysis.
Mamba makes it really easy to delete environments cleanly.

```bash
# First deactivate the environment
mamba deactivate

# remove the environment
mamba remove --name genomics_tools_env --all

# Check your list of environments
mamba env list
```

Now that we have had some practice managing environments, let us create an environment that will contain the software that we will use for the lessons delivered over the next couple of days.

While it is possible and really handy to add Conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with R packages if you choose to install R and R packages as Conda packages).
Specifically, dependencies in the environment grow in complexity as new packages are added, and you might be forced to upgrade or downgraded previously installed packages when you install new packages, to meet their requirements.

If you are setting up a new software environment for a project, it is advisable to think about the main software packages you plan to use in your analysis at the beginning of the project, and list those package names (and versions, ideally) in a suitably formatted YAML file (more on that later when we come to talk about 'exporting' environments).
This YAML file makes it easier for you and colleagues to review that list of packages at a glance, and can also be passed to `mamba` commands that can recreate the environment reproducibly.

### Environment #3 (environment for the course)

#### Bioinformatics software

We are about to create a new environment that contains the following bioinformatics tools:
  
- fastqc (QC of FASTQ raw sequence files)
- multiqc (collects summary statistics from other bioinformatic programs)
- hisat2 (quick read aligner (mapper) for spliced sequencing reads)
- samtools (manipulate BAM/SAM alignment files)
- subread (counting of reads in features)
- kallisto (alignment-free RNA quantification tool)

#### 1) Get a copy of the environment YAML file

Copy this file `/project/shared/1_linux/3_conda/obds-rnaseq.yml` to your `/project/$USER/mamba_installation` directory.
This file contains all the details necessary to create the next environment.

#### 2) Inspect the YAML file

Have a look inside the `obds-rnaseq.yml` file using the `less` command:

```bash
less obds-rnaseq.yml
```

Pay particular attention to the organisation and formatting of the file.
You will find a section listing channels, and another section (called 'dependencies') listing package names.
Notice that you do not need to specify a version for all (or any) of the packages; Mamba will work out the versions of packages compatible with each other and fetch the latest version of each package that resolves to a working environment.

The beauty of this YAML file is that you can edit it (using `nano`, for instance) to add or remove packages at any time.
Editing the file will not update any environment that you created from it, but will affect any environment that you create from it in the future.
    
#### 3) Create the environment

Create a new environment using the `obds-rnaseq.yml` file as follows:

```bash
mamba env create -f obds-rnaseq.yml
```

If you wanted, you could give your environment a name of your choice (e.g. `alternative_name_env`) using the option `-n`.
By default, the command looks for the keyword `name:` in the file, and uses the value in that field.
Please do not run the line below, but keep it for future reference.

```bash
mamba env create -n alternative_name_env -f obds-rnaseq.yml
```

#### 4) Activate the environment

```bash
mamba activate obds-rnaseq
```

#### 5) Check the version of Python

You can check which version of Python that was installed in the environment as follows:

```bash
python --version
```

This is an important piece of information to keep in mind, as some bioinformatics tools still require Python 2.

#### 6) List installed packages

List all the packages in this environment as follows:

```bash
mamba list
```

#### 7) Export the environment to the terminal

It is possible to export a thorough description of a Conda environment, either for the record or for recreating reproducibly at a later date or on another computer.

```bash
mamba env export -n obds-rnaseq
```

Note that the command prints the information in the YAML format, and that the information includes every package in the environment, including dependencies that were not explicitly listed in the YAML file that you used to create the environment.

#### 8) Export the environment to a YAML file

You can redirect the output of the previous command to a file, to keep that file and potentially share it with others, for recreating the environment elsewhere.

Given that the information is returned in YAML format, we traditionally name the file with the extensions `.yml` or `.yaml`.

```bash
mamba env export -n obds-rnaseq > my_obds_environment.yml
```

Note that when you export the active environment, you do not need to specify its name via the `-n` option:

```bash
mamba env export > my_obds_environment.yml
```

#### 9) Automatically activate the environment

For the purpose of the course, it is convenient -- but not mandatory -- to configure your OBDS account to automatically activate this last environment as soon as you log into your account; it just saves you a couple of commands each time you log in.

Open your `~/.bash_aliases` file as follows:

```bash
nano ~/.bash_aliases
```

Then, at the end of the line where we previously added `alias load_mamba` earlier in this tutorial,
add `&& mamba activate obds-rnaseq` at the end.
This will activate the environment when you execute the alias.

Note that we always want to activate the `base` environment first and then activate the environment of interest, as this then allows you to use the `which` command to get the conda path.
It may seem overkill at this point, but this is useful later when writing pipelines.

The line in your `~/.bash_aliases` should now look like this:

```bash
alias load_mamba='source /project/$USER/mamba_installation/conda/etc/profile.d/conda.sh && source /project/$USER/mamba_installation/conda/etc/profile.d/mamba.sh && mamba activate base && mamba activate obds-rnaseq' 
```

#### Congratulations! You now have a fully set up software environment for the following lessons!
