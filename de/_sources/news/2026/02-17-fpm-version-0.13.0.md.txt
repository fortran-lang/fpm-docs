---
author: Federico Perini, Christopher Albert, Damian Rouson, Jorge Luis Gálvez Vallejo, Milan Skocic, ZUO Zhihua, Albkat, Samuele Giuli
date: 2026-02-17
category: release
---

# Fpm version 0.13.0 released

The Fortran Package Manager (FPM) v0.13.0 is a major release introducing **features and profiles**, a new build customization system for conditional compilation, compiler-specific settings, and platform-dependent behavior. This release also includes CPP preprocessor source parsing, expanded Flang compiler support, multiple simultaneous library targets, and many bug fixes and improvements.

## Highlights

### 🧩 Features and profiles

fpm now supports [features and profiles](https://fpm.fortran-lang.org/spec/features.html), a powerful new build customization system. **Features** are configurable collections of package properties that can be conditionally enabled based on compiler, operating system, or user selection. **Profiles** are named collections of features activated via the `--profile` CLI flag.

```toml
[features]
debug.flags = "-g -Wall"
debug.gfortran.flags = "-fcheck=bounds"
release.flags = "-O3"
release.gfortran.flags = "-march=native"

[profiles]
debug = ["debug"]
release = ["release"]
```

```text
❯ fpm build --profile release
```

Features support platform-specific settings, dependency configuration, preprocessor macros, and more. See the [features and profiles reference](https://fpm.fortran-lang.org/spec/features.html) for full details.

- feat: add features and profiles support to fpm manifest by [@perazz](https://github.com/perazz) in [#1177](https://github.com/fortran-lang/fpm/pull/1177)
- feat: full support for features and profiles by [@perazz](https://github.com/perazz) in [#1181](https://github.com/fortran-lang/fpm/pull/1181)

### 🔍 CPP preprocessor source parsing

fpm now evaluates CPP preprocessor directives (`#ifdef`, `#ifndef`, `#if defined()`, `#if MACRO == VALUE`, `#elif`, `#else`) against manifest-defined macros during source parsing. This allows fpm to correctly resolve module dependencies based on your build configuration, without requiring a separate preprocessing step.

```toml
[preprocess.cpp]
macros = ["USE_MPI"]
```

```fortran
#ifdef USE_MPI
  use mpi_f08
#endif
```

- feat: CPP preprocessor macros: simple file parsing by [@perazz](https://github.com/perazz) in [#1179](https://github.com/fortran-lang/fpm/pull/1179)
- feat: improved macro parsing by [@perazz](https://github.com/perazz) in [#1218](https://github.com/fortran-lang/fpm/pull/1218)

### 🛠️ Flang compiler support

LLVM Flang (`flang-new`) is now a first-class compiler in fpm, with proper flag defaults and compiler identification. The `flang` command is now interpreted as LLVM Flang, and AMD's `amdflang` has been added as a supported compiler.

- feat: make flang-new a first-class citizen in fpm by [@perazz](https://github.com/perazz) in [#1174](https://github.com/fortran-lang/fpm/pull/1174)
- Interpret "flang" as LLVM flang by [@rouson](https://github.com/rouson) in [#1176](https://github.com/fortran-lang/fpm/pull/1176)
- Add amdflang to supported compilers by [@JorgeG94](https://github.com/JorgeG94) in [#1196](https://github.com/fortran-lang/fpm/pull/1196)

### 📦 Multiple library targets

Projects can now build multiple library types simultaneously by specifying an array of types in the manifest:

```toml
[library]
type = ["shared", "static"]
```

- feat: multiple simultaneous library targets by [@perazz](https://github.com/perazz) in [#1168](https://github.com/fortran-lang/fpm/pull/1168)

### 🔗 Dependency metapackage propagation

Metapackage dependencies (such as OpenMP, MPI, BLAS) are now correctly propagated through the dependency tree, ensuring that packages depending on libraries that use metapackages are built with the correct flags and link settings.

- feat: propagate dependency metapackages by [@perazz](https://github.com/perazz) in [#1220](https://github.com/fortran-lang/fpm/pull/1220)

## Further fixes and improvements

- Custom build folder support by [@perazz](https://github.com/perazz) in [#1173](https://github.com/fortran-lang/fpm/pull/1173)
- Selective `clean` functionality by [@perazz](https://github.com/perazz) in [#1171](https://github.com/fortran-lang/fpm/pull/1171)
- Custom module install directory by [@perazz](https://github.com/perazz) in [#1170](https://github.com/fortran-lang/fpm/pull/1170)
- Standardize macOS dynamic library paths using `@rpath` by [@perazz](https://github.com/perazz) in [#1146](https://github.com/fortran-lang/fpm/pull/1146)
- gcc-15 fixes: segfault on `fpm install` and metapackages by [@krystophny](https://github.com/krystophny) in [#1150](https://github.com/fortran-lang/fpm/pull/1150)
- Enable gcc-15 on macOS CI by [@perazz](https://github.com/perazz) in [#1185](https://github.com/fortran-lang/fpm/pull/1185)
- Fix `-fPIC` for C sources by [@MilanSkocic](https://github.com/MilanSkocic) in [#1206](https://github.com/fortran-lang/fpm/pull/1206)
- Remove duplicate `-fPIC` flags causing flang-new failure on Windows by [@perazz](https://github.com/perazz) in [#1225](https://github.com/fortran-lang/fpm/pull/1225)
- Skip `-fPIC` flag for flang-new on Windows MSVC targets by [@perazz](https://github.com/perazz) in [#1167](https://github.com/fortran-lang/fpm/pull/1167)
- Add thread safety (OpenMP critical) to command registration by [@zoziha](https://github.com/zoziha) in [#1143](https://github.com/fortran-lang/fpm/pull/1143)
- CLI repetition patch by [@Albkat](https://github.com/Albkat) in [#1163](https://github.com/fortran-lang/fpm/pull/1163)
- Fix package versions by [@perazz](https://github.com/perazz) in [#1154](https://github.com/fortran-lang/fpm/pull/1154)
- Optimize source parsing with `insert_lines` by [@perazz](https://github.com/perazz) in [#1221](https://github.com/fortran-lang/fpm/pull/1221)
- Add macOS ARM64 and Intel x86_64 release artifacts by [@perazz](https://github.com/perazz) in [#1227](https://github.com/fortran-lang/fpm/pull/1227)
- Fix: deallocate in `metapackage_t` destroy by [@SamueleGiuli](https://github.com/SamueleGiuli) in [#1192](https://github.com/fortran-lang/fpm/pull/1192)

## Changelog (selected)

- feat: add features and profiles support to fpm manifest by [@perazz](https://github.com/perazz) in [#1177](https://github.com/fortran-lang/fpm/pull/1177)
- feat: full support for features and profiles by [@perazz](https://github.com/perazz) in [#1181](https://github.com/fortran-lang/fpm/pull/1181)
- feat: CPP preprocessor macros: simple file parsing by [@perazz](https://github.com/perazz) in [#1179](https://github.com/fortran-lang/fpm/pull/1179)
- feat: improved macro parsing by [@perazz](https://github.com/perazz) in [#1218](https://github.com/fortran-lang/fpm/pull/1218)
- feat: make flang-new a first-class citizen in fpm by [@perazz](https://github.com/perazz) in [#1174](https://github.com/fortran-lang/fpm/pull/1174)
- Interpret "flang" as LLVM flang by [@rouson](https://github.com/rouson) in [#1176](https://github.com/fortran-lang/fpm/pull/1176)
- Add amdflang to supported compilers by [@JorgeG94](https://github.com/JorgeG94) in [#1196](https://github.com/fortran-lang/fpm/pull/1196)
- feat: multiple simultaneous library targets by [@perazz](https://github.com/perazz) in [#1168](https://github.com/fortran-lang/fpm/pull/1168)
- feat: propagate dependency metapackages by [@perazz](https://github.com/perazz) in [#1220](https://github.com/fortran-lang/fpm/pull/1220)
- feat: custom build folder by [@perazz](https://github.com/perazz) in [#1173](https://github.com/fortran-lang/fpm/pull/1173)
- feat: selective clean functionality by [@perazz](https://github.com/perazz) in [#1171](https://github.com/fortran-lang/fpm/pull/1171)
- feat: custom module install directory by [@perazz](https://github.com/perazz) in [#1170](https://github.com/fortran-lang/fpm/pull/1170)
- Standardize macOS dynamic library paths using `@rpath` by [@perazz](https://github.com/perazz) in [#1146](https://github.com/fortran-lang/fpm/pull/1146)
- gcc-15 fixes by [@krystophny](https://github.com/krystophny) in [#1150](https://github.com/fortran-lang/fpm/pull/1150)
- Fix `-fPIC` for C sources by [@MilanSkocic](https://github.com/MilanSkocic) in [#1206](https://github.com/fortran-lang/fpm/pull/1206)
- Fix: deallocate in `metapackage_t` destroy by [@SamueleGiuli](https://github.com/SamueleGiuli) in [#1192](https://github.com/fortran-lang/fpm/pull/1192)
- Add thread safety (OpenMP critical) to command registration by [@zoziha](https://github.com/zoziha) in [#1143](https://github.com/fortran-lang/fpm/pull/1143)
- CLI repetition patch by [@Albkat](https://github.com/Albkat) in [#1163](https://github.com/fortran-lang/fpm/pull/1163)
- Optimize source parsing with `insert_lines` by [@perazz](https://github.com/perazz) in [#1221](https://github.com/fortran-lang/fpm/pull/1221)
- Add macOS ARM64 and Intel x86_64 release artifacts by [@perazz](https://github.com/perazz) in [#1227](https://github.com/fortran-lang/fpm/pull/1227)

**Full changelog**: [GitHub comparison view](https://github.com/fortran-lang/fpm/compare/v0.12.0...v0.13.0)

## New contributors

We welcome the following new contributors:

- [@MilanSkocic](https://github.com/MilanSkocic) (Milan Skocic), who contributed `-fPIC` fixes for C sources.
- [@SamueleGiuli](https://github.com/SamueleGiuli) (Samuele Giuli), who fixed a memory deallocation issue in metapackages.
- [@JorgeG94](https://github.com/JorgeG94) (Jorge Galvez Vallejo), who added `amdflang` compiler support.

## Feedback and discussion

Join the conversation and share your feedback on the [Fortran Discourse thread](https://fortran-lang.discourse.group/t/fpm-version-0-13-0-released).
