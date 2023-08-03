# Software Management with Conda

This workshop material was origionally created by Sebastian Luna Valero.
It was subsequently updated by Charlie George, David Sims, and Kevin Rue-Albrecht.

During or after this workshop, we recommend the following resources for more help:

- <https://docs.conda.io/en/latest/>
- <https://obds-training.github.io/Help/docs/conda/introduction/>

## Prerequisites

### Connect to the University network

- For in-person courses run in the WIMM, connect to the Eduroam WiFi network.
- For remote courses run online, connect to the University VPN.

### Connect to the cluster over SSH

- From a Terminal emulator on your computer, edit and run the command below.

```bash
ssh <username>@cbrglogin1.molbiol.ox.ac.uk
```

NOTE: Replace `<username>` with your username.

## Install Conda

On the CCB cluster, Conda must be installed by each user individually.
This allows each user to manage and update their own Conda installation independently.

### Set your working directory

Run the command below to change directory to your home directory.

```bash
cd
```

### Download the Miniconda installation script

Run the command below to download the installation script to your working directory.

```bash
curl -o Miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
```

NOTE: If you ever need a specific versions of the conda installer
(e.g., a known issue reported for the latest version affects you),
you can get specific versions of conda from <https://repo.continuum.io/miniconda>.
Copy the link to the desired installation script, and download it using the same command as above,
replacing the URL by the link that you copied.

### Run the installation script

Run the command below to execute the installation script.

```bash
bash Miniconda.sh -b -p obds_conda
```

The option `-b` runs the installer in ‘batch’ mode (without manual intervention).
This assumes that you agree to the license agreement.
It also prevents the installer from modifying your `~/.bashrc` file.

The option `-p` specifies the installation path, the location where Conda will be installed.
For this course, we recommend specifying `obds_conda`, which will create a directory conda in your working directory (home directory).

NOTE: At this point, you could delete the installation script.
However, we might use it again to reinstall Conda if anything goes wrong in subsequent steps today.

## Test Conda

### Activate the Conda installation

Run the command to activate the Conda installation.

```bash
source ~/obds_conda/etc/profile.d/conda.sh
```

NOTE: The whole path above must be correct.
The safest way to yield a correct path is to paste the working directory printed above,
and then use the TAB key to autocomplete the name of each subdirectory.

Finally, run the command below to activate the default Conda environment (called `base`).

```bash
conda activate base
```

### Check if Conda is on your PATH

Run the command below to test that the executable `conda` is detected in the expected location.

```bash
which conda
```

You should see the following:

```
(base) [<username>@cbrglogin1 ~]$ which conda
~/obds_conda/bin/conda
```

In particular:

- `(base)` indicates that the default Conda environment - called `base` - is active.
- The output `~/obds_conda/bin/conda` indicates that the `conda` executable file was found at that location.
  This is the expected result given that we told the installation script to install Conda in `~/obds_conda`.

## Set up a shortcut to Conda

### Add an alias to your ~/.bashrc file

Open your `~/.bashrc` file using the `nano` text editor, as follows:

```bash
nano ~/.bashrc
```

Anywhere in the file, add the following lines:

```bash
# Define alias to activate Conda base environment
alias load_conda='source ~/obds_conda/etc/profile.d/conda.sh && conda activate base'
```

NOTE: It is good practise to add in some comments (lines starting with the symbol `#`)
above individual commands to remind us what they do.

Save your `~/.bashrc` file and close `nano`.

NOTE: Simultaneously press the keys `Control` and `X` to close `nano`.
When prompted, type `y` and press the key `Return` to save the file.

### Start a new session to test the shortcut

Disconnect from the cluster (type `exit`), and reconnect (use `ssh <username>@cbrglogin1.molbiol.ox.ac.uk`).

NOTES:

- Disconnecting from the cluster will deactivate the Conda installation.
- Reconnecting to the cluster will execute the `~/.bashrc` file, including the definition of the alias above.
- The `alias` command only defines the alias, it does not execute it.

### Activate the Conda installation using the alias

Run the command below to execute the command associated with the alias, thereby activating the Conda installation and the base environment.

```bash
load_conda
```

## Use Conda

### Display the reference manual page

Run the command below to print the reference manual page for the command `conda`.

```bash
conda --help
```

The reference manual page displays a list of available conda commands and their help strings.

### Display information about current Conda install

Run the command below to display information about current conda installation.

```bash
conda info
```

Inspect the individual pieces of information reported, and discuss their
relevance and importance.

### Configure Conda channels

Conda channels are the locations where packages are stored.
They serve as the base for hosting and managing packages
Conda packages are downloaded from remote channels,
which are URLs to directories containing conda packages.
The conda command searches a default set of channels
and packages are automatically downloaded and updated from
<https://repo.anaconda.com/pkgs/>.

NOTE:
Different channels can have the same package,
so conda must handle these channel collisions.

Read more at[Managing channels][managing-channels].

Run the command below to add Conda channels.

```bash
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```

NOTE:
The order of the commands above matters hugely.
The most recently added channel is moved to the top of the list,
meaning that it will take precedence over subsequent channels.
Many packages are available from multiple channels, in which case
those packages are downloaded from the channel with the highest priority.

Brief description of the three channels added here:

- `defaults`: this channels hosts the majority of all new Anaconda, Inc. package builds.
- `conda-forge`: this channel is a community effort that hosts packages from many developers
  in a single channel.
  Common standards ensure that all packages have compatible versions.
- `bioconda`: this channels hosts thousands of software packages related to biomedical research.

### Display updated information about current Conda install

Run the command below to display information about current conda installation,
like you did earlier.

```bash
conda info
```

Inspect the individual pieces of information reported, and check
that the newly added channels are correctly reported.

### List currently installed packages

Run the command below to list packages that are currently installed
in the active environment.

```bash
conda list
```

### Check whether your packages are up-to-date

Run the command below to check whether you have the latest version of the packages
currently installed in your active environment.

```bash
conda update --all
```

If any package is not up-to-date, you may be prompted `y/n` whether to proceed
and replace those packages by their latest version.

If so, type `y` and press the `Return` key to proceed.

### Search for packages and display associated information

Run the command below to search for the package named `mamba`.

```bash
conda search mamba
```

### Check if a Conda package is already installed

Run the command below to subset the list of packages installed
in the active environment to those whose name match the string `mamba`.

```bash
conda list mamba
```

If no package matches the pattern, the command will print an empty table
(i.e., only column headers will be visible).

NOTE:
When you become more familiar with the executable files that each Conda package
contains, you may also use the Bash command `which`, to find out whether
particular executable files are found on your `PATH`, e.g.

```bash
which mamba
```

If the command does not return anything, then the package `mamba` is likely
not installed.

### Install a Conda package

Run the command below to install the package `mamba`.

```bash
conda install mamba
```

The command will take some time to resolve the channel from which
the package will be downloaded, as well as all the package dependencies
that it requires to function.

When prompted `y/n` whether to proceed with the installation of the package
and its dependencies, type `y` and press the `Return` key to proceed.

NOTE:
Sometimes, you may not want to install the latest version of a package,
but a specific version instead.
For this, use the syntax `package=version`, e.g.

```bash
conda install mamba=0.7.8
```

### Check that the Conda package was successfully installed

Run the command below to subset the list of packages installed
in the active environment to those whose name match the string `mamba`,
like you did earlier.

```bash
conda list mamba
```

Again, you may also use the Bash command `which`,
to check whether the executable file `mamba` is found on your `PATH`.

```bash
which mamba
```

## Use Mamba

### What is Mamba?

The `mamba` command is a drop-in replacement for the `conda` command in many cases.
That means that you can substitute the `mamba` for `conda` in many commands.
For instance, instead of `conda install`, you can write `mamba install`.

The most famous feature of `mamba` is the speed at which it resolves and installs
Conda packages and their dependencies, relative to the `conda` command itself.

### Add an alias in your ~/.bashrc file for Mamba

For clarity,
preferably under the line that defines the alias `load_conda`,
add the following lines:

```bash
# Define alias to activate Conda base environment using Mamba
alias load_mamba='source ~/obds_conda/etc/profile.d/conda.sh && source ~/obds_conda/etc/profile.d/mamba.sh && mamba activate base'
```

### Install a Conda package using Mamba

Activate your mamba installation 
```bash
load_mamba
```

Run the command below to install the package named `samtools` using the `mamba` command.

```bash
mamba install samtools
```

NOTE:
It is also possible to see what would happen when you install a package without actually installing it.
This is known as a dry run, e.g.

```bash
mamba install pysam --dry-run
```

### Search for packages in a web-browser

In addition to the `conda search` or `mamba search` commands,
you can also visit certain websites to check for available conda packages.
This can be a much easier and interactive way of finding packages
if you are unsure how they might be named in conda.

For instance:

- <https://anaconda.org/bioconda/repo/>
- <https://conda-forge.org/feedstocks/>

### Remove packages and their depencies

Run the command below to remove the `samtools` package
- as well as its dependencies -
from the active environment.

```bash
mamba remove samtools
```

## Use Conda environments

### What are Conda environments?

So far, we have been working in the default Conda environment, called `base`.

However, Conda environments are great to isolate
sets of packages associated with distinct projects
or that contain mutually exclusive package versions
for different parts of the same project.

In addition, environments can be exported, shared, and restored
by others on other computers, promoting reproducibility and traceability.

### Display the reference manual page for Conda environments

Run the command below to display the reference manual page 
for the command `conda env`.

```bash
mamba env --help
```

Inspect and discuss the list of sub-commands listed in that
reference manual page.

### List existing environments

Run the command below to list Conda environments that currently
exist in your Conda installation.

```bash
mamba env list
```

NOTE:
Don't hesitate to try the `--help` option on sub-commands, to display their own reference manual page, e.g.

```bash
mamba env list --help
```

### Create an empty environment

Run the command below to create an environment named `peaktools`.

```bash
mamba create -n peaktools
```

### List existing environments

Run the command below to display the updated list Conda environments
that exist in your Conda installation now.

```bash
mamba env list
```

### Activate an environment

Run the command below to activate the environment that you just created.

```
mamba activate peaktools
```

### List currently installed packages

Run the command below to list packages that are currently installed in the active environment.

```bash
mamba list
```

### Install packages in the active environment

Run the command below to install the two packages
- `deeptools` and `macs2` -
in the active environment.

```bash
mamba install deeptools macs2
```

NOTE:
It is possible to install packages in a specific environment other than the active one,
using the `-n` option to specify the name of the environment, e.g.

```bash
mamba install -n peaktools deeptools macs2
```

### Test the installed packages

Run the commands below to test that the commands `macs` are available on your `PATH`
and ready for use.

```bash
macs2 --help
deeptools --help
```

### Create an environment from a list of packages

Run the command below to simultaneously create an environment named `ngstools`
and install the packages `samtools` and `bedtools` in it.

```bash
mamba create -n ngstools samtools bedtools
```

You can run the commands below to activate the environment
and test that the two packages were successfully installed.

```bash
conda activate ngstools
samtools --help
bedtools --help
```

### Remove an environment

Run the commands below to
deactivate the environment named `ngstools` (currently active)
and remove it along with all the packages that are installed in it.

```bash
conda deactivate
mamba remove --name ngstools --all
```

You can run the command below to list existing environments
and verify that the environment named `ngstools` is not present
anymore.

```bash
mamba env list
```

You can run the commands below to also deactivate the environment
named `peaktools` (if active) and remove it along with all the packages
that it contains.

```bash
conda deactivate
mamba remove --name peaktools --all
```

You can run the command below to list one more time existing environments
and verify that the environment named `peaktools` was also fully removed.

```bash
mamba env list
```

## Set up the Conda environment for the course

### Using YAML files to create Conda environments

In the previous section, you have created Conda environments
and specified packages to install as arguments on the command line.
Whilst it is possible to continue doing so, in practice this is
a rather inefficient process that is also prone to complications
with respect to reproducibility and traceability
as the number of packages in the environment grows.

In this section, you will create a Conda environment
using the YAML file [obds-rnaseq.yml](./obds-rnaseq.yml).
Have a look at the file.

The file contains:

- The list of packages that we want you to install in a new environment.
- The (ordered) list of channels from which those packages should be downloaded.
- The name that should be given to the newly created environment (unless you override it on the command line).

Using YAML files to simultaneously create environments and install
entire sets of Conda packages is a much more consistent method to
sustain reproducibility across projects.

### Create a Conda environment from a YAML file

Run the command below to create an environment using a copy of the YAML file on the teaching cluster.

```bash
mamba env create -f /project/obds/shared/resources/1_linux/3_conda/obds-rnaseq.yml
```

NOTE:
The command above specifies only the YAML file, without using any overriding command-line argument.
This means that all the information relevant to the creation of the environment
and the installation of packages will be taken directly from the YAML file;
the name of the environment, the channels to search, and the list of packages to install.

### Activate the environment

Run the command below to activate the environment that you just created.

```bash
conda activate obds-rnaseq
```

### Inspect the environment

Run the commands below to inspect various aspects of the environment.

Check the version of Python that is installed in the environment.

```bash
python --version
```

List all the packages in this environment.

```bash
mamba list
```

### Export the environment to a YAML file

First, run the command below to change directory to your home directory.

```bash
cd
```

Then, run the command below to export (i.e., print) the details of the environment
named `obds-rnaseq`.

```bash
mamba env export -n obds-rnaseq
```

NOTE:
The command `mamba env export` prints the information in the console.
It does not automatically redirect that output to a file.
To redirect the exported information to a file,
add the option `-f` to specify the path to the file, e.g.

```bash
mamba env export -n obds-rnaseq -f my_obds_rnaseq.yml
```

### Deactivate Conda

We have reached the end of this workshop.

Whilst you could simply close the Terminal window,
which in turn would terminate your Bash session
and automatically deactivate your Conda environment and installation,
you can also manually deactivate the Conda environment and installation
using the following command:

```bash
mamba deactivate
```

NOTE:
If you have successively activated multiple environments,
you may need to execute the command `mamba deactivate` multiple times.
Each time it is executed,
the command `mamba deactivate` deactivate the active environment,
until the active environment is `base`,
in which case the command will deactivate the Conda installation altogether.
The `base` environment is always the first environment that is activated
and the last environment to be deactivated.

## Final words

Congratulations for completing this workshop!

In this workshop you have learned:

- To install and configure Conda using Miniconda.
- To activate your Conda installation.
- To use Conda and its drop-in replacement Mamba.
- To install and remove Conda packages.
- To create and remove Conda environments.
- To use YAML files for creating and exporting Conda environments.

We encourage you to experiment with Conda commands and environments
in your daily work.
The more you use Conda, the more confident you will become around it.

In particular, you should not be scared of making mistakes
and ruining your Conda environments.
You will often find that the fastest and most reliable method to
fix mistakes in your Conda environments is to remove the faulty
environment altogether, and create it again, either from scratch
or from a YAML file that you might edit over time.

Finally, this workshop focuses on the essential aspects of Conda
to get you started with the core knowledge that you will need
for the most common tasks in your daily Conda usage.
We encourage you to consult the [Conda User guide][conda-user-guide],
for more information about advanced use cases,
as well as a [Conda cheat sheet][conda-cheatsheet] of the most common commands.

<!-- Links -->

[managing-channels]: https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-channels.html
[conda-user-guide]: https://docs.conda.io/projects/conda/en/latest/user-guide/index.html
[conda-cheatsheet]: https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html
