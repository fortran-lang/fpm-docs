---
author: Lewis McMillan, Damian Rouson, Giannis Nikiteas, Laurence Kedward, Sebastian Ehlert, Zuo Zhihua, Jakub Jelínek, Arteev Raina
date: 2022-10-26
category: release
...

# Fpm version 0.7.0 released

This release introduces preprocessor support in the `fpm.toml` manifest, allowing
for preprocessor macros, file suffixes and directories where the preprocessor should run.
This feature was implemented as part of Arteev Raina's Google Summer of Code 2022 project.
Furthermore, fpm has now the ability to compile C++ source files in addition to Fortran and C.
Finally, the ability to define compiler profiles in the `fpm.toml` manifest has been added,
although the profile settings are not currently used in the build process.

Find the full release notes [here](https://github.com/fortran-lang/fpm/releases/tag/v0.7.0).

Many thanks to
Lewis McMillan ([@lewisfish](https://github.com/lewisfish)),
Damian Rouson ([@rouson](https://github.com/rouson)),
Giannis Nikiteas ([@gnikit](https://github.com/gnikit)),
Laurence Kedward ([@LKedward](https://github.com/LKedward)),
Sebastian Ehlert ([@awvwgk](https://github.com/awvwgk)),
Zuo Zhihua ([@zoziha](https://github.com/zoziha)),
Jakub Jelínek ([@kubajj](https://github.com/kubajj)),
Arteev Raina ([@arteevraina](https://github.com/arteevraina))
for contributing patches to this release.

## Changelog

- feat: added basic preprocess table configuration by in <https://github.com/fortran-lang/fpm/pull/715>
- Add homebrew installation instructions to README.md by in <https://github.com/fortran-lang/fpm/pull/718>
- Some cleanups and minor fixes by in <https://github.com/fortran-lang/fpm/pull/701>
- feat: ability to read macros from manifest by in <https://github.com/fortran-lang/fpm/pull/720>
- Support for dependency path relative to the fpm.toml it’s written in by in <https://github.com/fortran-lang/fpm/pull/719>
- feat: added support for C++ files compilation by in <https://github.com/fortran-lang/fpm/pull/733>
- Fix executables linking by in <https://github.com/fortran-lang/fpm/pull/743>
- Change git directory using work-tree / git-dir by in <https://github.com/fortran-lang/fpm/pull/747>
- Fix #734: First resolve dependencies, then resolve programs by in <https://github.com/fortran-lang/fpm/pull/737>
- docs(README): improve Homebrew references by in <https://github.com/fortran-lang/fpm/pull/745>
- Minor fix for `fpm new` by in <https://github.com/fortran-lang/fpm/pull/739>
- docs: updated example packages README with new packages that were added by in <https://github.com/fortran-lang/fpm/pull/740>
- Enable profiles in toml by in <https://github.com/fortran-lang/fpm/pull/653>
- Updated URL to manifest file in help section by in <https://github.com/fortran-lang/fpm/pull/755>
- Fix compilation with NAG by in <https://github.com/fortran-lang/fpm/pull/753>
- Fixes #756: add judgement of macros allocation status by in <https://github.com/fortran-lang/fpm/pull/762>
- In the default case of command line subcommands, stop `fpm` running in time by in <https://github.com/fortran-lang/fpm/pull/728>
- Disallow C-style escaping for IBM XL compiler by in <https://github.com/fortran-lang/fpm/pull/764>
- bug: C preprocessor does not propagate directives to executables by in <https://github.com/fortran-lang/fpm/pull/775>
- bug: macros don't propage to C executables by in <https://github.com/fortran-lang/fpm/pull/779>
- Enable cpp preprocessor flag for dependencies by in <https://github.com/fortran-lang/fpm/pull/783>
- Bump version to 0.7.0 by in <https://github.com/fortran-lang/fpm/pull/785>
