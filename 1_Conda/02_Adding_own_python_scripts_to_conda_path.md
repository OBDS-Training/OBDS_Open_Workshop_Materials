## Adding your own python scripts and modules to your conda path 

- Previously this would have been done by setting PYTHONPATH variable 
- Here we create a .pth file file for conda using the conda-build package


1. Install `conda-build` into `base` env 
2. Activate conda env of choice 
3. `conda develop /path/to/src/containing/code` 


Troubleshooting 
	- Had issues with toornado version (6.1 incompatable- can't launch juptyer notebook kernal)
	- Mamba install tornado=5.1  (also had to conda remove jupyter_server) 

Can check path in pyton using 
import sys; print('\n'.join(sys.path))![image](https://user-images.githubusercontent.com/8723681/152001279-1eb6e6a3-dac3-411e-9adf-1e6c888e17b0.png)
