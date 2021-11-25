# Fpm documentation

Repository for building the documentation pages for the Fortran package manager (fpm).


## Building

This project is built with *sphinx* to install the required dependencies use

```
conda env create -n sphinx -f environment.yaml
conda activate sphinx
```

Build the documentation by invoking

```
make html
```
