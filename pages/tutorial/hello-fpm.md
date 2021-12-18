# First steps with fpm

This tutorial covers the basic usage of the Fortran Package Manager (fpm) command line.
It will cover the generation of a new project and the possibility to compile a project into an executable as well as the possibility to run the resulting program.

To start a new project with fpm use the *fpm new* command

```{code-block} none
❯ fpm new first_steps
```

By default fpm creates a git repository with a dummy project in the fpm standard layout

```{code-block} none
❯ cd first_steps
❯ tree .
.
├── README.md
├── app
│   └── main.f90
├── fpm.toml
├── src
│   └── first_steps.f90
└── test
    └── check.f90

3 directories, 5 files
```

This is everything we need to start our new project.
First, we inspect the package manifest, ``fpm.toml``, which is populated with stub entries for us:

```{code-block} toml
:caption: fpm.toml
name = "first_steps"
version = "0.1.0"
license = "license"
author = "Jane Doe"
maintainer = "jane.doe@example.com"
copyright = "Copyright 2021, Jane Doe"
[build]
auto-executables = true
auto-tests = true
auto-examples = true
[install]
library = false
```

The package manifest contains all the required meta data for the new project.
Next we checkout the main executable, ``app/main.f90``, fpm has generated for us:

```{code-block} fortran
:caption: app/main.f90
program main
  use first_steps, only: say_hello
  implicit none

  call say_hello()
end program main
```

The program already uses a module from our library, which we can find in ``src/first_steps.f90``:

```{code-block} fortran
:caption: src/first_steps.f90
module first_steps
  implicit none
  private

  public :: say_hello
contains
  subroutine say_hello
    print *, "Hello, first_steps!"
  end subroutine say_hello
end module first_steps
```

We can run the executable directly with the command ``fpm run``:

```{code-block} none
❯ fpm run
...
 Hello, first_steps!
```

Similarly, fpm has already created a stub for testing, which can be invoked with ``fpm test``:

```{code-block} none
❯ fpm test
...
 Put some tests in here!
```

Fpm will automatically track changes in your project when running your project using the *run* and *test* commands.


:::{admonition} Summary
:class: tip
In this tutorial you learned how to

- create a new project from the fpm command line
- build and run your project executables with fpm
- run tests with fpm
:::
