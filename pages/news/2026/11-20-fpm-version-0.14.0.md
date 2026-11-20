---
author: Federico Perini, Christopher Albert, Shubham Padkonde, Zainab Travadi, Chaitanya Bhardwaj, Damian Rouson, Jorge Luis Gálvez Vallejo, Sarthak Shreshtha, ShryukGrandhi, Alastair McKinstry, Dan Bonachea, Ali, Shubham Bhardwaj, Yuki, Izaak "Zaak" Beekman
date: 2026-11-20
category: release
---

# Fpm version 0.14.0 released

The Fortran Package Manager (FPM) v0.14.0 is a release about **faster and more reliable builds**. The release binaries now build packages in parallel, with a new `--jobs` option to control how many targets build at once. Incremental builds now recompile everything a change affects. More compilers can build fpm itself and the packages it manages, and there are new release binaries for Linux ARM64 and self-contained ones for macOS.

## Highlights

### ⚡ Parallel builds out of the box

The fpm release binaries are now built with OpenMP, so fpm compiles, links and archives independent targets at the same time. `fpm --version` reports whether your fpm runs in parallel:

```text
❯ fpm --version
Version:     0.14.0, alpha
...
Parallel:    OpenMP, 10 threads
```

By default fpm uses `OMP_NUM_THREADS` if it is set, and all cores otherwise. The new `--jobs`/`-j` option of `build`, `run`, `test` and `install`, or the `FPM_JOBS` environment variable, sets the number of parallel jobs without changing `OMP_NUM_THREADS` for the programs fpm runs:

```text
❯ fpm build -j 4
❯ fpm test -j 1      # one target at a time
```

Compiler, linker and archiver commands now start directly through `posix_spawn` or `CreateProcess` instead of a shell, which makes running them from many threads safe, on macOS too. fpm processes that run at the same time on one package now wait for each other through a lock on the build directory instead of compiling the same files at once.

To build fpm from source with OpenMP, use `fpm install --features openmp`. `install.sh` now does this by default, and takes `--no-openmp` to turn it off.

- ci: ship parallel (OpenMP-enabled) fpm release artifacts by [@zbeekman](https://github.com/zbeekman) in [#1281](https://github.com/fortran-lang/fpm/pull/1281)
- feat: add --jobs/-j to set the number of parallel build jobs by [@perazz](https://github.com/perazz) in [#1388](https://github.com/fortran-lang/fpm/pull/1388)
- feat: lock the build directory against concurrent fpm runs by [@perazz](https://github.com/perazz) in [#1390](https://github.com/fortran-lang/fpm/pull/1390)
- feat: exec Fortran compiles via argv (posix_spawn/CreateProcess) by [@krystophny](https://github.com/krystophny) in [#1299](https://github.com/fortran-lang/fpm/pull/1299)
- feat: run link and archive in parallel via argv spawn by [@krystophny](https://github.com/krystophny) in [#1300](https://github.com/fortran-lang/fpm/pull/1300)
- feat: exec C/C++ compiles via argv, close the shell-fork gap by [@krystophny](https://github.com/krystophny) in [#1301](https://github.com/fortran-lang/fpm/pull/1301)
- refactor: share argv command building and running across compile and link by [@perazz](https://github.com/perazz) in [#1371](https://github.com/fortran-lang/fpm/pull/1371)
- refactor: serialize shell commands inside run() by [@perazz](https://github.com/perazz) in [#1372](https://github.com/fortran-lang/fpm/pull/1372)

### 🔁 Incremental builds that rebuild what changed

fpm now recompiles every target that a change affects, including after a failed or interrupted build:

- targets whose dependencies were rebuilt since their own last build are rebuilt too, so apps and tests no longer keep old module code;
- a source is recompiled when a file it `include`s changes;
- static archives are rebuilt from scratch, so the object of a moved or renamed source no longer shadows the new one at link time;
- a cached dependency is resolved again when its local `path` changes.

- fix: rebuild targets whose dependencies changed since their last build by [@perazz](https://github.com/perazz) in [#1363](https://github.com/fortran-lang/fpm/pull/1363)
- fix: rebuild sources when their included files change by [@perazz](https://github.com/perazz) in [#1402](https://github.com/fortran-lang/fpm/pull/1402)
- fix: rebuild static archives from scratch by [@perazz](https://github.com/perazz) in [#1360](https://github.com/fortran-lang/fpm/pull/1360)
- fix: re-resolve a cached dependency when its local path changes by [@krystophny](https://github.com/krystophny) in [#1395](https://github.com/fortran-lang/fpm/pull/1395)
- fix(targets): per-profile build dirs for archive, shared, and exe targets by [@perazz](https://github.com/perazz) in [#1286](https://github.com/fortran-lang/fpm/pull/1286)
- fix feature caching in fpm by [@JorgeG94](https://github.com/JorgeG94) in [#1320](https://github.com/fortran-lang/fpm/pull/1320)

### 🛠️ More compilers

LLVM Flang and NAG can now build fpm itself and the packages it manages, and fpm builds packages with AOCC, whose `flang` is classic flang. A gfortran 15 and 16 miscompilation that hung fpm on Windows is avoided, and LFortran, amdflang and Intel on Windows get flag fixes.

- Fix: make an elemental subprogram impure so flang builds fpm by [@rouson](https://github.com/rouson) in [#1318](https://github.com/fortran-lang/fpm/pull/1318)
- fix: build fpm with nagfor, and build packages with it by [@perazz](https://github.com/perazz) in [#1397](https://github.com/fortran-lang/fpm/pull/1397)
- build(nag): rm headerpad flags for nagfor on macOS by [@rouson](https://github.com/rouson) in [#1312](https://github.com/fortran-lang/fpm/pull/1312)
- fix: build with AOCC, whose flang is classic flang by [@perazz](https://github.com/perazz) in [#1392](https://github.com/fortran-lang/fpm/pull/1392)
- fix: detect amdflang before flang and enable its OpenMP flag by [@ShryukGrandhi](https://github.com/ShryukGrandhi) in [#1387](https://github.com/fortran-lang/fpm/pull/1387)
- fix: avoid class array allocations that gfortran 15+ leaves without a rank by [@perazz](https://github.com/perazz) in [#1352](https://github.com/fortran-lang/fpm/pull/1352)
- Fix: lfortran release flag and Windows ifx variant mapping by [@gha3mi](https://github.com/gha3mi) in [#1249](https://github.com/fortran-lang/fpm/pull/1249)
- fix: lfortran uses '--shared' not '-shared' by [@amckinstry](https://github.com/amckinstry) in [#1280](https://github.com/fortran-lang/fpm/pull/1280)
- Keep Unix Intel debug flags off Windows by [@Sarthak-Shreshtha01](https://github.com/Sarthak-Shreshtha01) in [#1342](https://github.com/fortran-lang/fpm/pull/1342)
- fix(compiler): use /OUT: for a user-set lib archiver, set os_type first by [@perazz](https://github.com/perazz) in [#1389](https://github.com/fortran-lang/fpm/pull/1389)

### 📦 Release binaries for more platforms

The release now includes a static Linux ARM64 binary, so ARM64 runners and machines no longer need to build fpm from source. The macOS binaries link the GCC runtimes statically and run on any Mac, without Homebrew's GCC. The single-file source `fpm.F90` and the source archive `fpm.zip` also come with `.sha256` checksums in the `current` pre-release.

- ci: ship a static Linux ARM64 release binary by [@perazz](https://github.com/perazz) in [#1400](https://github.com/fortran-lang/fpm/pull/1400)
- ci: link GCC runtimes statically into the macOS release artifacts by [@yuki-nishikawa](https://github.com/yuki-nishikawa) in [#1333](https://github.com/fortran-lang/fpm/pull/1333)
- ci: checksum fpm.F90 and fpm.zip in the current prerelease by [@perazz](https://github.com/perazz) in [#1401](https://github.com/fortran-lang/fpm/pull/1401)

### 🔍 More accurate source parsing

fpm reads the module dependencies of more sources correctly:

- `use` statements followed directly by a comment;
- module names that contain an intrinsic module name;
- indented `#if defined()` and `#elif` blocks;
- `module procedure::name`;
- include directories with spaces in their names.

- Fix parsing of USE statements with inline comments without whitespace by [@ZainabTravadi](https://github.com/ZainabTravadi) in [#1272](https://github.com/fortran-lang/fpm/pull/1272)
- Fix false intrinsic module detection for substring matches in USE parsing by [@ZainabTravadi](https://github.com/ZainabTravadi) in [#1274](https://github.com/fortran-lang/fpm/pull/1274)
- fix(source-parsing): correct macro extraction for indented #if defined() by [@krystophny](https://github.com/krystophny) in [#1284](https://github.com/fortran-lang/fpm/pull/1284)
- fix: restore parser active state after #elif conditional blocks by [@chaitanya-bhardwaj](https://github.com/chaitanya-bhardwaj) in [#1340](https://github.com/fortran-lang/fpm/pull/1340)
- fix: do not read `module procedure::name` as a module statement by [@perazz](https://github.com/perazz) in [#1358](https://github.com/fortran-lang/fpm/pull/1358)
- fix: preserve include directories containing spaces by [@krystophny](https://github.com/krystophny) in [#1339](https://github.com/fortran-lang/fpm/pull/1339)

## Further fixes and improvements

- Reject positional arguments in subcommands that take none by [@perazz](https://github.com/perazz) in [#1364](https://github.com/fortran-lang/fpm/pull/1364)
- Better error message from `fpm run` by [@perazz](https://github.com/perazz) in [#1303](https://github.com/fortran-lang/fpm/pull/1303)
- Keep `--verbose` commands on one line with any compiler by [@perazz](https://github.com/perazz) in [#1406](https://github.com/fortran-lang/fpm/pull/1406)
- `fpm clean` uses `--build-dir` and `FPM_BUILD_DIR` by [@perazz](https://github.com/perazz) in [#1410](https://github.com/fortran-lang/fpm/pull/1410)
- Stop without the runtime's stop code or IEEE exception notes by [@perazz](https://github.com/perazz) in [#1412](https://github.com/fortran-lang/fpm/pull/1412)
- Declare `--config-file` for `fpm export` by [@perazz](https://github.com/perazz) in [#1414](https://github.com/fortran-lang/fpm/pull/1414)
- Keep absolute local dependency paths absolute by [@perazz](https://github.com/perazz) in [#1362](https://github.com/fortran-lang/fpm/pull/1362)
- Keep quotes inside flags when compiling without a shell by [@perazz](https://github.com/perazz) in [#1391](https://github.com/fortran-lang/fpm/pull/1391)
- Allow fetch-only updates for test-only packages by [@krystophny](https://github.com/krystophny) in [#1330](https://github.com/fortran-lang/fpm/pull/1330)
- Fix a Windows crash: libgfortran restores a freed locale string on MinGW by [@perazz](https://github.com/perazz) in [#1377](https://github.com/fortran-lang/fpm/pull/1377)
- Bump jonquil and read TOML without toml-f re-opening units by [@perazz](https://github.com/perazz) in [#1374](https://github.com/fortran-lang/fpm/pull/1374)
- `delete_file` deletes through C `remove()` by [@perazz](https://github.com/perazz) in [#1379](https://github.com/fortran-lang/fpm/pull/1379)
- Lock deferred-length string results on the parallel build path by [@perazz](https://github.com/perazz) in [#1381](https://github.com/fortran-lang/fpm/pull/1381)
- Serialize the `mkdir` shell fork on the `run_command` lock by [@krystophny](https://github.com/krystophny) in [#1298](https://github.com/fortran-lang/fpm/pull/1298)
- Use native directory checks on Unix by [@krystophny](https://github.com/krystophny) in [#1291](https://github.com/fortran-lang/fpm/pull/1291)
- Create Unix directories without a shell by [@perazz](https://github.com/perazz) in [#1396](https://github.com/fortran-lang/fpm/pull/1396)
- Make manifest config allocatables polymorphic to cut the compile time of fpm by [@perazz](https://github.com/perazz) in [#1345](https://github.com/fortran-lang/fpm/pull/1345)
- Fix glob backtracking over repeated characters by [@Shubham-Padkonde](https://github.com/Shubham-Padkonde) in [#1326](https://github.com/fortran-lang/fpm/pull/1326)
- Only strip the last suffix in `basename(suffix=.false.)` by [@Shubham-Padkonde](https://github.com/Shubham-Padkonde) in [#1327](https://github.com/fortran-lang/fpm/pull/1327)
- Initialize the return code in `delete_env` by [@Shubham-Padkonde](https://github.com/Shubham-Padkonde) in [#1325](https://github.com/fortran-lang/fpm/pull/1325)
- Build the generated package in `new-test` by [@chaitanya-bhardwaj](https://github.com/chaitanya-bhardwaj) in [#1351](https://github.com/fortran-lang/fpm/pull/1351)
- Allow the LFortran unknown warning flag in tests by [@shubhambhar007](https://github.com/shubhambhar007) in [#1376](https://github.com/fortran-lang/fpm/pull/1376)
- Correct the pack source for `book2` filtering in `help_test` by [@ZainabTravadi](https://github.com/ZainabTravadi) in [#1270](https://github.com/fortran-lang/fpm/pull/1270)

## Changelog (selected)

- ci: ship parallel (OpenMP-enabled) fpm release artifacts by [@zbeekman](https://github.com/zbeekman) in [#1281](https://github.com/fortran-lang/fpm/pull/1281)
- feat: add --jobs/-j to set the number of parallel build jobs by [@perazz](https://github.com/perazz) in [#1388](https://github.com/fortran-lang/fpm/pull/1388)
- feat: lock the build directory against concurrent fpm runs by [@perazz](https://github.com/perazz) in [#1390](https://github.com/fortran-lang/fpm/pull/1390)
- feat: exec Fortran compiles via argv (posix_spawn/CreateProcess) by [@krystophny](https://github.com/krystophny) in [#1299](https://github.com/fortran-lang/fpm/pull/1299)
- feat: run link and archive in parallel via argv spawn by [@krystophny](https://github.com/krystophny) in [#1300](https://github.com/fortran-lang/fpm/pull/1300)
- feat: exec C/C++ compiles via argv, close the shell-fork gap by [@krystophny](https://github.com/krystophny) in [#1301](https://github.com/fortran-lang/fpm/pull/1301)
- fix: rebuild targets whose dependencies changed since their last build by [@perazz](https://github.com/perazz) in [#1363](https://github.com/fortran-lang/fpm/pull/1363)
- fix: rebuild sources when their included files change by [@perazz](https://github.com/perazz) in [#1402](https://github.com/fortran-lang/fpm/pull/1402)
- fix: rebuild static archives from scratch by [@perazz](https://github.com/perazz) in [#1360](https://github.com/fortran-lang/fpm/pull/1360)
- fix: re-resolve a cached dependency when its local path changes by [@krystophny](https://github.com/krystophny) in [#1395](https://github.com/fortran-lang/fpm/pull/1395)
- Fix: make an elemental subprogram impure so flang builds fpm by [@rouson](https://github.com/rouson) in [#1318](https://github.com/fortran-lang/fpm/pull/1318)
- fix: build fpm with nagfor, and build packages with it by [@perazz](https://github.com/perazz) in [#1397](https://github.com/fortran-lang/fpm/pull/1397)
- fix: build with AOCC, whose flang is classic flang by [@perazz](https://github.com/perazz) in [#1392](https://github.com/fortran-lang/fpm/pull/1392)
- fix: detect amdflang before flang and enable its OpenMP flag by [@ShryukGrandhi](https://github.com/ShryukGrandhi) in [#1387](https://github.com/fortran-lang/fpm/pull/1387)
- fix: avoid class array allocations that gfortran 15+ leaves without a rank by [@perazz](https://github.com/perazz) in [#1352](https://github.com/fortran-lang/fpm/pull/1352)
- ci: ship a static Linux ARM64 release binary by [@perazz](https://github.com/perazz) in [#1400](https://github.com/fortran-lang/fpm/pull/1400)
- ci: link GCC runtimes statically into the macOS release artifacts by [@yuki-nishikawa](https://github.com/yuki-nishikawa) in [#1333](https://github.com/fortran-lang/fpm/pull/1333)
- Fix parsing of USE statements with inline comments without whitespace by [@ZainabTravadi](https://github.com/ZainabTravadi) in [#1272](https://github.com/fortran-lang/fpm/pull/1272)
- Fix false intrinsic module detection for substring matches in USE parsing by [@ZainabTravadi](https://github.com/ZainabTravadi) in [#1274](https://github.com/fortran-lang/fpm/pull/1274)
- fix(source-parsing): correct macro extraction for indented #if defined() by [@krystophny](https://github.com/krystophny) in [#1284](https://github.com/fortran-lang/fpm/pull/1284)
- fix: restore parser active state after #elif conditional blocks by [@chaitanya-bhardwaj](https://github.com/chaitanya-bhardwaj) in [#1340](https://github.com/fortran-lang/fpm/pull/1340)
- fix: reject positional arguments in subcommands that take none by [@perazz](https://github.com/perazz) in [#1364](https://github.com/fortran-lang/fpm/pull/1364)
- fix: stop without the runtime's stop code or IEEE exception notes by [@perazz](https://github.com/perazz) in [#1412](https://github.com/fortran-lang/fpm/pull/1412)

**Full changelog**: [GitHub comparison view](https://github.com/fortran-lang/fpm/compare/v0.13.0...v0.14.0)

## New contributors

We welcome the following new contributors:

- [@gha3mi](https://github.com/gha3mi) (Ali), who fixed the LFortran release flag and the Windows ifx variant mapping.
- [@ZainabTravadi](https://github.com/ZainabTravadi) (Zainab Travadi), who fixed the parsing of `use` statements with inline comments and a false intrinsic module match.
- [@zbeekman](https://github.com/zbeekman) (Izaak "Zaak" Beekman), who made the release binaries parallel with OpenMP.
- [@amckinstry](https://github.com/amckinstry) (Alastair McKinstry), who fixed the LFortran shared library flag.
- [@bonachea](https://github.com/bonachea) (Dan Bonachea), who retired the macos-14 and gcc 11 CI build.
- [@Shubham-Padkonde](https://github.com/Shubham-Padkonde) (Shubham Padkonde), who fixed glob backtracking, `basename` and an uninitialized return code.
- [@chaitanya-bhardwaj](https://github.com/chaitanya-bhardwaj) (Chaitanya Bhardwaj), who fixed the parser state after `#elif` blocks and extended the `new` test.
- [@Sarthak-Shreshtha01](https://github.com/Sarthak-Shreshtha01) (Sarthak Shreshtha), who kept the Unix Intel debug flags off Windows.
- [@yuki-nishikawa](https://github.com/yuki-nishikawa) (Yuki), who made the macOS release binaries self-contained.
- [@ShryukGrandhi](https://github.com/ShryukGrandhi), who fixed the detection of amdflang and its OpenMP flag.
- [@shubhambhar007](https://github.com/shubhambhar007) (Shubham Bhardwaj), who fixed an LFortran test.

## Acknowledgments

This release was supported by [Lawrence Berkeley National Laboratory](https://www.lbl.gov) through [Damian Rouson](https://github.com/rouson). Thanks to [Dan Bonachea](https://github.com/bonachea), who reported many of the issues this release fixes, from LLVM Flang builds to version reporting, reviewed pull requests, and tested the release candidate with gfortran and LLVM Flang. Thanks also to [nAG](https://nag.com) for providing a temporary license of `nagfor`.

## Feedback and discussion

Join the conversation and share your feedback on the [Fortran Discourse thread](https://fortran-lang.discourse.group/t/fpm-version-0-14-0-released).
