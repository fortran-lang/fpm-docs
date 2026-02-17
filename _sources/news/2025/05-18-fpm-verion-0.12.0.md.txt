---
author: Federico Perini, Christopher Albert, Ivan Pribec, Minh Dao
date: 2025-05-18
category: release
---

# Fpm version 0.12.0 released

The Fortran Package Manager (FPM) v0.12.0 introduces new powerful features aimed at improving interoperability, build system integration, and modular project design. The release includes continued refactoring and maintenance efforts, enhanced compiler support, and new tooling capabilities.

## Highlights

### 🔧 Build system integration via `compile_commands.json`

Projects built with `fpm` can now export a `compile_commands.json` file compatible with editors and tools like **clangd**, **VS Code**, or **CMake Tools**. This feature enables powerful code navigation, symbol indexing, and auto-completion across large Fortran codebases.

### 📦 New metapackages: BLAS/LAPACK and NetCDF

Two new [metapackages](https://fpm.fortran-lang.org/spec/metapackages.html) simplify integration with widely used scientific libraries:
- **BLAS/LAPACK** support allows linking to external high-performance libraries either when using `stdlib`.
- **NetCDF** support with a pkg-config backend.

### 🧩 Static and shared library targets

Library targets now support both `static` and `shared` output types using the `[library] type = "shared"` or `"static"` settings. This enables use cases such as plugin architectures, dynamic linking with external applications, or bundling all dependencies into a monolithic archive.

## Futher fixes and improvements

- Windows bootstrapping and Flang OpenMP syntax fixes.
- Optional user-defined flags for compiler introspection.
- `--config` flag to specify alternate configuration files.
- Expanded metapackage support: Intel MPI, SLURM `srun`, external BLAS for `stdlib`.
- Continuous improvements to modular structure and CLI argument handling.

## Changelog (selected)

- Export `compile_commands.json` by [@perazz](https://github.com/perazz) in [#1129](https://github.com/fortran-lang/fpm/pull/1129)
- [metapackage] BLAS by [@krystophny](https://github.com/krystophny) in [#1121](https://github.com/fortran-lang/fpm/pull/1121)
- [metapackage] NetCDF by [@krystophny](https://github.com/krystophny) in [#1120](https://github.com/fortran-lang/fpm/pull/1120)
- [metapackage] stdlib: enable external BLAS/LAPACK by [@perazz](https://github.com/perazz) in [#1139](https://github.com/fortran-lang/fpm/pull/1139)
- feat: `shared` and `static` library targets by [@perazz](https://github.com/perazz) in [#1138](https://github.com/fortran-lang/fpm/pull/1138)
- Enter custom path to the config file via command line by [@minhqdao](https://github.com/minhqdao) in [#945](https://github.com/fortran-lang/fpm/pull/945)

**Full changelog**: [GitHub comparison view](https://github.com/fortran-lang/fpm/compare/v0.11.0...v0.12.0)

## New contributor

We welcome [@krystophny](https://github.com/krystophny), who contributed major refactoring and introduced the NetCDF and BLAS metapackages.

## Feedback and discussion

Join the conversation and share your feedback on the [Fortran Discourse thread](https://fortran-lang.discourse.group/t/fpm-version-0-12-0-released).

