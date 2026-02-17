# Features and Profiles

:::{note}
Features and profiles are available starting from `fpm v0.13.0`.
:::

Features and profiles provide fine-grained control over package configuration, enabling conditional compilation, compiler-specific settings, and platform-dependent behavior.
**Features** are configurable collections of package properties that can be conditionally enabled based on compiler, operating system, or user selection.
**Profiles** are named collections of features that can be activated together via the `--profile` CLI flag.

## Quick start

A minimal example with debug and release profiles:

```{literalinclude} ../../src/spec/features/basic.toml
:language: toml
:caption: fpm.toml
```

Build with a profile:

```{code-block} text
❯ fpm build --profile debug
❯ fpm build --profile release
```

## CLI usage

Features and profiles are activated through command-line flags.

### Using profiles

Activate a profile with the `--profile` flag:

```{code-block} text
❯ fpm build --profile release
```

The profile name can be a built-in profile (`debug` or `release`) or a custom profile defined in your manifest.

### Using features

Activate individual features with the `--features` flag:

```{code-block} text
❯ fpm build --features mpi,openmp
```

Provide a comma-separated list of feature names (no spaces).

### Mutual exclusivity

The `--profile` and `--features` flags cannot be used together:

```{code-block} text
# ERROR: Cannot use both flags
❯ fpm build --profile release --features mpi

# Use a profile that includes everything
❯ fpm build --profile parallel-mpi

# Or list all features explicitly
❯ fpm build --features release,mpi
```

### Combining with other flags

Features and profiles work with all fpm commands:

```{code-block} text
❯ fpm build --compiler gfortran --profile release
❯ fpm test --profile ci --runner "mpiexec -np 4"
```

## Defining features

Features are defined in the `[features]` section of the manifest using dot notation:

```toml
[features]
feature-name.property = "value"
feature-name.compiler.property = "value"
feature-name.os.property = "value"
feature-name.compiler.os.property = "value"
```

Where:
- *feature-name*: The feature identifier (required)
- *compiler*: Compiler name (optional) - see [supported compilers](#compiler-specific-features)
- *os*: Operating system (optional) - see [supported operating systems](#os-specific-features)
- *property*: The configuration property to set (required)

:::{note}
Platform specifiers (compiler and OS) can be combined in any order: `feature.compiler.os` and `feature.os.compiler` are equivalent.
:::

## Configurable properties

Features can configure all package manifest properties.

### Compiler flags

```toml
[features]
optimized.flags = "-O3 -funroll-loops"
optimized.c-flags = "-O3 -march=native"
optimized.cxx-flags = "-O3 -std=c++17"
optimized.link-time-flags = "-flto"
```

Available flag properties:
- *flags*: Fortran compiler flags
- *c-flags*: C compiler flags
- *cxx-flags*: C++ compiler flags
- *link-time-flags*: Linker flags

### Build configuration

```toml
[features]
with-netcdf.build.link = ["netcdf", "netcdff"]
with-netcdf.build.external-modules = ["netcdf"]
testing.build.auto-tests = true
```

See the [build configuration](manifest.md#link-external-libraries) section in the manifest reference.

### Fortran configuration

```toml
[features]
legacy.fortran.implicit-typing = true
fixed-form.fortran.source-form = "fixed"
```

See [Fortran features](manifest.md#fortran-features) in the manifest reference.

### Library configuration

```toml
[features]
shared-lib.library.type = "shared"
custom.library.source-dir = "lib"
custom.library.include-dir = "inc"
```

See [library configuration](manifest.md#library-configuration).

### Dependencies

Features can add dependencies:

```toml
[features]
parallel.dependencies.openmp = "*"
parallel.dependencies.mpi = "*"

json-support.dependencies.json-fortran = { git = "https://github.com/jacobwilliams/json-fortran" }

testing.dev-dependencies.test-drive = { git = "https://github.com/fortran-lang/test-drive", tag = "v0.4.0" }
```

:::{important}
Dependencies added by features are merged with the base package dependencies.
:::

### Executables, examples, and tests

```toml
[features]
demos.example = [
  { name = "demo1", source-dir = "examples", main = "demo1.f90" },
  { name = "demo2", source-dir = "examples", main = "demo2.f90" }
]

extra-tests.test = [
  { name = "integration", source-dir = "tests/integration", main = "test_integration.f90" }
]
```

### Preprocessor configuration

```toml
[features]
debug.preprocess.cpp.macros = ["DEBUG", "VERBOSE=1"]
cpp-preprocessing.preprocess.cpp.suffixes = ["F90", "f90"]
```

See [preprocessor configuration](manifest.md#preprocessor-configuration).

### Installation and metadata

```toml
[features]
install-lib.install.library = true
experimental.description = "Experimental features requiring latest compiler"
```

## Platform-specific features

Features can be targeted to specific platforms using compiler and OS selectors.

### Compiler-specific features

Target specific compilers by including the compiler name in the feature path:

```toml
[features]
optimized.flags = "-O3"
optimized.gfortran.flags = "-march=native -funroll-loops"
optimized.ifort.flags = "-xHost -unroll"
optimized.ifx.flags = "-xHost -unroll"
optimized.nvfortran.flags = "-fast"
optimized.nagfor.flags = "-O4"
```

Supported compiler names:
`gfortran`, `ifort`, `ifx`, `nvfortran`, `nagfor`, `flang`, `amdflang`, `lfortran`, `f95`, `ftn95`, `caf`, `pgfortran`, `xlf90`, `crayftn`, `lfc`

:::{note}
When a feature has both base properties and compiler-specific properties, compiler-specific settings extend (not replace) the base settings.
:::

### OS-specific features

Target specific operating systems:

```toml
[features]
platform-defs.linux.preprocess.cpp.macros = ["OS_LINUX"]
platform-defs.macos.preprocess.cpp.macros = ["OS_MACOS"]
platform-defs.windows.preprocess.cpp.macros = ["OS_WINDOWS"]

pic.linux.flags = "-fPIC"
pic.freebsd.flags = "-fPIC"
```

Supported OS names:
`linux`, `macos`, `windows`, `cygwin`, `solaris`, `freebsd`, `openbsd`

### Resolution order

When multiple feature variants match the current platform, fpm merges them in this order:

1. Base feature properties (no platform specifiers)
2. Compiler-specific properties
3. OS-specific properties
4. Combined compiler+OS properties

How properties are merged depends on their type:

- **Additive (concatenated)**: *flags*, *c-flags*, *cxx-flags*, *link-time-flags* — values from all matching variants are concatenated with spaces
- **Additive (appended)**: *dependencies*, *dev-dependencies*, *executable*, *test*, *example*, *preprocess* — arrays are appended together
- **Exclusive (first wins)**: *build*, *install*, *fortran*, *library* — can only be specified in one variant per feature; defining the same section in both a base variant and a platform-specific variant is an error

*Example:*

```toml
[features]
# 1. Applied to all platforms (base)
debug.flags = "-g"

# 2. Added when using gfortran on any OS
debug.gfortran.flags = "-Wall -fcheck=bounds"

# 3. Added when building on Linux with any compiler
debug.linux.flags = "-fPIC"

# 4. Added when using gfortran on Linux
debug.gfortran.linux.flags = "-fsanitize=address"
```

When building with gfortran on Linux, the effective flags will be:
```
-g -Wall -fcheck=bounds -fPIC -fsanitize=address
```

:::{important}
Exclusive properties like *build*, *fortran*, *library*, and *install* cannot be defined in more than one variant of the same feature. For example, setting both `myfeature.library.type` and `myfeature.linux.library.type` will produce an error.
:::

## Profiles

Profiles are named collections of features defined in the `[profiles]` section:

```toml
[profiles]
debug = ["debug"]
production = ["release", "optimized", "strip-symbols"]
parallel = ["release", "mpi", "openmp"]
```

### Built-in and default profiles

fpm provides two built-in profiles: `debug` and `release`. If not explicitly defined in the manifest, these profiles use optimized default compiler flags (e.g. `-O2 -g` for debug, `-O3` for release with gfortran).

When you define `debug` or `release` profiles in your manifest, your definitions fully replace the built-in defaults. This is backward-compatible: projects without a `[profiles]` section continue using the same flags as before.

```toml
[profiles]
# Override the built-in debug profile
debug = ["debug", "verbose", "strict-checks"]

# Override the built-in release profile
release = ["release", "link-time-optimization"]
```

#### The `default` profile

A special profile named `default` can be used to define baseline features that are automatically applied alongside `debug` and `release`:

```toml
[features]
baseline.preprocess.cpp.macros = ["BASELINE"]
debug.preprocess.cpp.macros = ["DEBUG"]
release.preprocess.cpp.macros = ["RELEASE"]

[profiles]
default = ["baseline"]
debug = ["debug"]
release = ["release"]
```

The `default` profile is applied when:

- No explicit profile or features are specified (implicit debug build)
- The `debug` or `release` profile is requested (default features are applied first, then the profile features)

The `default` profile is **not** applied when:

- An explicit `--features` list is specified
- A custom profile (anything other than `debug` or `release`) is requested

This makes the `default` profile useful for settings that should always be present in standard builds, such as baseline preprocessor macros or common dependencies.

### Custom profiles

Create custom profiles for specific use cases:

```toml
[profiles]
testing = ["debug", "coverage", "test-fixtures"]
ci = ["release", "warnings-as-errors", "all-tests"]
dev-mpi = ["debug", "mpi", "verbose"]
```

## Dependency features and profiles

You can control how dependencies are built by requesting specific features or a profile from them.

### Dependency features

Activate individual features in a dependency using the *features* key:

```toml
[dependencies]
my-lib = { git = "https://github.com/user/my-lib", features = ["mpi"] }
another-lib = { path = "../another-lib", features = ["debug", "openmp"] }
```

### Dependency profiles

Alternatively, activate a named profile defined in the dependency's manifest using the *profile* key:

```toml
[dependencies]
my-lib = { git = "https://github.com/user/my-lib", profile = "parallel-mpi" }
```

:::{important}
The *features* and *profile* keys are mutually exclusive. A dependency cannot have both.
:::

### Platform-specific dependency features

Combine dependency features with platform-specific feature definitions:

```toml
[features]
linux-build.linux.dependencies.my-lib = { path = "../my-lib", features = ["linux-optimized"] }
```

## Examples

### Basic debug and release features

```{literalinclude} ../../src/spec/features/basic.toml
:language: toml
:caption: fpm.toml
```

```{code-block} text
❯ fpm build --profile debug
❯ fpm run --profile release
```

### Parallel computing features

```{literalinclude} ../../src/spec/features/parallel.toml
:language: toml
:caption: fpm.toml
```

```{code-block} text
❯ fpm build --profile parallel-mpi
❯ fpm run --profile parallel-hybrid --runner "mpiexec -np 4"
```

### Platform-dependent features

```{literalinclude} ../../src/spec/features/platform-specific.toml
:language: toml
:caption: fpm.toml
```

```{code-block} text
❯ fpm build --profile shared-library
❯ fpm build --profile maximum-performance
```

---

For more information on related topics:
- [Manifest reference](manifest.md) - Complete manifest specification
- [Metapackages](metapackages.md) - Built-in dependencies
- [Preprocessor configuration](manifest.md#preprocessor-configuration) - Preprocessor setup and CPP conditional compilation
