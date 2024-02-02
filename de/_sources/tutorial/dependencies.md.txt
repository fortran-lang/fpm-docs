# Adding dependencies

This tutorial covers the usage of dependencies with fpm and how to reuse existing fpm projects.

## Using the standard library

We start with a new project with fpm, we want to build a command line application to read a file, find a certain pattern and replace it.
Since we do not want to write the replace function ourselves, we will use the Fortran standard library ([stdlib](https://github.com/fortran-lang/stdlib)) as dependency.
In the package manifest we define *stdlib* in the *dependencies* table:

```{literalinclude} ../../src/tutorial/dependencies/fpm.toml
:language: toml
:caption: fpm.toml
:lines: 1-6
:emphasize-lines: 4-6
```

Now we create a module with a procedure to perform the substitution.
It requires three steps:

1. reading a whole line from one unit
2. replace the pattern in the string
3. write the new string to an output

We will use the *replace\_all* function from the *stdlib\_strings* module for this purpose.
The implementation is shown here

```{literalinclude} ../../src/tutorial/dependencies/src/demo.f90
:language: fortran
:caption: src/demo.f90
```

Finally, we need a command line driver to make use of our new function.

```{code-block} fortran
:caption: app/main.f90
program main
  use, intrinsic :: iso_fortran_env, only : output_unit
  use demo, only : substitute
  implicit none
  character(len=256) :: pattern, replacement, input_file
  integer :: input

  call get_command_argument(1, pattern)
  call get_command_argument(2, replacement)
  call get_command_argument(3, input_file)

  open(newunit=input, file=input_file, status='old')
  call substitute(input, output_unit, trim(pattern), trim(replacement))
  close(input)
end program main
```

We can check our command line driver by running it with fpm:

```{code-block} text
:emphasize-lines: 2
❯ fpm run -- demo substitute fpm.toml
name = "substitute"
version = "0.1.0"

[dependencies]
stdlib = "*"
```


## Adding a testing framework

Before we continue implementing new features, we want to add some tests to verify that our implementation keeps working as we modify it.
A minimalist testing framework is available with [test-drive].
Since the testing framework is only required when developing the package itself, but not for other packages which might in the future make use of our modules, we add it as a development dependency.
The *test-drive* package is added in the *dev-dependencies* table as shown below

[test-drive]: https://github.com/fortran-lang/test-drive

```{literalinclude} ../../src/tutorial/dependencies/fpm.toml
:language: toml
:caption: fpm.toml
:lines: 1-10
:emphasize-lines: 7-9
```

:::{note}
For a development dependency like a testing framework we choose a strict version pin by specifying the *tag* we want to use.
:::

Now we can write a simple unit test, since our function works with units, we will create scratch units to create the input and capture the output.
For now we will add a simple one line substitution as single test case

```{literalinclude} ../../src/tutorial/dependencies/test/main.f90
:language: fortran
:caption: test/main.f90
```

We run our new test using fpm

```{code-block} text
❯ fpm test
  Starting substitute ... (1/1)
       ... substitute [PASSED]
```

Creating the scratch units for multiple unit tests will be repetitive, this kind of tasks can usually be done in a separate procedure and reused in several tests.


## Target-specific dependencies

Dependencies can also be used for specific targets only.
This can be used for adding a command line interface package, which is only used for the executable but not part of the library dependencies.

```{literalinclude} ../../src/tutorial/dependencies/fpm.toml
:language: toml
:caption: fpm.toml
:emphasize-lines: 13-14
```

We restructure our main program a bit for using [M\_CLI2] to handle the command line input.
The *unnamed* array contains all positional command line arguments, we still use the first two as pattern and replacement, and use all remaining arguments as input.
We also add an option to redirect the output.
Our final main program looks like

[M\_CLI2]: https://github.com/urbanjost/M_CLI2

```{literalinclude} ../../src/tutorial/dependencies/app/main.f90
:language: fortran
:caption: app/main.f90
```

Again we run a quick check using fpm

```{code-block} text
:emphasize-lines: 2, 12
❯ fpm run -- demo substitute fpm.toml
name = "substitute"
version = "0.1.0"

[dependencies]
stdlib = "*"

[dev-dependencies]
test-drive.git = "https://github.com/fortran-lang/test-drive"
test-drive.tag = "v0.4.0"

[[executable]]
name = "substitute"
[executable.dependencies]
M_CLI2.git = "https://github.com/urbanjost/M_CLI2"
```

The output looks as expected with two substitutions.


:::{admonition} Summary
:class: tip
In this tutorial you learned how to

- depend on another fpm project in the package manifest
- add development dependencies for testing
- use dependencies for executables
:::
