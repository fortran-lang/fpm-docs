# Fpm documentation

Repository for building the documentation pages for the Fortran Package Manager (fpm).


## Getting started

### Get the code

```
git clone https://github.com/fortran-lang/fpm-docs
cd fpm-docs
```

### Install dependencies

The documentation pages are created using [sphinx](https://www.sphinx-doc.org).
You first need to install the required dependencies using conda or pip.

#### conda

```
conda env create -n sphinx -f environment.yaml
conda activate sphinx
```

#### pip

```
python3 -m venv venv
source venv/bin/activate
pip install -U pip
pip install -r requirements.txt
```

### Build fpm-docs

Build the documentation by invoking

```
make html
```

The website will be built in `_build/html` and can be previewed by opening the page with a browser (*e.g.* firefox, chromium or similar):

```
firefox file://$PWD/_build/html/index.html
```

By default all languages will be build, to limit the build to a single language subtree, *i.e.* English, use

```
make html LANGUAGES=en
```
