# Setting up Conda on Windows

- In your web-browser, mavigate to <https://docs.conda.io/en/latest/miniconda.html>
- Download `Miniconda3 Windows 64-bit`
- Run the installer.
  Follow the instructions, although the default settings are sensible.

# Getting started with Conda

- From the `Start Menu`, launch the `Anaconda Powershell Pronpt (minconda3)
- Check that your installation is working by typing `conda --help` a<<t the prompt.
  The terminal should display a message indicating the main Conda subcommands available to you.
- Run the following commands to set the Conda channels to search for packages.
  The order of the commands is important to set the channels in priority order.

```bash
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```

- Display information about the active and available environment by typing `conda info --envs`.
- Make sure all the package in the environmetn are up to date by typing `conda update --all`.
  You may be prompted to type `y` (meaning "yes") to accept updating out of date packages if any.
  
## Create environments for the course

### R

<!--
Note:
Once we figure out all the packages needed 
-->

- Type the following command to install R, RStudio, and a number of R packages required for the course.

```
conda create --name obds_sep_2020_r r-base=4.0.2 r-renv rstudio
# On 08/09/2020 this command reports a conflict whereby rstudio requires R < 4.0
```
