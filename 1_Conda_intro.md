# Introduction to Conda 
-----------------------

This workshop material was created by *Sebastian Luna Valero* with moifications by *Charlie George* 

This workshop has been split into two parts:

- part 1: introduction to conda (Sections 1, 2 and 3), and

- part 2: building packages with conda (Section 4).

For more help about using conda, please see: [https://conda.io/docs/]

## Section 1: Install conda

Installing things can involve alot of reading/writing of files and therefore can be memory intensive
so ideally we want to do this on the cluster. lets sign into the head node (e.g. deva, klyn or cgath1) 
and log into a compute node on the cluster using. 

**1) log into cluster using ssh**

    $ ssh -X <username>@<headnode.address.ox.ac.uk>
    
    (replace <username> and <headnode.address.ox.ac.uk> with appripropriate items)

**2) lets move onto a compute node on the cluster**

    $ qrsh

**3) Now go to your working directory (e.g. /t1-data/user/{USER}/  if you are working on cbrg systems or /ifs/obds-training/{USER} if you are on cgat system ) and lets set up a directory for your conda installation:****

    
    $ cd /ifs/obds-training/jan20/{USER}/ 
    $ mkdir conda
    $ cd conda
    
    
**4) Now we've made a directory for it lets get a copy of the conda install script:**

    #*For Linux (the cluster) use:*

    
    $ curl -o Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    

    # *OS X (your macbook) use:*

    
    $ curl -o Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
   

    Please note if you want you can get specific versions of the conda installer from
    [https://repo.continuum.io/miniconda] and to find a specific version and download like this:  

    
    $ curl -o Miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh
    

    We always recommend downloading the latest version of the conda install script unless there are known issues with it 

**5) Now lets run the install script to install conda:**

   
    $ bash Miniconda.sh -b -p obds_conda
    

**6) So our terminal knows where to find the conda software we need to add this location to our $PATH variable so that we can use it:**

    ```
    # Activate conda installation
    $ source /full/file/path/to/where/you/have/installed/obds_conda/etc/profile.d/conda.sh

    # Activate base environment to move into the default conda software enviroment
    $ conda activate base

    ```
**7) test your source command has worked by trying**

    ```
    $ conda --help
    $ which conda
    ``` 

    We'll see what conda environments are in a moment. The important bit to grasp here here is that 'base' is the name of the the default conda environment every time you install conda, it contains the very latest version of python and a few basic python packages.


## Section 2: Using conda


**1) To get help for conda, type:**

    ```
    $ conda --help
    ``` 

**2) To get information about your current install, type:**

    ```
    $ conda info
    ``` 

**3) We can use conda to search for software packages to install, however inorder to find the packages, conda needs the address of certain sites on the internet to look at - these are called 'channels'. Let us add appropriate conda channels to get all software we need (and trust). The order that these channels are specified is important!**

    ```
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    ```
**Note: Mac users may have problems copying and pasting the config commands above, with strange error messages. If that's the case, please enter these commands manually and try again.** 

**We have added 3 channels here:**
  **- default channel: this contains major common software that has been packaged for conda by people at conda and anaconda themselves**
  **- conda-forge: this contains lots of general programming packages that have been packaged for conda by people in the programming/computational community**
  **- bioconda: this contains biology specific programmes that have been packaged for conda by people in the computational biology community.**
  
**4) Check that these channels have been added to your conda installation with:**

    ```
    $ conda info
    ``` 

**5) List currently installed packages:**

    ``` 
    $ conda list
    ``` 

**6)  Check whether your packages are up-to-date:**

    ```
    $ conda update --all
    ``` 

As you have added new channels it is likely that several packages will be both up and down graded at this stage, and some new packages may be added. Please accept the changes by typing y at the prompt.

**7) Now, let us search and install a package. Our example here is FastQC, a command-line tool to profile quality scores in a fastq file:** 

    ``` $ conda search fastqc``` 

**8) Check whether or not you have it installed:**

    ```
    # find fastqc
    $ conda list fastqc
    # or:
    $ which fastqc

    ```
    
**9) Once you have found the package you are after, just need to install it by doing:**

    ```
    $ conda install fastqc
    ```
    
    If you don't specify a version, the latest available one will be installed. However, you can also ask for a specific version of a package with

    ```
    $ conda install fastqc=0.11.7
    ```

**10) Now double-check that the package is available:**

    ```
    # use conda
    $ conda list fastqc
    # or:
    $ which fastqc
    # or use your software:
    $ fastqc --help
    ```

**11) Now that we've checked its installed and usable (i.e. you can access the help) you can remove it:**

  ```
  $ conda remove fastqc
  ``` 

**12) It is also possible to see what could happen when you install something  without actually performing any changes (also known as dry run):**

    ```
    $ conda install pysam --dry-run
    ``` 

The above command will execute all the steps to install pysam, but finally it does not do it. This is useful to check beforehand what installing a package is going to do.

**13) In addition to the ```conda search <name>``` command, you can also visit the following websites to check for available conda packages:**

        - [http://bioconda.github.io/recipes.html]
        - [https://conda-forge.org/feedstocks/]

## Section 3: Conda environments

### A) Setting up a new enviroment for a single program or small number of programs

So far we have been working with the (default) base environment. However, conda environments are great to have isolated development environments to test new software or install conflicting dependencies. They are also useful to share (export) production environments with anybody else (reproducible science). We are going to make 3 new enviroments - one with MACS2 and Python 2.7, one with python 3 and  our genomics software and a third with R / Bioconductor. 

**- In order to get help about conda environments, do:**

    ```
    $ conda env -h 
    ``` 

**- To get a list of existing environments, type:**

    ```
    $ conda env list
    ```

**- It is also possible to get specific help and examples of a subcommand:**

    ```
    $ conda env list -h
    ```

**- Let's now create a new environment to test the latest MACS2:**

**1) search package**

    ```
    $ conda search macs2
    ```

**2) create a new conda environment with the desired packages**
    
    ```
    $ conda create -n macs2-env macs2
    ```

**3)  activate new conda environment**

    ```$ conda activate macs2-env```

**4)  check the current active conda environment**
    
    ```
    $ conda env list
    ```

**5) check out your software has installed properly**

    ```
    $  macs2 -h
    ```

**6) check which version of python you have in this enviroment**

    ```
    $ python --version
    ```

**Now, everything you install go into the active environment (e.g. macs2-env):**

    ```
    $ conda list
    ```

We will use this macs2 environment later in the course in a peakcalling exercise. If you had other software that depended on python 2.7 you might want to install it in this environment too. However at the moment we do not. 

**7) For now you can go back to the base environment by doing:**

    ```
    $ conda activate base
    ```

**8) you can get a list of the different enviroments you have created by doing:**

    ``` 
    $ conda env list
    ``` 

**9) If you wanted a record of your software environment or wanted to share it so others could replicate it, it is possible to export and likewise import conda environments:**

    ```
    # export
    $ conda env export -n macs2-env
    ```
**10) you can actually redirect the output to a file that you can share**

    ```
    $ conda env export -n macs2-env > macs2-env.yml
    ```

**11) see what's inside**

    ```
    $ cat macs2-env.yml
    ```

**12) the conda environment can now be re-created in another conda installation**

    ```
    $ conda env create -n macs2-env-copy -f macs2-env.yml 
    ```

**13) Lets activate the macs2-env-copy environment and start adding some other packages to practise how to install packages one by one**.  

    ```
    # activate environment
    $ conda activate macs2-env-copy
    ```

**14) lets install some more bioinformatics into the environment one by one. Using conda install add pandas (a python package), bedtools and samtools to the macs2-env-copy2 environment**





### Section 3b: Setting up the OBDS Training course environments

Now we've had some practise setting up conda environments we want to create a Python 3 environment and an R environment for the OBDS training course that will contain the software that we will use in the taught lectures/workshops over the next few weeks.

Whilst its possible and really handy to add conda packages one by one to build up a software environment, in practice this can take a lot of time and can also lead to conflicts later on (especially with r-packages) as the environment gets more and more complicated and you might need to upgrade/downgrade various versions of software along the way.

If you are setting up new software environment for a project it is advisable to have a think about the main software packages you might use in your analysis at the beginning and put these in an  environment.yml file (like we used above to create the macs2-env-copy environment) as this makes it easier for conda to workout what dependencies will be best for most of the major software right from the start. 

We want to create a new enviroment called obds_py3 to do this we can create a obds_py3.yml file and edit the dependencies list to include the following packages as well as a few others. You can use the macs2-env-copy.yml as a template. Note that you do not have to specify the versions of all the software packages - if you leave them blank then conda will work this out for you. 

#### Python & associated libraries

        - Python - version 3.6 (you should specify version number in the yaml file)
        - numpy  - (a python package for doing fast mathematical calculations and manipulations)
        - pandas - (a python package for making/using dataframes)
        - matplotlib - (a python package for plotting)
        - seaborn -  (a much prettier python package for plotting)
        - scipy - (a collection of python packages for data analysis, includes ipython, pandas etc)
        - spyder - an interactive development environment (IDE) for python similar to Rstudio 
        - ruffus - a python pipelining program that we will use to write pipelines
        - cgatcore - a library from cgat to make pipelines usable with a computer cluster
        - pysam - a python package for working with bam/sam alignment files 
        - pybedtools - a python wrapper for bedtools meaning you can use bedtools functionality in python scripts
        - drmaa - for the management of submitting jobs to the cluster
        - ggplot  - python version of ggplot
        - jupyter - interactive notebooks for python 

#### bioinformatics software

        - fastqc - QC of fastq raw sequence files
        - multiqc - collects summary statistics from other bioinfor- matic programs
        - hisat2 - super quick read aligner (mapper) for spliced sequencing reads
        - bowtie2 - slower read aligner for unspliced sequencing reads
        - samtools - manipulate bam/sam alignment files 
        - picard - QC of alignment files 
        - subread - counting of reads in features

We also want to create a new enviroment called obds_r to do this we need an obds_r.yml file listing the following packages as well as a few others:

#### R & associated packages - you might have to search some of these in conda or on the bioconda website (google it) to get the correct conda package names.

        - R  - note that r is called `r-base` in conda - search it and check you can find it 
        - rstudio - IDE for R 
        - tidyverse library - family of r packages that have usefull data processing functionality
        - deseq2 - r bioconductor statistical package for differential expression
        - edger - r bioconductor statistical package for differential expression
        - seurat - r Cran package for single cell analysis 
        - goseq - r bioconductor package for gene ontology analysis
        - gsea - r package for gene set enrichment analysis

**1) In the week1/conda directory there should be 2 files called `obds_py3.yml` and `obds_r.yml` copy these to your conda directory and use these file to create two new conda enviroments** 

**2) Once you have created the environments you might want to modify your `.bashrc` file to do the following**

- Point to your conda installation by adding the source command we did right at the begining to your `.bashrc`
- Use an alias to load your conda environments *Note we always want to conda activate base and then activate your environment of interest as this then allows you to use the `which` command to get the conda path -  this is useful later on in pipelines

***Now if you come across extra software in the course that wasn't installed via the yaml file you can use the `conda install` command to add the software to your exisiting environment - or if you would like to test some new software out you can create a new minimal environment to test it in.** 

**3) After you have made your conda environment we can check it against a hard record of the environment we want for the course using `diff`.**

**4) Finally lets clear up a bit - we don't actually need our macs2-env-copy environment so we will delete this**

    ```
    # remove macs2-env-copy
    conda env remove --name macs2-env-copy

    # check enviroment has been removed
    conda env list
    ```

### YAY! You now have a fully set up software enviroment that you can modify!! 
