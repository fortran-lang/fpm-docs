# Computing PI with OpenMP

This is a simple example of how to use OpenMP with fpm.
It is an adapted version of the OpenMP example that can be found
[here](https://github.com/gjbex/Fortran-MOOC/blob/master/source_code/computing_pi/compute_pi_omp.f90) under a
[CC-BY-4.0](https://github.com/gjbex/Fortran-MOOC/blob/master/LICENSE) license.

The code approximates the value of PI by performing parallelized numerical
integration over a quarter of the unit circle.
The code is structured as follows:

```{literalinclude} ../../src/how-to/compute-pi-openmp/app/main.f90
:language: fortran
:caption: app/main.f90
```

## Using OpenMP as a dependency

To use OpenMP in your project, you need to add the `openmp` dependency to your `fpm.toml` file:

```{literalinclude} ../../src/how-to/compute-pi-openmp/fpm.toml
:language: toml
:caption: fpm.toml
:emphasize-lines: 4-5
```

OpenMP is a _built-in dependency_ (i.e. metapackage), which means the above
syntax needs to be used. To find out more about metapackages, see [](../spec/metapackages).

## Building and running the code

To build and run the code, one can use the following commands:

```{code-block} text
❯ fpm run
Project is up to date
Iterations:            10000, PI:         3.141391477611324
Took:    0.092s, with absolute error:  2.0E-04
```

And increasing the number of iterations for the approximation while
simultaneously enabling compiler optimizations with `--profile-release`

```{code-block} text
❯ fpm run --profile-release -- 1000000000
main.f90                               done.
compute-pi-openmp                      done.
[100%] Project compiled successfully.
Iterations:       1000000000, PI:         3.141592651589789
Took:    3.511s, with absolute error:  2.0E-09
```
