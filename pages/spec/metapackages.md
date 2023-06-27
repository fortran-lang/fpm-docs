# Built-in dependencies ("Metapackages")

:::{note}
Metapackages are experimental! Please help us improve them by submitting issues to the [fpm repository](https://github.com/fortran-lang/fpm).
:::

Most real-world applications require dependencies that are not self-contained Fortran packages; but rather involve libraries with system-dependent installation steps, often provided with multiple language interfaces.
As of 0.8.3, `fpm` supports the automated discovery, and binding, of a subset of such libraries to packages via the `metapackage` feature.

Metapackages can be enabled in the manifest in the `[dependencies]` section, just by recalling their name. Here is how one enables OpenMP in a package:

```{code-block} toml
:emphasize-lines: 2
name = "my_openmp_package"
dependencies.openmp = "*"
```

which is equivalent to

```{code-block} toml
:emphasize-lines: 3
name = "my_openmp_package"
[dependencies]
openmp = "*"
```

:::{note}
Metapackages are enabled using the `"*"` wildcard, meaning _any version_, not with a boolean flag. Version requirements are not yet supported and will be introduced in a future release.
:::

Several pre-built examples can be found in `fpm`'s `example_packages/metapackage_*` folders under the fpm installation directory.

## fortran-lang Standard Library (stdlib)

This dependency automatically downloads the latest release of the [fortran-lang standard library](https://stdlib.fortran-lang.org) and adds it to the project as a git dependency.

```{code-block} toml
:emphasize-lines: 2
name = "with_stdlib"
dependencies.stdlib = "*"
```

## fortran-lang MINPACK

This dependency automatically downloads the release v2.0.0-rc1 of the modernized [fortran-lang MINPACK](https://github.com/fortran-lang/minpack) and adds it to the project as a git dependency.

```{code-block} toml
:emphasize-lines: 2
name = "with_minpack"
dependencies.minpack = "*"
```

## OpenMP

This dependency automatically adds appropriate compiler flags to enable OpenMP support compiling and running fpm targets.

```{code-block} toml
:emphasize-lines: 2
name = "my_openmp_package"
dependencies.openmp = "*"
```

## MPI

```{code-block} toml
:emphasize-lines: 2
name = "my_parallel_app"
dependencies.mpi = "*"
```

MPI is supported for Fortran, C and C++ languages. `fpm` will perform system-specific steps to find and match available MPI libraries on your system with the `fpm` compiler.
`fpm` will first search for standard MPI compiler wrappers (`mpifort`, `mpif90`, `mpif77`, `mpicc`, `mpicxx`, ...), then try to match them with the current `fpm` compiler for Fortran, C and C++.

If no wrappers are available in your path, they can be enabled setting environment variables `MPICC`, `MPICXX`, `MPIFC`, `MPIF90` or `MPIF77` in your shell.
For IntelMPI, fpm will also look up environment variables `I_MPI_CC`, `I_MPI_CXX` and `I_MPI_f90` for wrappers as well as `I_MPI_ROOT`.
When a wrapper-compiler match is found, its queried to retrieve the appropriate compiler and runner commands, as well as build and link flags.

Special steps are taken on Windows for the MSMPI package. the [MS-MPI SDK](https://learn.microsoft.com/en-us/message-passing-interface/microsoft-mpi) should be installed to enable building projects with MS-MPI support.
Furthermore, MS-MPI is only available in combination with the [MSYS2](https://www.msys2.org) GNU compiler suite and [pre-built Fortran modules](https://packages.msys2.org/package/mingw-w64-x86_64-msmpi) for MS-MPI.
The MS-MPI installation is looked up through the `MSMPI_BIN` environment variable, by searching for `mpiexec.exe` in the local path, or in the default folder, `C:\Program Files\Microsoft MPI\Bin\`.

MPI applications can be run manually using `mpirun` or `mpiexec`, or directly via fpm using the `fpm run` command. In the latter case, the MPI runner will use the default number of processes on the current node.
To customize the MPI runner command, the `--runner` and `--runner-args` options should be used, for example:

```{code-block}
./fpm run --runner=" sbatch script.sh"
./fpm run --runner-args=" -np 12 -N 2"
```

Note that `--runner` can be used to override the default runner command (`mpiexec` or `mpirun`), while `--runner-args` should be used to pass arguments to the runner itsef, e.g., the number of processes.

Currently verified system configurations are:
- MacOS/x86_64 + GCC + OpenMPI (via brew)
- MacOS/x86_64 + GCC + MPICH (via brew)
- Linux/x86_64 + GCC + OpenMPI (via apt)
- Linux/x86_64 + GCC + MPICH (via apt)
- Linux/x86_64 + Intel + IntelMPI (via apt)
- Windows/x86_64 + MinGW + MSMPI (via msys2)
- Windows/x86_64 + Intel oneAPI + IntelMPI (via offline installer)

:::{note}
MPI C++ support on macOS is missing because homebrew is built with `clang`, whose C++ ABI is incompatible with the GNU C++ ABI needed to link against gfortran.
:::

