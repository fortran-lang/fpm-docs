---
author: Henil Panchal, Zuo Zhihua, David Pfister, Ivan Pribec, aury6623, Giannis Nikiteas, Federico Perini
date: 2025-03-10
category: release
...

# Fpm version 0.11.0 released

The latest release of the Fortran Package Manager (FPM) brings several maintenance updates, bug fixes, and performance improvements. This version also introduces new features such as support for HDF5 metapackages via `pkg_config`, enhanced parsing for abstract interfaces, and the ability to install test programs. Additionally, compliance with Fortran standards has been improved, along with better handling of Windows-specific issues and Intel Fortran Compiler (`ifx`) support.

## Important notice

Users employing [setup-fpm](https://github.com/fortran-lang/setup-fpm) for their GitHub actions should upgrade to `setup-fpm@v7` to maintain compatibility with fpm 0.11.0.

## Changelog

- Patch `toml_error` by @perazz in https://github.com/fortran-lang/fpm/pull/1011
- Fortran standard compliance fixes by @perazz in https://github.com/fortran-lang/fpm/pull/1013
- fix: add fpm_model.json to the package tarball before uploading to the registry by @henilp105 in https://github.com/fortran-lang/fpm/pull/1010
- Improve text file reading performance by @zoziha in https://github.com/fortran-lang/fpm/pull/961
- fix: #1023 gfortran-specific backslash line continuations by @henilp105 in https://github.com/fortran-lang/fpm/pull/1024
- Reorganize fpm run; fix `--example --all` by @perazz in https://github.com/fortran-lang/fpm/pull/1021
- Remove duplicate `operator(==)` interface by @perazz in https://github.com/fortran-lang/fpm/pull/1028
- Always initialize `redirect_str` to prevent memory leak by @perazz in https://github.com/fortran-lang/fpm/pull/1029
- Metapackage CI: macos-latest -> macos-12 by @perazz in https://github.com/fortran-lang/fpm/pull/1030
- Non-`main.f90` auto executables: fix in `fpm install` by @perazz in https://github.com/fortran-lang/fpm/pull/1036
- Fix: `--target` option should only run the desired target by @perazz in https://github.com/fortran-lang/fpm/pull/1038
- ci: GCC-13 has been removed from GA runners by @gnikit in https://github.com/fortran-lang/fpm/pull/1043
- Fix Bug #1047 - rename implicit interface option for lfortran by @davidpfister in https://github.com/fortran-lang/fpm/pull/1048
- Bump actions/upload-artifact from 2 to 4 by @dependabot in https://github.com/fortran-lang/fpm/pull/985
- Run all tests with user-specified runner by @perazz in https://github.com/fortran-lang/fpm/pull/1046
- Check that Fortran sources run; Robust Fortran features by @perazz in https://github.com/fortran-lang/fpm/pull/1051
- `install.sh`: always bootstrap with 0.8.0 by @perazz in https://github.com/fortran-lang/fpm/pull/1057
- CI: use setup-fortran by @perazz in https://github.com/fortran-lang/fpm/pull/1061
- Metapackages: `pkg_config` backend support; HDF5 by @perazz in https://github.com/fortran-lang/fpm/pull/1055
- Windows archiver: also search for `gcc-ar` by @perazz in https://github.com/fortran-lang/fpm/pull/1067
- HDF5 metapackage: remove unnecessary printouts by @perazz in https://github.com/fortran-lang/fpm/pull/1068
- Maintenance: fix Ubuntu metapackage CI by @perazz in https://github.com/fortran-lang/fpm/pull/1076
- Expand parsing to include abstract interfaces by @ivan-pi in https://github.com/fortran-lang/fpm/pull/1074
- Source parsing: consider `end program` with no `program` header by @perazz in https://github.com/fortran-lang/fpm/pull/1078
- Feat: option to install test programs by @perazz in https://github.com/fortran-lang/fpm/pull/1079
- Manifest: do not allow path lists in `library.source-dir`  by @perazz in https://github.com/fortran-lang/fpm/pull/1077
- update CI by @perazz in https://github.com/fortran-lang/fpm/pull/1102
- Remove unneeded `public :: operator(==)` which causes an error on ifx by @aury6623 in https://github.com/fortran-lang/fpm/pull/1095

Full Changelog: <https://github.com/fortran-lang/fpm/compare/v0.10.1...v0.11.0>

Discourse thread: <https://fortran-lang.discourse.group/t/fpm-0-11-0-released/9320>

