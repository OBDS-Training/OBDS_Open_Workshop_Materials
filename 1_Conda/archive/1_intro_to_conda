# Introduction to Conda 
-----------------------

This workshop material was created by Sebastian Luna Valero with moifications by Charlie George 

This workshop has been split into two parts:

part 1: introduction to conda (Sections 1, 2 and 3), and
part 2: building packages with conda (Section 4).
For more help about using conda, please see:

https://conda.io/docs/

## Section 1: Install conda

Installing things can involve alot of reading/writing of files and therefore can be memory intensive
so ideally we want to do this on the cluster. lets sign into the head node (e.g. deva, klyn or cgath1) 
and log into a compute node on the cluster using. 

1) log into cluster using ssh 

``` $ ssh -X <username>@<headnode.address.ox.ac.uk>```  (replace <username> and <headnode.address.ox.ac.uk> with appripropriate items)

2) lets move onto a compute node on the cluster 
```$ qrsh```

3) Now go to your working directory (e.g. /t1-data/user/{USER}/  if you are working on cbrg systems or /ifs/obds-training/{USER} if you are on cgat system ) and lets set up a directory for your conda installation:

``` 
$ cd /t1-data/user/{USER}/ 
$ mkdir conda
$ cd conda
```

4) Now we've made a directory for it lets get a copy of the conda install script: 

# For Linux (the cluster) use:

```
$ curl -o Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

# OS X (your macbook) use: 
```
$ curl -o Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
```

Please note if you want you can get specific versions of the conda installer from
[https://repo.continuum.io/miniconda] and to find a specific version and download like this:  

```
$ curl -o Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh
```

We always recommend downloading the latest version of the conda install script unless there are known issues with it 

5) Now lets run the install script to install conda:

$ bash Miniconda.sh -b -p obds_conda_install

6) So our terminal knows where to find the conda software we need to add this location to our $PATH variable so that we can use it:

```
# Activate conda installation
source /full/file/path/to/where/you/have/installed/obds_conda_install/etc/profile.d/conda.sh

# Activate base environment to move into the default conda software enviroment
conda activate base

```
7) test your source command has worked by trying 

```
conda --help
``` 


# Activate base environment
conda activate base

# Test
which conda
We'll see what are conda environments in a moment. The important bit here is that base is the default conda environment every time you install conda.
Section 2: Using conda
Edit
To get help, type:

conda help
To get information about your current install, type:

conda info
Let us add appropriate conda channels to get all software we need (and trust) the order is important:

conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
Mac users may have problems copying and pasting the config commands above, with strange error messages. If that's the case, please enter these commands manually and try again.
Check updated configuration with:

conda info
List currently installed packages:

conda list
Check whether your packages are up-to-date:

conda update --all
As you have added new channels it is likely that several packages will be both up and down graded at this stage, and some new packages may be added. Please accept the changes by typing y at the prompt.

Now, let us search and install a package. Our example here is Connor, a command-line tool to deduplicate bam files based on custom, inline barcoding:
https://github.com/umich-brcf-bioinf/Connor

conda search connor
Check whether or not you have it installed:

# use conda
conda list connor
# or:
which connor
Once you have found the package you are after, just need to install it by doing:

conda install connor
If you don't specify a version, the latest available one will be installed. However, you can also ask for a specific version of a package with

conda install connor=0.5.1
Now double-check that the package is available:

# use conda
conda list connor
# or:
which connor
Use your software:

connor --help
And finally you can remove it:

conda remove connor
It is also possible to see what could happen without actually performing any changes (also known as dry run):

conda install pysam --dry-run
The above command will execute all the steps to install pysam, but finally it does not do it. This is useful to check beforehand what installing a package is going to do.

In addition to the conda search <name> command, you can also visit the following websites to check for available conda packages:

http://bioconda.github.io/recipes.html
https://conda-forge.org/feedstocks/
Section 3: Conda environments
Edit
A) Setting up a new enviroment for a single program or small number of programs

So far we have been working with the (default) base environment. However, conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with anybody else (reproducible science). We are going to make 2 new enviroments - one with macs2 and python2.7 and the other will be python 3.6 and we will have all our main software. 

In order to get help about conda environments, do:

conda env -h
To get a list of existing environments, type:

conda env list
It is also possible to get specific help and examples of a subcommand:

conda env list -h
Let's now create a new environment to test the latest MACS2:

# search package
conda search macs2

# create a new conda environment with the desired packages
conda create -n macs2-env macs2

# activate new conda environment
conda activate macs2-env

# check the current active conda environment
conda env list

# check out your software has installed properly
macs2 -h

# check which version of python you have in this enviroment
python --version
Now, everything you install go to the active environment (e.g. macs2-env):

conda list
We will use this macs2 environment later in the course in a peakcalling exercise. If you had other software that depended on python 2.7 you might want to install it in this environment too. However at the moment we do not. 

For now you can go back to the base environment by doing:

conda activate base
conda env list
If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export and likewise import conda environments:

# export
conda env export -n macs2-env

# you can actually redirect the output to a file
conda env export -n macs2-env > env.yml

# see what's inside
cat env.yml

# the conda environment can now be re-created in another conda installation
conda env create -n macs2-env-copy2 -f env.yml
Lets activate the macs2-env-copy2 environment and start adding some other packages to practise how to install packages one by one.  

# activate environment
conda activate macs2-env-copy2

# lets install some more bioinformatics into the environment one by one.
# Using conda install add pandas (a python package), bedtools and samtools to the macs2-env-copy2 environment


Section 3b: Setting up the OBDS Training course environment
Edit
Now we've had some practise setting up conda environments we want to create a python 3.6 environment for the OBDS training course that will contain the software that we will use in the taught lectures/workshops over the next 6 weeks.

Whilst its possible and really handy to add conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an  environment.yml file (like we used above to create the macs2-env-copy2 environment) as this makes it easier for conda to workout what dependencies will be best for most of the major software right from the start. 

We want to create a new enviroment called obds_env to do this we will create a obds_main_environment.yml file and edit the dependencies list to include the following packages:

# Python & associated libraries

Python - version 3.6 (you should specify version number in the yaml file)
numpy  - (a python package for doing fast mathematical calculations and manipulations)
pandas - (a python package for making/using dataframes)
matplotlib - (a python package for plotting)
seaborn -  (a much prettier python package for plotting)
scipy - (a collection of python packages for data analysis, includes ipython, pandas etc)
spyder - an interactive development environment (IDE) for python similar to Rstudio 
ruffus - a python pipelining program that we will use to write pipelines
cgatcore - a library from cgat to make pipelines usable with a computer cluster
pysam - a python package for working with bam/sam alignment files 
pybedtools - a python wrapper for bedtools meaning you can use bedtools functionality in python scripts
drmaa - for the management of submitting jobs to the cluster
ggplot  - python version of ggplot
jupyter - interactive notebooks for python 
# bioinformatics software

fastqc - QC of fastq raw sequence files
multiqc - collects summary statistics from other bioinformatic programs
hisat2 - super quick read aligner (mapper) for spliced sequencing reads
bowtie2 - slower read aligner for unspliced sequencing reads
samtools - manipulate bam/sam alignment files 
picard - QC of alignment files 
subread - counting of reads in features
# R & associated packages - you might have to search some of these in conda or on the bioconda website (google it) to get the correct conda package names.

R  - note that r is called `r-base` in conda - search it and check you can find it 
rstudio - IDE for R 
tidyverse library - family of r packages that have usefull data processing functionality
deseq2 - r bioconductor statistical package for differential expression
edger - r bioconductor statistical package for differential expression
seurat - r Cran package for single cell analysis 
goseq - r bioconductor package for gene ontology analysis
gsea - r package for gene set enrichment analysis
You can use the macs2-env-copy2.yml as a template. Note that you do not have to specify the versions of all the software packages - if you leave them blank then conda will work this out for you. 

Once you have created the yaml file you might want to modify your `.bashrc` file to do the following

Point to your conda installation 
Use an alias to load your conda environments
Note we always want to conda activate base and then activate your environment of interest as this then allows you to use the




which command to get the conda path -  this is useful later on in pipelines 
Now if you come across extra software in the course that wasn't installed via the yaml file you can use the conda install command to add the software to your exisiting environment - or if you would like to test some new software out you can create a new minimal environment to test it in. 

After you have made your conda environment we can check it against a hard record of the environment we want for the course. 

Finally lets clear up a bit - we don't actually need our macs2-env-copy2 environment so we will delete this 

# remove macs2-env-copy2
conda env remove --name macs2-env-copy2

# check enviroment has been removed
conda env list
Section 4: Building conda packages
Edit
We will follow Bioconda’s setup to contribute new conda packages:
http://bioconda.github.io/contributing.html

You will need to install and configure a few things before hand so we can focus on how to write conda recipes to build packages. Please, follow Bioconda’s one-time setup (section: using a fork) before the workshop:
http://bioconda.github.io/contrib-setup.html

Sorry but at the time being the setup above only supports OS X and Linux. If you have a Windows laptop, please make sure you have access to a Linux (virtual or physical) box for the workshop.

Before the workshop you will need to:

Fork the bioconda-recipes repository on your GitHub account
Clone it on your laptop and configure the upstream repository
Install bioconda-utils
Optional: install Docker
Configure the bioconda-recipes repository
Edit
Steps:

git clone https://github.com/CGATOxford/bioconda-recipes.git
cd bioconda-recipes/
git remote add upstream https://github.com/bioconda/bioconda-recipes.git
git remote -v
git checkout master
git pull upstream master
Install bioconda-utils
Edit
Steps:

# Linux
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh -b -p /tmp/conda-workshop/conda

# OS X
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
bash Miniconda3-latest-MacOSX-x86_64.sh -b -p /tmp/conda-workshop/conda

source /tmp/conda-workshop/conda/bin/activate 
conda install pyyaml
./simulate-travis.py --bootstrap /tmp/miniconda --overwrite
Build packages
Edit
Start by activating the bioconda-utils installation:

# activate bioconda-utils
source /tmp/miniconda/bin/activate

# and go to bioconda-recipes repo:
cd bioconda-recipes
Example 1
Easy example, Python package:
https://github.com/umich-brcf-bioinf/Connor

Have a look at recipe:
https://github.com/bioconda/bioconda-recipes/tree/master/recipes/connor

Now, let's build it:

# Build it with bioconda:
./simulate-travis.py --packages connor

# Failed due to existing recipe, so force it:
./simulate-travis.py --packages connor --force

# Simulate build error with ‘conor’ instead of ‘connor’
Example 2
Easy example, Perl script:
https://github.com/MikeAxtell/ShortStack

Have a look at recipe:
https://github.com/bioconda/bioconda-recipes/tree/master/recipes/shortstack

Now, let's build it:

# Build it:
./simulate-travis.py --packages shortstack --force
Example 3
Intermediate example, Bash script:
https://github.com/telenius/NGseqBasic

Have a look at recipe:
https://github.com/bioconda/bioconda-recipes/tree/master/recipes/ngseqbasic

Now, let's build it:

# Build it:
./simulate-travis.py --packages ngseqbasic --force

# troubleshoot further:
./simulate-travis.py --packages ngseqbasic --force --loglevel=debug
Example 4
Advanced example, complex combination of code:
https://github.com/bioconda/bioconda-recipes/pull/5894

Still ongoing.

Using skeletons
Skeleton examples: valid for Python, Perl, R and Bioconductor packages. For details, see:
http://bioconda.github.io/guidelines.html

Python example: pybedtools

https://pypi.python.org/pypi/pybedtools
https://github.com/bioconda/bioconda-recipes/blob/master/recipes/pybedtools
/tmp/miniconda/bin/conda skeleton pypi pybedtools
R example: Rentrez

https://cran.r-project.org/package=rentrez
https://github.com/bioconda/bioconda-recipes/tree/master/recipes/r-rentrez
/tmp/miniconda/bin/conda skeleton cran Rentrez
Bioconductor example: Genomic Ranges

http://bioconductor.org/packages/release/bioc/html/GenomicRanges.html
https://github.com/bioconda/bioconda-recipes/tree/master/recipes/bioconductor-genomicranges
/tmp/miniconda/bin/bioconda-utils bioconductor-skeleton recipes/ config.yml GenomicRanges
Where to go for help
Edit
How to troubleshoot conda building issues in Bioconda:
http://bioconda.github.io/troubleshooting.html

Guidelines to contribute packages to Bioconda:
http://bioconda.github.io/guidelines.html

Appendix A: Install CGAT environment on Macs
Edit
Linux users should be able to just follow the official installation instructions:
https://github.com/CGATOxford/CGATPipelines/blob/master/README.rst

Because all packages in the CGAT environment are not available for OS X, Mac users need to follow the steps below:

#!/bin/bash

# Create install dir
mkdir -p $HOME/conda/cgat-env
cd $HOME/conda/cgat-env

# Make sure you have a copy of Miniconda
# curl -o Miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-4.3.31-MacOSX-x86_64.sh
curl -o Miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh

# Install conda
bash Miniconda.sh -b -p $HOME/conda/cgat-env/py36-v1

# Download conda envs
curl -O https://raw.githubusercontent.com/CGATOxford/CGATPipelines/master/conda/environments/pipelines-devel.yml
curl -O https://raw.githubusercontent.com/CGATOxford/CGATPipelines/master/conda/environments/pipelines-extra.yml
curl -O https://raw.githubusercontent.com/CGATOxford/CGATPipelines/master/conda/environments/pipelines-ide.yml
curl -O https://raw.githubusercontent.com/CGATOxford/cgat/master/conda/environments/scripts-devel.yml
curl -O https://raw.githubusercontent.com/CGATOxford/cgat/master/conda/environments/scripts-extra.yml

# Fix conda envs for Macs
sed -i'' -e '/wasabi/d' pipelines-devel.yml
sed -i'' -e '/sailfish/d' pipelines-devel.yml
sed -i'' -e '/peakranger/d' pipelines-devel.yml 

# Install conda envs
conda env create -n py36-v1 -f pipelines-devel.yml 
conda env update -n py36-v1 -f pipelines-extra.yml 
conda env update -n py36-v1 -f pipelines-ide.yml 
conda env update -n py36-v1 -f scripts-devel.yml 
conda env update -n py36-v1 -f scripts-extra.yml 
Appendix B: Customise your conda config
Edit
You can modify the default behaviour of conda with conda config. The configuration is saved in the .condarc file and here is how to configure interesting things.

The following command will show your customisation to your conda installation:

#!/bin/bash
conda config --show-sources
Interesting examples are:

Ask conda to not update automatically
Show channels URL
Whether to use soft-links or not for package installations
Ask conda to not update dependencies automatically
Disallow the installation of specific packages
Below is an example of how to configure a particular option.

#!/bin/bash

# see current config
conda config --get show_channel_urls

# set desired config
conda config --set show_channel_urls True

# confirm
conda config --get show_channel_urls
conda config --show-sources
Appendix C: Pin packages in a conda environment
Edit
Reference:
https://conda.io/docs/user-guide/tasks/manage-pkgs.html#preventing-packages-from-updating-pinning

In the environment’s conda-meta directory, add a file named pinned that includes a list of the packages that you do not want updated.

For example: The file below forces NumPy to stay on the 1.7 series, which is any version that starts with 1.7, and forces SciPy to stay at exactly version 0.14.2:

numpy 1.7.*
scipy ==0.14.2
With this pinned file, conda update numpy keeps NumPy at 1.7.1, and conda install scipy=0.15.0 causes an error.

Appendix D: How to install R packages
Edit
R packages in conda are named according to its repository:

CRAN packages: r-<name>
Bioconductor packages: bioconductor-<name>
All package names in conda are lowercase.
CRAN example:

Original package: https://cran.r-project.org/web/packages/WGCNA/index.html
Conda package: http://bioconda.github.io/recipes/r-wgcna/README.html
Bioconductor example:

Original package: https://www.bioconductor.org/packages/release/bioc/html/goseq.html
Conda package: bioconda.github.io/recipes/bioconductor-goseq/README.html
To install R packages, please do

conda search r-<name>
conda search bioconductor-<name>
Examples:

conda search r-wgcna
conda search bioconductor-goseq
Once you have configured conda channels as explained below, please do not use the -c flag to override channels when installing new packages (e.g. conda install -c r-wgcna)
Tags: [+]
Created by Sebastian Luna Valero on 2018/03/07 09:18
Comments (0)
Attachments (0)
History
Information
No comments for this page

Add commentCharlotte GeorgeCharlotte George says:
  
Applications
Blog
Dashboard
Help
Sandbox
More applications
Recent Blog Posts
18 Python programming books for beginners and veterans
 How exactly does binary code work?
 SequencEnG: An interactive learning resource for next-generation sequencing (NGS) techniques
Potential pitfalls in analyzing and quantifying lowly-expressed genes and small RNAs with alignment-free pipelines
Microsoft confirms it’s acquiring GitHub for $7.5 billion
SCANPY: large-scale single-cell gene expression data analysis
An introduction to machine learning with Keras in R
Alevin: An integrated method for dscRNA-seq quantification
nbdime – diffing and merging of Jupyter Notebooks
VIPER – Visualization Pipeline for RNA-seq
Navigation
Admin
Blog
CGAT Wiki Home
Help
IT
CBRG IT
IT glossary
Setup CGAT software environment
Shared data
Software
System Administration
2016-10-21 EMC and S3 visit to troubleshoot problems with Isilon
2016-11-10 Oxford R User group meeting
3Com 4200G configuration
48-port 1GbE network switches comparison
8TB external hard drive
Access to all Linux systems in FGU
Accounting with SGE
Add nagios monitoring to CGAT Isilon
Adding line numbers to Emacs
Adding optional RHEL repository to RHEL servers
Adobe Licensing
After loading a module the command "module" fails with "cannot initialize tcl"
Ansible
Apache SSL Configuration Best Practices
Archived Data
Conda workshop
290 more ...
Sandbox
Training Materials
XWiki
Tips
If you're starting with XWiki, check out the Getting Started Guide.

My Recent Modifications
Troubleshooting CGAT code and pipelines
Conda workshop
Software
Python 3 Migration
Setup CGAT software environment
Recently Modified
Troubleshooting CGAT code and pipelines
Conda workshop
Software
Profile of David Sims
Profile of Mathew Baldwin
Recently Created
Profile of Mathew Baldwin
Profile of Katherine Bull
Profile of Julia Truch
Profile of James Camp
Profile of Hedia Chagraoui
Recently Visited
Search
CGAT Wiki Home
Conda workshop
XWiki Jetty HSQLDB 9.11.3
