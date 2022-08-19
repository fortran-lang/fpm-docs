# Fpm documentation

[![pages](https://github.com/fortran-lang/fpm-docs/actions/workflows/sphinx.yml/badge.svg)](https://fpm.fortran-lang.org/)
[![test](https://github.com/fortran-lang/fpm-docs/actions/workflows/build.yaml/badge.svg)](https://github.com/fortran-lang/fpm-docs/actions/workflows/build.yaml)

Repository for building the documentation pages for the Fortran package manager (fpm).


## Getting started

### Get the code

```
git clone https://github.com/fortran-lang/fpm-docs
cd fpm-docs
```

### Install dependencies

The documentation pages are created using [sphinx](https://www.sphinx-doc.org).
You first need to install the required dependencies using conda or pip.
This project uses

- [sphinx-build](https://www.sphinx-doc.org) for building the pages
- [sphinx-intl](https://www.sphinx-doc.org/en/master/usage/advanced/intl.html) for translations
- [ablog](https://ablog.readthedocs.io/en/latest/) for the news section and posts
- [sphinx-book-theme](https://sphinx-book-theme.readthedocs.io/en/latest/) for the page theme
- [myst-parser](https://myst-parser.readthedocs.io/en/latest/) for markdown support
- [sphinx-design](https://sphinx-design.readthedocs.io/en/latest/) for the bootstrap building blocks
- [sphinx-copybutton](https://sphinx-copybutton.readthedocs.io/en/latest/) to allow copying of code-blocks
- [sphinx-jinja](https://github.com/tardyp/sphinx-jinja) to use templating for the registry

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

By default all languages will be built.
To limit the build to a single language subtree, *i.e.* English, use

```
make html LANGUAGES=en
```


### Translating via weblate

Translations can be contributed via [weblate](https://hosted.weblate.org/projects/fortran-lang/fpm/).

[![Translation status](https://hosted.weblate.org/widgets/fortran-lang/-/fpm/horizontal-auto.svg)](https://hosted.weblate.org/engage/fortran-lang/)


### Update or add translations

The documentation uses the
[sphinx-intl](https://sphinx-intl.readthedocs.io/en/master/quickstart.html)
utility to generate websites for multiple languages.
It generates `*.po` files,
which contain the original sentences and a placeholder for translations.

To update translations run

```
make gettext
```

if you only want to update a single translation add `LANGUAGES=de` to the command.
This command will generate the message catalog (`*.pot`) and update the `*.po` files in the *locale* directory of the respective translations.
Then edit the `*.po` files,
e.g. `locale/de/LC_MESSAGES/index.po`.
In the `*.po` files are paragraphs like
```po
#: ../../pages/index.md:16
msgid "Package manager and build system for Fortran"
msgstr ""
```

The first line describes the file and line where to find the original text.

The second line is the original text.
**Don't edit this line, edit the original document instead**.

The third line is meant for the translation.

To continue a long string in another line,
simply close the string in the current line with `"`
and open another one in the line underneath. E.g.
```
msgstr "This is "
"one string"
```
*don't forget a space between 'is' and 'one'*

After adding or updating translations
build the documentation as described above.
