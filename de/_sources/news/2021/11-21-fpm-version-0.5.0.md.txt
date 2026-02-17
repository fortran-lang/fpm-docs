---
author: Carl Burkert, Sebastian Ehlert, Laurence Kedward, Sascha Klawohn, Brad Richardson, Damian Rouson, Simon Rowe, Carlos Une, John Urban, Zuo Zhihua
date: 2021-11-21
category: release
...

# Fpm version 0.5.0 released

We have a large number of bug fixes in this release and made plenty of improvements to the tooling around fpm, like the continuous delivery and the Windows installer.
New features include the possibility for better compiler/linker selection and the improved build backend (test are only build when needed, link dependencies are properly tracked).

Find the full release notes [here](https://github.com/fortran-lang/fpm/releases/tag/v0.5.0).

## Changes

- tests are only build for fpm test and not by default anymore ([#572](https://github.com/fortran-lang/fpm/pull/572))
- environment variables for setting Fortran and C compiler changed ([#549](https://github.com/fortran-lang/fpm/pull/549), [#584](https://github.com/fortran-lang/fpm/pull/584))
- add LFortran optimization flag to release profile ([#597](https://github.com/fortran-lang/fpm/pull/597))


## New features

- command line arguments for linker, archiver and C-compiler added ([#549](https://github.com/fortran-lang/fpm/pull/549))


## Fixes

- tabs are correctly expanded in source file scanning ([#521](https://github.com/fortran-lang/fpm/pull/521))
- installer script will use fpm update to avoid stale dependencies ([#557](https://github.com/fortran-lang/fpm/pull/557))
- use multiple build output directories depending on link line options ([#575](https://github.com/fortran-lang/fpm/pull/575))
- update truncated help text ([#578](https://github.com/fortran-lang/fpm/pull/578))
- fix directory removal in fpm new tests ([#579](https://github.com/fortran-lang/fpm/pull/579))
- use MSVS like commands for Intel compilers on Windows ([#590](https://github.com/fortran-lang/fpm/pull/590))
- add critical section to mkdir in backend ([#613](https://github.com/fortran-lang/fpm/pull/613))
- fix modules listing (for install) ([#612](https://github.com/fortran-lang/fpm/pull/612))
- repair --list option and correct obsolete descriptions of the --list option ([#607](https://github.com/fortran-lang/fpm/pull/607))
- fix incorrect Intel release flag on Windows
  ([#602](https://github.com/fortran-lang/fpm/pull/602))
- list names without suffix for Windows
  ([#595](https://github.com/fortran-lang/fpm/pull/595))


## Repository updates

- add files and workflow to make installer on release ([#616](https://github.com/fortran-lang/fpm/pull/616))
- issue templates added to guide reporting of bugs, package issues, feature requests and specification proposals ([#558](https://github.com/fortran-lang/fpm/pull/558))
- default branch renamed to *main* ([#565](https://github.com/fortran-lang/fpm/pull/565))
- update documentation on distributions supporting fpm, like spack and MSYS2 ([#562](https://github.com/fortran-lang/fpm/pull/562))
- new workflow to automatically generate single source fpm versions ([#563](https://github.com/fortran-lang/fpm/pull/563))
- continuous delivery of current fpm git source implemented ([#569](https://github.com/fortran-lang/fpm/pull/569), [#564](https://github.com/fortran-lang/fpm/pull/564))
- update of bootstrapping instructions ([#587](https://github.com/fortran-lang/fpm/pull/587))
- update README.md compiler, archiver, & link flags ([#598](https://github.com/fortran-lang/fpm/pull/598))


## Feedback

- [Discourse thread](https://fortran-lang.discourse.group/t/2314)
- [Twitter post](https://twitter.com/fortranlang/status/1462506491752161286)
