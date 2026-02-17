---
author: Sebastian Ehlert, Federico Perini, Brad Richardson, John Urban
date: 2023-04-11
category: release
...

# Fpm version 0.8.1 released

This release introduces a hotfix for the automated dependency tree feature introduced in [v0.8.0](https://github.com/fortran-lang/fpm/releases/tag/v0.8.0).
Fpm now restored backward-compatible dependency priority, which ensures that, whenever different versions of the same dependency are found down the dependency tree, the first and foremost is used.
Unnecessary dependency updates are also shed from the build process.

Find the full release notes [here](https://github.com/fortran-lang/fpm/releases/tag/v0.8.1).

Many thanks to
Sebastian Ehlert ([@awvwgk](https://github.com/awvwgk)),
Brad Richardson ([@everythingfunctional](https://github.com/everythingfunctional)),
John Urban ([@urbanjost](https://github.com/urbanjost)),
for testing the new release and allowing this hotfix to be deployed quickly.

## Changelog

* Only update dependencies between cached build and manifest (fix) by @perazz in [fpm#871](https://github.com/fortran-lang/fpm/pull/871)
* Print dependency update messages on verbosity>0 (fix) by @perazz in [fpm#873](https://github.com/fortran-lang/fpm/pull/873)
* Automated dependency update: restore deterministic behavior by @perazz in [fpm#875](https://github.com/fortran-lang/fpm/pull/875)

