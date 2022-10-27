---
sd_hide_title: true
...

# Fortran Package Manager

:::{card}
:class-header: sd-text-white sd-fs-2 sd-font-weight-bold sd-border-0
:class-body: sd-text-white sd-fs-4 sd-border-0
:class-card: sd-border-0 sd-bg-danger sd-px-5 sd-py-1 sd-rounded-3
:shadow: none

Fortran Package Manager
^^^

Package manager and build system for Fortran
:::

Welcome to the documentation for the Fortran Package Manager (fpm).

::::{note}
These pages are currently under construction.
Please help us improve them by contributing content or reporting issues.
::::


:::::{grid} 2
:gutter: 3

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-info sd-rounded-3
:class-body: sd-text-white
:class-footer: sd-py-1 sd-border-0

{octicon}`download` Install
^^^

Instructions on how to install fpm across Windows, Linux, macOS and more.

+++
```{card}
:link-type: ref
:link: install
:class-card: sd-btn sd-btn-light
:class-body: sd-p-1 sd-text-center sd-font-weight-bold sd-text-info

Install fpm
```
::::

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-warning sd-rounded-3
:class-body: sd-text-white
:class-footer: sd-py-1 sd-border-0

{octicon}`mortar-board` Tutorials
^^^

Learn about using fpm for Fortran development, creating projects and managing dependencies.

+++
```{card}
:link-type: ref
:link: tutorial
:class-card: sd-btn sd-btn-light
:class-body: sd-p-1 sd-text-center sd-font-weight-bold sd-text-warning

Browse tutorials
```
::::

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-primary sd-rounded-3
:class-body: sd-text-white
:class-footer: sd-py-1 sd-border-0

{octicon}`book` How-To Guides
^^^

Practical guides and recipes to solve specific problems with fpm

+++
```{card}
:link-type: ref
:link: how-to
:class-card: sd-btn sd-btn-light
:class-body: sd-p-1 sd-text-center sd-font-weight-bold sd-text-primary

Browse recipes
```
::::

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-success sd-rounded-3
:class-body: sd-text-white
:class-footer: sd-py-1 sd-border-0

{octicon}`gear` References
^^^

Specifications of fpm components and implementation references

+++
```{card}
:link-type: ref
:link: spec
:class-card: sd-btn sd-btn-light
:class-body: sd-p-1 sd-text-center sd-font-weight-bold sd-text-success

Browse references
```
::::

:::::

## {fa}`cubes` Registry

There are already many packages available for use with fpm, providing an easily accessible and rich ecosystem of general purpose and high-performance code.
For a full list of packages checkout the [fpm registry](registry/index).
New packages can be submitted to the registry [here](https://github.com/fortran-lang/fpm-registry).


## {fa}`newspaper` News

Recent events around the Fortran Package Manager, such as new releases, conference talks, and new packages will be announced here.

:::{postlist} 5
:date: '%Y-%m-%d'
:format: '{title} ({date})'
:excerpts:
:::


````{toctree}
:maxdepth: 2
:hidden:
Installation <install/index>
Tutorial <tutorial/index>
How-To <how-to/index>
Reference <spec/index>
Design <design/index>
Registry <registry/index>
news
````
