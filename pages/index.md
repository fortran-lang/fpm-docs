---
sd_hide_title: true
...

# Fortran package manager

::::::{div} landing-title
:style: "background-image: linear-gradient(315deg, #a34e9c, #9953ad); clip-path: inset(0% 100% 0% 100% round 20px);"

:::{card} Fortran package manager
:class-title: sd-text-white sd-fs-2 sd-font-weight-bold
:class-body: sd-text-white sd-fs-4
:class-card: sd-border-0
:margin: 5
:shadow: none

Package manager and build system for Fortran.
:::

::::::

Welcome to the documentation of the Fortran package manager (fpm).
This documentation is divided in four major parts, select one of the topics below to continue.

::::{note}
This pages are currently under construction and contributions are always welcome!
::::


:::::{grid} 2
:gutter: 3

::::{grid-item-card} {octicon}`mortar-board` Tutorials
:class-card: sd-text-white sd-bg-info sd-rounded-3
:class-body: sd-text-white

Learn about using fpm for Fortran development, creating of projects and managing dependencies.

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

::::{grid-item-card} {octicon}`book` How-To Guides
:class-card: sd-text-white sd-bg-warning sd-rounded-3
:class-body: sd-text-white

Practical guides and recipes for solving specific problems with fpm.

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

::::{grid-item-card} {octicon}`milestone` Design Documents
:class-card: sd-text-white sd-bg-primary sd-rounded-3
:class-body: sd-text-white

Resources around the design of the command line interface, the package manifest and the general user experience.

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

::::{grid-item-card} {octicon}`gear` References
:class-card: sd-text-white sd-bg-success sd-rounded-3
:class-body: sd-text-white

Specifications of the components of the Fortran package manager and references for the actual implementation.

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

## {fa}`newspaper` News

Recent events around the Fortran package manager, new release, conference talks and new packages will be announced here:

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
news
````
