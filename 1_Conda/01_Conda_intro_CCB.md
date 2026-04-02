Software Management with Conda 
=========================================

This workshop material was created by *Sebastian Luna Valero*, *Charlie George*, *Lena Morrill Gavarró*, *David Sims*, *Kevin Rue-Albrecht*, and *Mary Thompson*.

For more help using Conda please see:

[Conda documentation](https://docs.conda.io/projects/conda/en/stable/) -  comprehensive and detailed tutorials

## Conda

#### What is Conda? 

_Conda_ is a package manager.
A package manager is a type of software that allows you to easily search for software and install it without having to worry about installing all of the correct dependencies, the pain of having to match up correct versions, etc.
Lots of package management systems are language or system specific (e.g., Apple App Store, pip for python packages, CRAN and Bioconductor for R packages). In contrast, _Conda_ can be used to install software written in different languages in the same environment and can find the correct packages for your operating system (e.g., Linux, Mac, Windows). _Conda_ is easy to use and has been widely adopted in scientific computing.

Another benefit of using _Conda_ is that it allows you to organise your software in a similar way that you would organise your data and analysis code. When you use _Conda_, you create a _Conda_ "environment" that contains all the software packages that you need to do an analysis. It is common practice to make a different _Conda_ environment for each project (or sometimes multiple conda environments for more complex projects). Making different _Conda_ enviroments for different projects helps you organise your analysis and prevents compatibility issues (for example, you might need to use a package that requires Python 3.12+ for one project but need to use a different package that requires Python ≤3.8 for another project). Note that although _Conda_ is good at resolving dependencies between different software packages, if you try to install a large number of packages in the same environment, you may eventually run into dependency conflicts and then need to create multiple environments instead of one large environment for your project.

#### Conda vs. Anaconda vs. Miniforge

_Conda_ is the package manager. It can be used from the command line to create new environments and install packages.

_Anaconda_ is a software distriubtion that includes the _Conda_ package manager, as well as hundreds of data science packages. _Anaconda_ comes with a graphical user interface so you can install packages and environments interactively. We do not recommend installing _Anaconda_ on remote servers, but you may wish to install _Anaconda_ on your own laptop.

_Miniconda_ and _Miniforge_ are minimal installers for the _Conda_ package manager and its dependencies. These are the ones that we would recommend using on remote servers. We will be using _Miniforge_ for the course, which is maintained by the open source conda-forge community and is configured to use conda-forge as its default package channel (more on channels later). After you install _Miniforge_, it creates a `base` environment which contains `conda` itself and the minimal number of packages that enable it to run.

You might also come across _Mamba_. _Mamba_ is a re-implemenation of the original _Conda_ package manager in C++ that was significantly faster at resolving dependencies than _Conda_ (which was originally completely Python-based). Many people switched to using _Mamba_ for the improved performance. However, the _Mamba_ dependency solver was incorporated into the _Conda_ package manager in 2023 and its performance is now similar to that of _Mamba_.

## Section 1: Installing Conda

Now, we want to set up a software environment for all the software that we will be using on the course.
To do this, we must first install _Conda_ before moving on to install all the bioinformatics software we will need. 

Let's log into the `obds` server using `ssh` (remember to turn on OpenVPN).

#### 1) Log into the cluster using `ssh`: 

```bash
ssh obds
```

#### 2) Installing Conda

Let's create a new directory for the Conda installation.
As in the rest of the course, you will be working under the directory `/project/$USER/`.
Remember that `$USER` is an environment variable that automatically resolves to your own username which is your SSO, but you can also explicitly replace `$USER` by your SSO in any of the commands, e.g. `cd /project/abcd1324/`.

```bash
cd /project/$USER/
mkdir conda_installation
cd conda_installation
```   

Now we have made a directory for it, let's get a copy of the miniForge installation script:

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

**NOTE:** If you are installing software on Windows or Mac computers, your will need to download the appropriate installation script for your specific operating system (see <https://conda-forge.org/download/> for the correct download url to use).
The command above automatically detects the right system and type of CPU architecture on our Linux system using the `uname` and `uname -m` commands, but might not work for certain operating systems or CPUs.

We recommend downloading the latest version of the install script unless there are known issues with it.

The downloaded script will download Conda and preconfigure it to use the `conda-forge` channel (we will adjust this configuration later).

#### 3) Run the installation script

Now let's run the install script to install Conda.

```bash
bash Miniforge3-$(uname)-$(uname -m).sh -b -p conda
```

`-b` tells the installation script to run without prompts and not to modify your `.bashrc` or `.bash_profile` file (b stands for "batch mode").

`-p` sets the path where you want conda to be installed.
This can be an absolute or relative path.
In this example, the command will create a `conda` directory in the working directory, and install everything within it.

**NOTE:** Again, if you are installing on your own MacOS or Windows computer, the above command might not work.
You might need to adjust the filename of the Miniforge script for the correct operating system and/or CPU architecture (i.e., replace the `$(uname)` and/or `$(uname -m)`).
    
#### 4) Activate Conda (for this session)

Let's tell terminal where to find the Conda software, by adding its location to our $PATH variable.

```
# let's check where we have installed it to help us with the next command
pwd 

# Activate conda installation - by sourcing the conda.sh script 
# we will need the full path to be correct - use tab autocompletion to help avoid errors
source /project/$USER/conda_installation/conda/etc/profile.d/conda.sh

# Activate base environment to move into the default conda software environment
conda activate base
```

After the last command above, you should see `(base)` has appeared at the beginning of your prompt - e.g `(base) olin0164@obds:/project/abcd1234/conda_installation`

The 'base' environment is the name of the the default Conda environment created when you install Conda.
It contains Conda, Python, and several essential Python packages.

#### 5) Test your source command has worked by trying:

```bash
which conda
conda --help 
```

#### 6) Add aliases to activate Conda more easily in new Bash sessions

Let's add the `source` and `conda activate base` commands from the previous section to our `~/.bash_aliases` files, so that we can activate Conda easily when we log onto the server
    
Copy your `source` commands from step 4 above paste into the `.bash_aliases` file in your home directory.

```bash
# open your ~/.bash_aliases in nano 
nano ~/.bash_aliases 
```

Then, paste the following lines in the file, in the editor.

```bash
# Create an alias to load conda
alias load_conda='source /project/$USER/conda_installation/conda/etc/profile.d/conda.sh && conda activate base'
```

**Note:** It's good practice to add some comment lines (lines starting with a `#`) above the commands to remind us what they do, for future reference.

Close and save your `.bash_aliases` (`Control-X`, `Y`, `Return`).

## Section 2: Using Conda

#### 1) Help pages

To view the Conda help pages in a terminal, type:

```bash
conda --help
```

#### 2) Installation details

To get information about your current installation, type:

```bash
conda info
```

#### 3) Channels configuration

We can use _Conda_ to search for software packages to install.
However in order to find packages, _Conda_ needs to know which online websites it can search for them -- those are called 'channels'.

Now, let us add appropriate channels from where we know we can get all the software we need (and trust).

The order that these channels are specified is important!
When suitable packages are available from multiple channels, channels earlier in the list will be prioritised.

Let's look at what channels are currently configured with our _Conda_ installation:

```bash
conda config --show channels
```

We see that conda-forge is already in the list of channels. That's because we used _Miniforge_ to install _Conda_. Run the commands below to add both the conda-forge and bioconda channels. Run the commands in the order as shown, which will put the conda-forge channel at higher priority than the bioconda channel, which is the current recommended practice (see [Bioconda documentation](https://bioconda.github.io/)).

```bash
conda config --add channels conda-forge
conda config --add channels bioconda
```

*Note: MacOS users may have problems copying and pasting the config commands above, with strange error messages.
If that's the case, please enter these commands manually and try again.*

We have added 2 channels here:  

- `conda-forge`: this channel contains a wide variety of packages that have been packaged by diverse people in the programming/computational community.
- `bioconda`: this contains biology-oriented programs that have been packaged by diverse people in the computational biology community.
  
#### 4) Updated installation details

Check that these channels have been added to your conda installation with:

```bash
conda config --show channels
```

In the list of channels, you should see first `conda-forge` and then `bioconda`.

#### 5) Installed packages

List currently installed packages with:

```bash
conda list
```

#### 6) Check for updates

Check whether a new version is available for any of the installed packages:

```bash
conda update --all
```

As you have just adjusted the list of channels, it is likely that several packages will be upgraded or downgraded at this stage, and some new packages may be added.
Please accept the changes by typing `y` at the prompt.

## Section 3: Conda environments

### Environment 'peaktools_env'

So far we have been working with the default environment (base).
However, _Conda_ environments provide a great way to isolate and manage environments to develop and test new software, or install different pieces of software with conflicting dependencies.
Environments are also useful to export and share reproducible environments with others. 

We will first create a environment specifically for some pieces of bioinformatics software that we want to test later in the course. We will install them in their own enviroment so that we can test them out without the risk of disrupting our other packages/tools in our main software environment by forcing them to change version or use different versions of python. 

#### 1) Help pages

In order to get help related to Conda environments, type:

```bash
conda env -h
```

#### 2) List existing environments

To get a list of existing environments, type:

```bash
conda env list
```

#### 3) Sub-commands for environments

It is also possible to get specific help and examples of a subcommand with:

```bash
conda env list -h
```

#### 4) Create a new environment

We are going to create a new environment that we will call `peaktools` and in which we will install some command line tools for the analysis of ChIP-seq & ATAC-seq data, including the peakcaller _MACS2_ and the package _deepTools_.
This is a set of bioinformatics tools that comes in handy for creating genome browser tracks and also looking at peaks identified in ChIP-seq and ATAC-seq data.

First let's check what environments we have: 

```bash
conda env list
```

Now let's create a our new enviroment: 

```bash
conda create -n peaktools_env
```
    
Check your list of environments again, to confirm that the new environment was indeed created:

```bash
conda env list
```

#### 5) Activate an environment

To use software installed in an environment, you need to first 'activate' the environment with `conda activate` followed by the name of the environment.

```bash
conda activate peaktools_env
```

#### 6) Install packages in the active environment

Now that you are in the `peaktools_env` environment, you can search channels and install packages with the following commands:

```bash
# check if a package is already installed
conda list deeptools

# search available versions of a package
conda search deeptools

# install a package
conda install deeptools
# type 'Y' at the prompt to confirm the installation

# check that the installed package is available on the PATH
which deeptools
```

Note that if you don't specify a specific version for the package, the latest one available will be installed.
However, you can also ask for a specific version of a by specifying the version number e.g.:

```bash
# feel free to run the command but please type 'n' to avoid installing that version
conda install deeptools==3.4.1
```

You can also install multiple packages at the same time e.g. `samtools` & `bedtools`**

```bash
# to install packages individually (don't run this)
conda install samtools
conda install bedtools

# or to install both in a single command (run this instead)
conda install samtools bedtools
# type 'Y' at the prompt to confirm the installation
```

#### 7) Updated list of installed packages

Now double-check that the packages have been installed with:

```bash
conda list
```

#### 8) Dry-run commands


It is also possible to see what would happen if you installed a package without actually installing it (also known as a dry run) with the option `--dry-run`, for instance:

```bash
conda install multiqc --dry-run
```

#### 9) Searching packages online

In addition to the `conda search <package>` command, you can also visit the following websites to check for available conda packages:

- <https://anaconda.org/bioconda/repo/>
- <https://conda-forge.org/feedstocks/>

This is often a more comfortable way of searching for packages if you are unsure of the exact spelling of their name.

#### 10) Remove a package and its dependencies

Conda also makes it easy to remove packages and their dependencies.
For instance, let's remove the `samtools` package:

```bash
conda remove samtools
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
conda deactivate
# you should now be in the base environment
# the following command simultaneously creates an environment and installs packages
conda create -n genomics_tools_env samtools bedtools
# type 'Y' to approve the installation
```

#### 2) Activate the environment and test the software

Again, to use the tools in this environment, you must first activate the environment:

```bash
# activate environment
conda activate genomics_tools_env
# check that the desired software works
samtools --help
```

#### 10) Remove the environment

Let's pretend we've tested the tools in the `genomics_tools_env` and we have decided not to use the environment at all for our analysis.
Conda makes it really easy to delete environments cleanly.

```bash
# First deactivate the environment
conda deactivate

# remove the environment
conda remove --name genomics_tools_env --all

# Check your list of environments
conda env list
```

Now that we have had some practice managing environments, let us create an environment that will contain the software that we will use for the lessons delivered over the next couple of days.

While it is possible and really handy to add Conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with R packages if you choose to install R and R packages as Conda packages).
Specifically, dependencies in the environment grow in complexity as new packages are added, and you might be forced to upgrade or downgrade previously installed packages when you install new packages, to meet their requirements.

If you are setting up a new software environment for a project, it is advisable to think about the main software packages you plan to use in your analysis at the beginning of the project, and list those package names (and versions, ideally) in a suitably formatted YAML file (more on that later when we come to talk about 'exporting' environments).
This YAML file makes it easier for you and colleagues to review that list of packages at a glance, and can also be passed to `conda` commands that can recreate the environment reproducibly.

### Environment #3 (environment for the course)

#### Bioinformatics software

We are about to create a new environment that contains the following bioinformatics tools:
  
- fastqc (QC of FASTQ raw sequence files)
- multiqc (collects summary statistics from other bioinformatics programs)
- hisat2 (quick read aligner (mapper) for spliced sequencing reads)
- samtools (manipulates BAM/SAM alignment files)
- subread (counting of reads in features)
- kallisto (alignment-free RNA quantification tool)

#### 1) Get a copy of the environment YAML file

Copy this file `/project/shared/linux/3_conda/obds-rnaseq.yml` to your `/project/$USER/conda_installation` directory.
This file contains all the details necessary to create the next environment.

#### 2) Inspect the YAML file

Have a look inside the `obds-rnaseq.yml` file using the `less` command:

```bash
less obds-rnaseq.yml
```

Pay particular attention to the organisation and formatting of the file.
You will find a section listing channels, and another section (called 'dependencies') listing package names.
Notice that you do not need to specify a version for all (or any) of the packages; Conda will work out the versions of packages compatible with each other and fetch the latest version of each package that resolves to a working environment.

The beauty of this YAML file is that you can edit it (using `nano`, for instance) to add or remove packages at any time.
Editing the file will not update any environment that you created from it, but will affect any environment that you create from it in the future.
    
#### 3) Create the environment

Create a new environment using the `obds-rnaseq.yml` file as follows:

```bash
conda env create -f obds-rnaseq.yml
```

If you wanted, you could give your environment a name of your choice (e.g. `alternative_name_env`) using the option `-n`.
By default, the command looks for the keyword `name:` in the file, and uses the value in that field.
Please do not run the line below, but keep it for future reference.

```bash
# do not run this
conda env create -n alternative_name_env -f obds-rnaseq.yml
```

#### 4) Activate the environment

```bash
conda activate obds-rnaseq
```

#### 5) Check the version of Python

You can check which version of Python was installed in the environment as follows:

```bash
python --version
```

This is an important piece of information to keep in mind, as some bioinformatics tools still require Python 2.

#### 6) List installed packages

List all the packages in this environment as follows:

```bash
conda list
```

#### 7) Export the environment to the terminal

It is possible to export a thorough description of a Conda environment, either for the record or for recreating reproducibly at a later date or on another computer.

```bash
conda env export -n obds-rnaseq
```

Note that the command prints the information in the YAML format, and that the information includes every package in the environment, including dependencies that were not explicitly listed in the YAML file that you used to create the environment.

#### 8) Export the environment to a YAML file

You can redirect the output of the previous command to a file, to keep that file and potentially share it with others, for recreating the environment elsewhere.

Given that the information is returned in YAML format, we traditionally name the file with the extensions `.yml` or `.yaml`.

```bash
conda env export -n obds-rnaseq > my_obds_environment.yml
```

Note that when you export the active environment, you do not need to specify its name via the `-n` option:

```bash
conda env export > my_obds_environment.yml
```

#### 9) Automatically activate the environment

For the purpose of the course, it is convenient -- but not mandatory -- to configure your OBDS account to automatically activate this last environment as soon as you log into your account; it just saves you a couple of commands each time you log in.

Open your `~/.bash_aliases` file as follows:

```bash
nano ~/.bash_aliases
```

Then, at the end of the line where we previously added `alias load_conda` earlier in this tutorial,
add `&& conda activate obds-rnaseq` at the end.
This will activate the environment when you execute the alias.

Note that we always want to activate the `base` environment first and then activate the environment of interest, as this then allows you to use the `which` command to get the conda path.
It may seem overkill at this point, but this is useful later when writing pipelines.

The line in your `~/.bash_aliases` should now look like this:

```bash
alias load_conda='source /project/$USER/conda_installation/conda/etc/profile.d/conda.sh && conda activate base && conda activate obds-rnaseq'
```

#### Congratulations! You now have a fully set up software environment for the following lessons!
