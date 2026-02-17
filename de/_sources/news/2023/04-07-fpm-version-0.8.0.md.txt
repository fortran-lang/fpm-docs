---
author: Aarush Bhat, Minh Dao, Sebastian Ehlert, Sergey Fedorov, Sebastien Marie, Giannis Nikiteas, Federico Perini, Ivan Pribec, John Urban, Zuo Zhihua
date: 2023-04-07
category: release
...

# Fpm version 0.8.0 released

This release introduces support for enabling and disabling language features in fpm, such as implicit typing or default source form.
By default, fpm now tries to disable implicit typing rules, implicit external interfaces and assumes the source form is always free.
The options can be overwritten in the manifest for each project.

Furthermore, first support for local and remote registries are integrated in fpm.
The registry support can be configured in a new global configuration file.
This development was sponsored by the [Sovereign Tech Fund](https://sovereigntechfund.de/en/projects/fortran/).

Bugfixes and improvements to the preprocessor support, C++ compilation, dependency updates and more are included in this release.

Find the full release notes [here](https://github.com/fortran-lang/fpm/releases/tag/v0.8.0).

Many thanks to
Aarush Bhat ([@sloorush](https://github.com/sloorush)),
Minh Dao ([@minhqdao](https://github.com/minhqdao)),
Sebastian Ehlert ([@awvwgk](https://github.com/awvwgk)),
Sergey Fedorov ([@barracuda156](https://github.com/barracuda156)),
Sebastien Marie ([@semarie](https://github.com/semarie)),
Giannis Nikiteas ([@gnikit](https://github.com/gnikit)),
Federico Perini ([@perazz](https://github.com/perazz)),
Ivan Pribec ([@ivan-pi](https://github.com/ivan-pi)),
John Urban ([@urbanjost](https://github.com/urbanjost)),
Zuo Zhihua ([@zoziha](https://github.com/zoziha))
for contributing patches to this release.

## Changelog

* Set C++ compiler to clang++ in [fpm#787](https://github.com/fortran-lang/fpm/pull/787)
* Document ``FPM_CXX``, ``FPM_CXXFLAGS`` and options in [fpm#788](https://github.com/fortran-lang/fpm/pull/788)
* Simplify and update README in [fpm#778](https://github.com/fortran-lang/fpm/pull/778)
* Add C++ flags to profiles in [fpm#786](https://github.com/fortran-lang/fpm/pull/786)
* fix 32-bit platform issues with M\_CLI2 in [fpm#796](https://github.com/fortran-lang/fpm/pull/796)
* Fix missing space before -D option for preprocessor in [fpm#804](https://github.com/fortran-lang/fpm/pull/804)
* Do not pass in quotes in manifest tests in [fpm#806](https://github.com/fortran-lang/fpm/pull/806)
* Improve error handling for invalid ``git`` dependencies in [fpm#797](https://github.com/fortran-lang/fpm/pull/797)
* Lower windows check precedence in ``get_os_type`` function in [fpm#802](https://github.com/fortran-lang/fpm/pull/802)
* Fix broken links to webpage in [fpm#826](https://github.com/fortran-lang/fpm/pull/826)
* Consistently call ``execute_command_line`` from the ``run`` wrapper in [fpm#832](https://github.com/fortran-lang/fpm/pull/832)
* Fix the build on macOS PPC in [fpm#824](https://github.com/fortran-lang/fpm/pull/824)
* Query latest release from GitHub in [fpm#818](https://github.com/fortran-lang/fpm/pull/818)
* Add missing dollar sign in OpenMP directive in [fpm#841](https://github.com/fortran-lang/fpm/pull/841)
* Fix query for latest release from GitHub on missing curl in [fpm#839](https://github.com/fortran-lang/fpm/pull/839) and [fpm#842](https://github.com/fortran-lang/fpm/pull/842)
* Fix unallocated model variables in the testsuite (#844) in [fpm#845](https://github.com/fortran-lang/fpm/pull/845)
* Add wait when linking library with \*.resp file in [fpm#808](https://github.com/fortran-lang/fpm/pull/808)
* Add option to enforce module naming in [fpm#828](https://github.com/fortran-lang/fpm/pull/828)
* Fix unhandled error branch in [fpm#849](https://github.com/fortran-lang/fpm/pull/849)
* Automated dependency tree update in [fpm#843](https://github.com/fortran-lang/fpm/pull/843)
* Return program's exit code from fpm run in [fpm#852](https://github.com/fortran-lang/fpm/pull/852) and [fpm#](https://github.com/fortran-lang/fpm/pull/858)
* Update gcc version to 10 for CI in [fpm#857](https://github.com/fortran-lang/fpm/pull/857)
* Fix macOS CI for fpm-bootstrap executables built with gcc-9 in [fpm#861](https://github.com/fortran-lang/fpm/pull/861)
* Update TOML Fortran to version 0.4.0 in [fpm#862](https://github.com/fortran-lang/fpm/pull/862)
* Add support for toggling Fortran features in [fpm#864](https://github.com/fortran-lang/fpm/pull/864)
* Add global configuration file and support local and remote registry [fpm#817](https://github.com/fortran-lang/fpm/pull/817)
