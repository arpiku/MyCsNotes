# Pip and Conda
https://pythonspeed.com/articles/conda-vs-pip/

1. **Conda** was develeoped by Travis Oliphant and as explained in the podcase wit Lex, the conda as a package manger was born due to the need of better flow of installing python libraries, as the systems before that would consume way too much time, and were unable to support changes in the libraries requriring end users to sometimes reinstall everything.
2. **Pip** being the more popular option when it comes to managing python packages actually came after python, pip is very python specific and cannot handle tools that fall out of python's 'environement', i.e it cannot be used to install packages written in another language, or binaries of the package, e.g GNUplot.

- NOTE : 'pip search' was depreacated, this is due to it being a resource intensive task on **pypis**' servers, alternative is to use a community tool called pip-search, which is also installed like any pip pakage.
- NOTE: -U is used to upgrade the installed package and all the dependencies to the lastest version in pip : 'pip install -U sklearn'

## Differences
- Pip offers packages like Numpy and matplotlib etc, that are written in python.
- Conda offers packages like Numpy, matplotlib,  libjpeg and executables like C compilers and even the python interpretor itself.
- With Conda any dependency can be a Conda package, it mostly relies on OS to supply most of the basic facilties, anything above that is a Conda package, and that's why it supports almost all kind of packages.
- Pip used **pypi** and Conda uses **conda-forge** in general, condas' implementation has more channels, where they can get the packages from different sources.

![[pipconda 2022-06-08 at 10.46.12 AM.png]]

## Dependecies on code writthen in differnet language
1. **Pip** offer '**pip wheels**' , to resolve this problem, earlier one had to get the source code and compile it.
2. **Conda** offer direct method to take care of this issue, in their impelementaion one doesn't need a new package to do this, it would automatically install the dependencies much like a package manager of linux installs the dependencies automatically.


## Pypi vs Conda-Forge
![[pipconda 2022-06-08 at 10.46.12 AM.png]]


## Important Note

So which should you use, pip or Conda? For general Python computing, pip and PyPI are usually fine, and the surrounding tooling tends to be better.
For data science or scientific computing, however, Conda’s ability to package third-party libraries, and the centralized infrastructure provided by Conda-Forge, means setup of complex packages will often be easier. In the end, which works best for you will depend on your situation and requirements; quite possibly both will be fine.