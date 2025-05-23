# Manifest reference

The ``fpm.toml`` file for each project is called its *manifest*.
It is written using the [TOML] format.
Every manifest file consists of the following sections:

- [*name*](#project-name):
  The name of the project
- [*version*](#project-version):
  The version of the project
- [*license*](#project-license):
  The project license
- [*maintainer*](#project-maintainer):
  Maintainer of the project
- [*author*](#project-author):
  Author of the project
- [*copyright*](#project-copyright):
  Copyright of the project
- [*description*](#project-description):
  Description of the project
- [*categories*](#project-categories):
  Categories associated with the project
- [*keywords*](#project-keywords):
  Keywords describing the project
- [*homepage*](#project-homepage):
  The project's homepage
- Build configuration:
  - [*auto-tests*](#automatic-target-discovery):
    Toggle automatic discovery of test executables
  - [*auto-examples*](#automatic-target-discovery):
    Toggle automatic discovery of example programs
  - [*auto-executables*](#automatic-target-discovery):
    Toggle automatic discovery of executables
  - [*link*](#link-external-libraries):
    Link with external dependencies
  - [*external-modules*](#use-system-installed-modules):
    Specify modules used that are not within your fpm package
- Fortran configuration:
  - [*implicit-typing*](#implicit-typing):
    Toggle default implicit typing
  - [*implicit-external*](#implicit-external):
    Toggle implicit external interfaces
  - [*source-form*](#source-form):
    Select source form for project
- Target sections:
  - [*library*](#library-configuration)
    Configuration of the library target
  - [*executable*](#executable-targets)
    Configuration of the executable targets
  - [*test*](#test-targets)
    Configuration of the test targets
- Dependency sections:
  - [*dependencies*](#specifying-dependencies):
    Project library dependencies
  - [*dev-dependencies*](#development-dependencies):
    Dependencies only needed for tests
- [*install*](#installation-configuration):
  Installation configuration
- [*preprocess*](#preprocessor-configuration)
  Preprocessor configuration
- [*extra*](#additional-free-data-field):
  Additional free data field


[TOML]: https://toml.io/


## Project name

The project name identifies the package and is used to refer to it.
It is used when listing the project as dependency for another package and the default name of the library and executable target.
Therefore, the project name must always be present.

*Example:*

```toml
name = "hello_world"
```


## Project version

The version number of the project is specified as string.
A standardized way to manage and specify versions is the [Semantic Versioning] scheme.

*Example:*

```toml
version = "1.0.0"
```

The version entry can also contain a filename relative to the project root, which contains the version number of the project

*Example:*

```toml
version = "VERSION"
```

[Semantic Versioning]: https://semver.org


## Project license

The project license field contains the license identifier.
A standardized way to specify licensing information are [SPDX] identifiers.

*Examples:*

Projects licensed under the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl-3.0-standalone.html), either version 3 or any later version, is specified as

```toml
license = "LGPL-3.0-or-later"
```

Dual licensed project under the [Apache license, version 2.0](http://www.apache.org/licenses/LICENSE-2.0) or the [MIT license](https://opensource.org/licenses/MIT) are specified as

```toml
license = "Apache-2.0 OR MIT"
```

[SPDX]: https://spdx.org/licenses/


## Project maintainer

Information on the project maintainer and means to reach out to them.

*Example:*

```toml
maintainer = "jane.doe@example.com"
```


## Project author

Information on the project author.

*Example:*

```toml
author = "Jane Doe"
```


## Project copyright

A statement clarifying the copyright status of the project.

*Example:*

```toml
copyright = "Copyright 2020 Jane Doe"
```


## Project description

The description provides a short summary on the project.
It should be plain text and not using any markup formatting.

*Example:*

```toml
description = "A short summary on this project"
```


## Project categories

The project can be associated with different categories.

*Example:*

```toml
categories = ["io"]
```


## Project keywords

The keywords field is an array of strings describing the project.

*Example:*

```toml
keywords = ["hdf5", "mpi"]
```


## Project homepage

URL to the webpage of the project.

*Example:*

```toml
homepage = "https://stdlib.fortran-lang.org"
```


## Project targets

Every fpm project can define library, executable and test targets.
Library targets are exported and useable for other projects.


### Library configuration

Defines the exported library target of the project.
A library is generated if the source directory or include directory is found in a project.
The default source and include directories are ``src`` and ``include``; these can be modified in the *library* section using the *source-dir* and *include-dir* entries.
Paths for the source and include directories are given relative to the project root and use ``/`` as path separator on all platforms.

*Example:*

```toml
[library]
source-dir = "lib"
include-dir = "inc"
```

Since `fpm v0.12.0`, a library target can be built as a **monolithic**, **static**, or **shared** library using the `[library]` table in your `fpm.toml`. The build mode is selected via the `type` key:

```toml
[library]
type = "monolithic"  # Default: single static archive bundling all code
# type = "static"     # Per-package static archives (.a or .lib)
# type = "shared"     # Per-package shared libraries (.so, .dll, .dylib)
```

### 📦 Build types

* **`monolithic`** *(default)*:
  The root package and all its dependencies are compiled into a single static archive (`.a` or `.lib`). Only the objects required for building the apps, examples, and tests are actually included in the archive; everything else is pruned.

* **`static`**:
  Each package is compiled into its own static archive. This can be used to integrate `fpm`-built libraries into other build systems at the archive level.

* **`shared`**:
  Each package is compiled into its own shared/dynamic library (`.so`, `.dll`, or `.dylib`). These are linked dynamically, enabling reuse, faster incremental builds, and smaller binaries.

### 🛠️ Platform support

* On **Windows** (including MinGW, MSVC, and Intel compilers), `fpm` also generates:

  * A `.lib` import library for each `.dll`
  * A `.def` export definition file if required by the compiler

### 📂 Installation layout

When the following setting is enabled:

```toml
[install]
library = true
```

Then all generated library files are installed to the `lib/` subdirectory of the chosen install prefix.

Naming follows the pattern:

```text
lib<package_name>.{a|so|dll|dylib}
```

This convention is versioning-friendly and platform-compatible.

#### Include directory

:::{note}
Supported in Fortran fpm only
:::

Projects which use the Fortran `include` statement or C preprocessor `#include` statement, can use the *include-dir* key to specify search directories for the included files.
*include-dir* can contain one or more directories, where multiple directories are specified using a list of strings.
Include directories from all project dependencies are passed to the compiler using the appropriate compiler flag.

*Example:*

```toml
[library]
include-dir = ["include", "third_party/include"]
```

:::{note}
*include-dir* does not currently allow using pre-built module `.mod` files
:::


### Executable targets

Executable targets are Fortran programs defined as *executable* sections.
If no executable section is specified the ``app`` directory is searched for program definitions.
For explicitly specified executables the *name* entry must always be specified.
The source directory for each executable can be adjusted in the *source-dir* entry.
Paths for the source directory are given relative to the project root and use ``/`` as path separator on all platforms.
The source file containing the program body can be specified in the *main* entry.

Executables can have their own dependencies.
See [specifying dependencies](#specifying-dependencies) for more details.

Executables can also specify their own external library dependencies.
See [external libraries](#link-external-libraries) for more details.

:::{note}
Linking against libraries is supported in Fortran fpm only
:::

*Example:*

```toml
[[executable]]
name = "app-name"
source-dir = "prog"
main = "program.f90"

[[executable]]
name = "app-tool"
link = "z"
[executable.dependencies]
helloff = { git = "https://gitlab.com/everythingfunctional/helloff.git" }
```

Specifying many separate executables can be done by using inline tables for brevity instead

```toml
executable = [
  { name = "a-prog" },
  { name = "app-tool", source-dir = "tool" },
]
```


### Example targets

Example applications for a project are defined as *example* sections.
If no example section is specified the ``example`` directory is searched for program definitions.
For explicitly specified examples the *name* entry must always be specified.
The source directory for each example can be adjusted in the *source-dir* entry.
Paths for the source directory are given relative to the project root and use ``/`` as path separator on all platforms.
The source file containing the program body can be specified in the *main* entry.

Examples can have their own dependencies.
See [specifying dependencies](#specifying-dependencies) for more details.

Examples can also specify their own external library dependencies.
See [external libraries](#link-external-libraries) for more details.

:::{note}
Linking against libraries is supported in Fortran fpm only
:::

*Example:*

```toml
[[example]]
name = "demo-app"
source-dir = "demo"
main = "program.f90"

[[example]]
name = "example-tool"
link = "z"
[example.dependencies]
helloff = { git = "https://gitlab.com/everythingfunctional/helloff.git" }
```


### Test targets

Test targets are Fortran programs defined as *test* sections.
They follow similar rules as the executable targets.
If no test section is specified the ``test`` directory is searched for program definitions.
For explicitly specified tests the *name* entry must always be specified.
The source directory for each test can be adjusted in the *source-dir* entry.
Paths for the source directory are given relative to the project root and use ``/`` as path separator on all platforms.
The source file containing the program body can be specified in the *main* entry.

Tests can have their own dependencies.
See [specifying dependencies](#specifying-dependencies) for more details.

Tests can also specify their own external library dependencies.
See [external libraries](#link-external-libraries) for more details.

:::{note}
Linking against libraries is supported in Fortran fpm only
:::

*Example:*

```toml
[[test]]
name = "test-name"
source-dir = "testing"
main = "tester.F90"

[[test]]
name = "tester"
link = ["lapack", "blas"]
[test.dependencies]
helloff = { git = "https://gitlab.com/everythingfunctional/helloff.git" }
```


## Link external libraries

:::{note}
Supported in Fortran fpm only
:::

To declare link time dependencies on external libraries a list of native libraries can be specified in the *link* entry.
Specify either one library as string or a list of strings in case several libraries should be linked.
When possible the project should only link one native library.
The list of library dependencies is exported to dependent packages.

*Example:*

To link against the zlib compression library use

```toml
[build]
link = "z"
```

When linking multiple libraries with dependencies, the order matters.
A library must appear before the libraries it depends on.

For example, since LAPACK depends on BLAS, BLAS must come later in the list:

```toml
[build]
link = ["lapack", "blas"]
```

## Use system-installed modules

To use modules that are not defined within your fpm package or its dependencies,
specify the module name using the *external-modules* key in the *build* table.

:::{important}
*fpm* cannot automatically locate external module files; it is the responsibility
of the user to specify the necessary include directories using compiler flags such that
the compiler can locate external module files during compilation.
:::

*Example:*

```toml
[build]
external-modules = "netcdf"
```

Multiple external modules can be specified as a list.

*Example:*

```toml
[build]
external-modules = ["netcdf", "h5lt"]
```

## Automatic target discovery

:::{note}
Supported in Fortran fpm only
:::

Executables and test can be discovered automatically in their default directories.
The automatic discovery recursively searches the ``app``, ``example``, and ``test`` directories for ``program`` definitions and declares them as executable, example, and test targets, respectively.
The automatic discovery is enabled by default.

To disable the automatic discovery of targets set the *auto-executables*, *auto-examples*, and *auto-tests* entry to *false*.

```toml
[build]
auto-executables = false
auto-examples = false
auto-tests = false
```


## Fortran features

Allows to enable and disable specific language features


### Implicit typing

Allows to toggle whether the default implicit typing should be used.
The default option is ``false``.

```toml
[fortran]
implicit-typing = true  # default: false
```


### Implicit external

Allows to toggle whether external interfaces can be declared implicitly.
The default option is ``false``.

```toml
[fortran]
implicit-external = true  # default: false
```


### Source form

Allows to specifiy the source form to be used for all files in the project.
Possible choices are ``"free"`` to assume all files are free form source,
``"fixed"`` to assume all files are fixed form source,
and ``"default"`` to let the compiler decide based on its own heuristics.
The default option is ``"free"``.

```toml
[fortran]
source-form = "fixed"  # default: "free"
```


## Specifying dependencies

Dependencies can be declared in the *dependencies* table in the manifest root or the [*executable*](#executable-targets) or [*test*](#test-targets) sections.
When declared in the manifest root the dependencies are exported with the project.


### Dependencies from version control systems

Dependencies can be specified by the projects git repository.

```toml
[dependencies]
toml-f = { git = "https://github.com/toml-f/toml-f" }
```

To use a specific upstream branch declare the *branch* name with

```toml
[dependencies]
toml-f = { git = "https://github.com/toml-f/toml-f", branch = "main" }
```

Alternatively, reference tags by using the *tag* entry

```toml
[dependencies]
toml-f = { git = "https://github.com/toml-f/toml-f", tag = "v0.2.1" }
```

To pin a specific revision specify the commit hash in the *rev* entry

```toml
[dependencies]
toml-f = { git = "https://github.com/toml-f/toml-f", rev = "2f5eaba" }
```

For more verbose layout use normal tables rather than inline tables to specify dependencies

```toml
[dependencies]
[dependencies.toml-f]
git = "https://github.com/toml-f/toml-f"
rev = "2f5eaba864ff630ba0c3791126a3f811b6e437f3"
```
### Dependencies from a registry

:::{note}
To enable the usage of a registry in fpm make sure you read the instructions
in the [registry section](../registry/index.md) first.
:::

#### Namespace

Packages obtained from a registry (both remote and local) are required to specify a namespace, which provides a way to uniquely identify and differentiate packages with identical names. The namespace is declared in the manifest (`fpm.toml`).

```toml
[dependencies]
my-package.namespace = "my-namespace"
```

This will prompt fpm to download the newest version of "my-package", which belongs to "my-namespace", from the registry.

#### Version

If you want to download a specific version of a package instead of the newest one available, you can specify the version (`v`) in the manifest.

```toml
[dependencies]
example-package.namespace = "example-namespace"
example-package.v = "1.0.0"
```

### Local dependencies

To declare local dependencies use the *path* entry.

```toml
[dependencies]
my-utils = { path = "utils" }
```

The local dependency path is given relative to the ``fpm.toml`` it is written to, and uses ``/`` as the path separator on all platforms.

### Dependency-specific macro setting

As of ``fpm>=0.9.1``, an array of dependency-specific macros can be passed to a single dependency from the manifest, in the same fashion as in the manifest's [preprocessor configuration](#preprocessor-configuration) table. Its `preprocess` table needs to be entered as part of the dependency entry. fpm will not check if the passed macros collide with the dependencie's own manifest, so, it is the user's responsibility to ensure that no collisions or unexpected behavior occur.
For example, one can control the `REAL` precision that one library is to be used with:

```toml
[dependencies]
fftpack = { git="https://github.com/fortran-lang/fftpack.git", preprocess.cpp.macros = ["REAL32"] }
```

### Development dependencies

Development dependencies allow to declare *dev-dependencies* in the manifest root, which are available to all tests but not exported with the project.


## Installation configuration

In the *install* section components for the installation can be selected.
By default only executables are installed, library projects can set the *library* boolean to also installatation the module files and the archive.

*Example*

```toml
[install]
library = true
```

## Preprocessor configuration

Under the *preprocess* section, you can specify one or more preprocessor to use in an fpm project.

### Specifying the preprocessor

The *preprocess* section allows one or more preprocessors to be specified.
For example, ```cpp``` can be specified like this :

*Example*

```toml
[preprocess]
[preprocess.cpp]
```

To use multiple preprocessors, for example ```cpp``` and ```fypp```, specify them like this:

*Example*

```toml
[preprocess]
[preprocess.cpp]
[preprocess.fypp]
```

You can also specify source file suffixes that the preprocessor should run on:

*Example*

```toml
[preprocess]
[preprocess.cpp]
suffixes = ["F90", "f90"]
```

Further, you can instruct the preprocessor to run on source files in specific directories:

*Example*

```toml
[preprocess]
[preprocess.cpp]
directories = ["src/feature1", "src/models"]
```

Preprocessor macros can be defined like this:

*Example*

```toml
[preprocess]
[preprocess.cpp]
macros = ["FOO", "BAR"]
```

We can also use dotted keys to define our preprocessor settings.

*Example*

```toml
[preprocess]
cpp.suffixes = ["F90", "f90"]
cpp.directories = ["src/feature1", "src/models"]
cpp.macros = ["FOO", "BAR"]
```

We can also define valued macros in preprocess table.

*Example*
```toml
[preprocess]
[preprocess.cpp]
macros=["FOO=2", "BAR=4"]
```

We can also reuse values like version number from manifest as a value for a macro.

*Example*
```toml
version = "1"

[preprocess]
[preprocess.cpp]
macros=["VERSION={version}"]
```

## Additional free data field

Third-party tools can store their configuration inside the *extra* section.
This section will never be evaluated by fpm itself, the only constraint imposed is that it has to be valid TOML.

Since the format of this section is free, only recommendations are provided here for adding data to the *extra* section.

1. Only use subtables, never add configuration data to the top level of the *extra* section.
   Reasoning: different tools can avoid collisions of key names by placing their data in separate subtables.
2. Use the concrete name of the tool rather than a generic name for the subtable.
   Reasoning: different formatter or linter tools might use conflicting keywords in a *format* or *lint* subtable.
   Also, users can tell from the table name which tool is preferred to use with the project.
3. Fpm plugins should use a subtable with their plugin name in the *extra.fpm* section to store their data.
   Reasoning: following this convention provides the user of fpm plugins with one section to configure their used plugins.
4. Use the fpm preferred style for keywords which is lowercase with dashes.
   Reasoning: while there is no style check in this section, a consistent style in the whole manifest will make it easier for the user to understand the whole package manifest.

Feedback for the recommendations above is very much welcome.
If you have a tool that uses the *extra* section in the package manifest, feel free to post it in at the [fpm discussion board](https://github.com/fortran-lang/fpm/discussions).
