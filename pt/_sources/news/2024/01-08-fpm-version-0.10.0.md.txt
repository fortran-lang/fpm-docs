---
author: Brad Richardson, Federico Perini, Giannis Nikiteas, urbanjost, Minh Dao
date: 2024-01-08
category: release
...

# Fpm version 0.10.0 released

The latest release of the Fortran Package Manager (FPM) showcases a range of
updates geared towards enhancing functionality and user experience.
Key improvements include significant advancements in MPI support,
now allowing the usage of MPI modules in metapackages.
On the command line interface, a `--dry-run` option for `fpm publish` has been
added, allowing users to simulate the publishing process. This release also
brings various bug fixes and performance improvements. For a full list of
changes please see below.

## Changelog

- search MPI runner in `%MS_MPI%` and `PATH` also in `get_mpi_runner` by @perazz in https://github.com/fortran-lang/fpm/pull/924
- Add `--dry-run` option to `fpm publish` by @minhqdao in https://github.com/fortran-lang/fpm/pull/918
- MPI: add `mpi` and `mpi_f08` to the list of external modules by @perazz in https://github.com/fortran-lang/fpm/pull/930
- Fix `module-naming` typo by @minhqdao in https://github.com/fortran-lang/fpm/pull/932
- Add developer documentation for run(3f) and example program by @urbanjost in https://github.com/fortran-lang/fpm/pull/933
- Allow overriding metapackages with standard dependency syntax by @perazz in https://github.com/fortran-lang/fpm/pull/928
- Parse `intrinsic` and `non_intrinsic` `use`d modules by @perazz in https://github.com/fortran-lang/fpm/pull/920
- Fix `convert_to_absolute_path` by @minhqdao in https://github.com/fortran-lang/fpm/pull/940
- remove arbitrary limit on width of input files, corrects #902 by @urbanjost in https://github.com/fortran-lang/fpm/pull/941
- Just some refactoring by @minhqdao in https://github.com/fortran-lang/fpm/pull/946
- use `clang` in lieu of `gcc` as C compiler for homebrew-openmpi action by @perazz in https://github.com/fortran-lang/fpm/pull/944
- Remove ENV_VARIABLE() as it duplicates the functionality of GET_ENV() by @urbanjost in https://github.com/fortran-lang/fpm/pull/942
- Add verbose printouts options to `git_archive` and `upload_form` by @minhqdao in https://github.com/fortran-lang/fpm/pull/938
- update jonquil version by @urbanjost in https://github.com/fortran-lang/fpm/pull/947
- Clean up clean command by @minhqdao in https://github.com/fortran-lang/fpm/pull/948
- MPI: check presence of a runner command only with `run` and `test` apps by @perazz in https://github.com/fortran-lang/fpm/pull/937
- Fix unallocated targets array by @perazz in https://github.com/fortran-lang/fpm/pull/954
- Dependency-level macro setting by @perazz in https://github.com/fortran-lang/fpm/pull/952
- Fix broken links in `README.md` by @perazz in https://github.com/fortran-lang/fpm/pull/959
- Add `-O3` optimization flags for intel compiler (release profile) by @perazz in https://github.com/fortran-lang/fpm/pull/964
- Make install script executable by @everythingfunctional in https://github.com/fortran-lang/fpm/pull/965
- MPI fixes (macOS build/link flags), oneAPI ifort->ifx switch; turn off MSMPI CI by @perazz in https://github.com/fortran-lang/fpm/pull/976
- FPM Release v0.10.0 by @gnikit in https://github.com/fortran-lang/fpm/pull/978

Full Changelog: <https://github.com/fortran-lang/fpm/compare/v0.9.0...v0.10.0>

Discourse thread: <https://fortran-lang.discourse.group/t/fpm-version-0-10-0-released/7135>
