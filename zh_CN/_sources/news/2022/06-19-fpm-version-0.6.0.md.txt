---
author: Pedro Costa, Sebastian Ehlert, Laurence Kedward, Wileam Y. Phan, Arteev Raina, Simon Rowe, Andre Smit, John Urban, Zuo Zhihua, St-Maxwell, Joel
date: 2022-06-19
category: release
...

# Fpm version 0.6.0 released

This release introduces a better visualization for the build output, compiler output is only shown on error to keep the standard output clean for successful builds.
Furthermore, fpm can now detect unused modules and avoids compiling modules that are not needed for an application, which improves the compilation speed with large dependencies like stdlib.
When creating a new project with fpm the author information are now taken from the git configuration to avoid using placeholders in the manifest.
Several more bug fixes and plenty of improvements went into this version as well.

Find the full release notes [here](https://github.com/fortran-lang/fpm/releases/tag/v0.6.0).

Many thanks to Pedro Costa ([@p-costa](https://github.com/p-costa)), Sebastian Ehlert ([@awvwgk](https://github.com/awvwgk)), Laurence Kedward ([@lkedward](https://github.com/lkedward)), Wileam Y. Phan ([@wyphan](https://github.com/wyphan)), Arteev Raina ([@arteevraina](https://github.com/arteevraina)), Simon Rowe ([@wiremoons](https://github.com/wiremoons)), Andre Smit ([@freevryheid](https://github.com/freevryheid)), John Urban ([@urbanjost](https://github.com/urbanjost)), Zuo Zhihua ([@zoziha](https://github.com/zoziha)), [@st-maxwell](https://github.com/st-maxwell), and [@noisegul](https://github.com/noisegul) for contributing patches to this release.


## Changelog

* Better extraction of the Fortran compiler from the MPI wrapper ([#634](https://github.com/fortran-lang/fpm/pull/634))
* Update module output directory command for flang-new/f18 ([#645](https://github.com/fortran-lang/fpm/pull/645))
* Respect user provided main-files ([#646](https://github.com/fortran-lang/fpm/pull/646))
* just allow . on new subcommand instead of changing canonical path ([#630](https://github.com/fortran-lang/fpm/pull/630))
* get user name and email using git config if available else use defaults ([#652](https://github.com/fortran-lang/fpm/pull/652))
* Ignore hidden source files ([#654](https://github.com/fortran-lang/fpm/pull/654))
* Cleanup the backend output ([#622](https://github.com/fortran-lang/fpm/pull/622))
* Add note about relocation of manifest reference ([#648](https://github.com/fortran-lang/fpm/pull/648))
* Fix for backtrace error when file not found in: `src/fpm_source_parsing.f90` ([#675](https://github.com/fortran-lang/fpm/pull/675))
* Fix issue with backend pretty output ([#677](https://github.com/fortran-lang/fpm/pull/677))
* fix: remove remove unnecessary space in fpm new cmd ([#684](https://github.com/fortran-lang/fpm/pull/684))
* Small fix for `fpm_model` ([#688](https://github.com/fortran-lang/fpm/pull/688))
* add clean command ([#655](https://github.com/fortran-lang/fpm/pull/665))
* Fix for non-portable GFortran `-J` flag in install script ([#692](https://github.com/fortran-lang/fpm/pull/692))
* Fix show-model option ([#693](https://github.com/fortran-lang/fpm/pull/693))
* Tree shaking for modules ([#676](https://github.com/fortran-lang/fpm/pull/676))
* Fix submodule shaking ([#704](https://github.com/fortran-lang/fpm/pull/704))
* fix: remove extra space from help-test cmd ([#686](https://github.com/fortran-lang/fpm/pull/686))
* Fix: to pipe up-to-date message to stderr ([#706](https://github.com/fortran-lang/fpm/pull/706))
* Avoid infinite loop if command "fpm-" is in path ([#713](https://github.com/fortran-lang/fpm/pull/713))
* Fix --show-model, init `c_source%parent_modules` ([#712](https://github.com/fortran-lang/fpm/pull/712))
* Add OMP critical for `make_archive` ([#708](https://github.com/fortran-lang/fpm/pull/708))
