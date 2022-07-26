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

This documentation is divided into four parts.
Select one of the topics below to continue.

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

{octicon}`mortar-board` Tutorials
^^^

Learn about using fpm for Fortran development, creating projects and managing dependencies.

+++
```{button-ref} tutorial
:ref-type: ref
:click-parent:
:outline:
:expand:
:color: white

Browse tutorials
```
::::

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-warning sd-rounded-3
:class-body: sd-text-white

{octicon}`book` How-To Guides
^^^

Practical guides and recipes to solve specific problems with fpm

+++
```{button-ref} how-to
:ref-type: ref
:click-parent:
:outline:
:expand:
:color: white

Browse recipes
```
::::

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-primary sd-rounded-3
:class-body: sd-text-white

{octicon}`milestone` Design Documents
^^^

Resources about the design of the command line interface, the package manifest, and the general user experience

+++
```{button-ref} design
:ref-type: ref
:click-parent:
:outline:
:expand:
:color: white

Browse documents
```
::::

::::{grid-item-card}
:class-header: sd-text-white sd-font-weight-bold sd-border-0
:class-card: sd-text-white sd-bg-success sd-rounded-3
:class-body: sd-text-white

{octicon}`gear` References
^^^

Specifications of fpm components and implementation references

+++
```{button-ref} spec
:ref-type: ref
:click-parent:
:outline:
:expand:
:color: white

Browse references
```
::::

:::::

## {fa}`cubes` Registry

There are already many packages available for use with fpm, providing an easily accessible and rich ecosystem of general purpose and high-performance code.
For a full list of packages checkout the [fpm registry](https://fortran-lang.org/packages/fpm).
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
Tutorial <tutorial/index>
How-To <how-to/index>
Design <design/index>
Reference <spec/index>
Registry <https://fortran-lang.org/packages/fpm>
news
````
