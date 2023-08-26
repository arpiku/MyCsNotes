# Microsoft Azure ML cheat sheet
![[AzureMLcheatsheet.png]]


# Venv vs ipython kernel
A virtual environment is an isolated copy of a python installation that can be used to run Jupyter. If you create a python 3 virtual env, you can install Jupyter into this environment using pip and then launch Jupyter. The only python "kernels" it will then show will be the python virtual environment.

A kernel in Jupyter is a different engine for running notebook cells in iPython. If you install packages in a python virtual env you get those packages only in the kernel that virtual environment can give you, namely just that python version. However if you make a conda environment and install different kernels into it, such as R, then you'll have something like a virtual environment that has 2 or more kernels.

A conda environment supercedes a virtual environment. While you cannot easily install multiple kernels into a virtual environment, you can do so easily in a conda environment.

~~~bash 
ipython kernel install --user  --name=ml # to create an ml virtual env for jupyter notebook

# or one can do the following 

virtualenv [directory]
~~~

!!!!Figure out the how the two methods actually work under the hood.
