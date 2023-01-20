# Module name requirements

:::{note}
Module naming requirements only apply to packages which are uploaded to a fpm registry; by default, no naming rules are enforced for local fpm projects.
:::

The Fortran language does not support namespaces. This means that all public names (modules, but also global subroutines and functions) must be unique in the build space.
Any build which contains duplicate names will fail, because it is impossible to resolve a name to a unique object.
For this reason, the fpm registry requires all registered packages to comply with some simple naming conventions, that should apply to both the package name and all its modules.

## Fortran names: general rules

As of Fortran 2003 onward, valid Fortran names need to comply with the following rules:

- Up to 63 characters long;
- Letters are case insensitive;
- Must begin with a letter;
- Only alphanumeric characters (letters, numbers) and underscores `_` are allowed.

*Examples of invalid Fortran names:*

```{code-block} fortran
  1_package         ! Begins with #
  package$          ! Contains invalid symbol
  _package          ! Does not begin with letter
  my package        ! Contains space
```

*Examples of valid Fortran names:*

```{code-block} fortran
  my_module         ! Case insensitive: all versions valid,
  My_Module         ! but resolving to the same object
  MY_MODULE
  MyModule
  mypackage
  package_module    ! Underscores allowed
  my_package_123
```

## FPM registry names: rules for packages and modules

In order to reduce the chance of name collisions, ``all Fortran modules`` in all packages of a registry are required to begin with their package name.
The following rules apply:

### Module names

1. Must be valid Fortran names (see above).
2. Must begin with their package name
3. Having the exact same name as the package is allowed;
4. If longer, the ``default separator`` `__` between the package name chunk and what follows must be used.
5. Neither the module nor the package name shall contain the default separator sequence elsewhere.

:::{note}
The default separator is a *double* underscore, single underscores are allowed anywhere except at the end of a package name.
:::

*Valid enforced module names*

When the naming conventions are enforced, these are example modules in a package named `my_pkg` to illustrate the rules:

```{code-block} fortran

   module my_pkg        ! Global API
   module my_pkg__1     ! We can now number them
   module my_pkg__123
   module my_pkg__core
   module my_pkg__utils
   module my_pkg__with_very_long_name
```

*Invalid enforced module names*

Considering the same package `my_pkg`, the following names will be invalid according to the naming rules:

```{code-block} fortran

   module my_pkg__      ! Nothing follows the separator
   module my_pkg__1__2  ! Separator must be unique
   module my_pkg__90123456789012345678901234567890123456789012345678901234 ! 64 chars: too long
   module my_pkg__util$ ! non-Fortran name
```

### Package names

All packages in FPM registries must have unique names, hence they must abide to the following rules

1. All package names shall be valid Fortran names. (see above).
2. Package names may contain uppercase and lowercase characters, but their unique identification is made case insensitive.
3. No duplicate package names are allowed within the same namespace.

*Examples of valid package names:*

```{code-block} fortran
   my_package     ! 1 underscore allowed
   My_Package     ! same as the former
   mypackage123   ! Numbers OK
```

*Examples of invalid package names:*

```fortran
  my__package       ! Contains package__module separator
  package__         ! Contains separator
  package_          ! Ends with underscore
  my pac$age        ! Spaces and all symbols besides `_` not allowed
  _my_package       ! Does not begin with letter
  123package        ! Does not begin with letter
```

## Manifest Settings

:::{note}
Key facts:
- FPM does not apply naming requirements by default. If you want them, enable them in `fpm.toml`
- FPM registries mandatorily require them. Ensure `fpm.toml` enables them.
:::

Module naming requirements can be enabled in `fpm.toml` under the `build` section, using the boolean flag `module-naming`.
By default, `module-naming = false`, so no registry name enforcing is checked during the build.

*Example:*

```{code-block} toml
:emphasize-lines: 5
[build]
auto-executables = true
auto-examples = false
auto-tests = false
module-naming = true
external-modules = "netcdf"
```

## Guidelines

:::{note}
These are non-mandatory styling suggestions to improve code readability and uniformity.
:::

It's recommended that the public API of each package is contained in a top-level module, whose name is same as the package name.
For example, assuming a package ``DateTime`` deals with time and date in Fortran, one could have several modules deal with parts of it:

```{code-block} fortran
   module datetime__dates ; end module
   module datetime__time  ; end module
   module datetime__julian; end module
```

and a unique public API that's contained in the top-level module:

```{code-block} fortran
   module datetime
      use datetime__dates, only: [...]
      use datetime__time, only: [...]
      use datetime__julian, only: [...]
      implicit none(type,external)
      private

      ! Publish API
      public :: sub_1
      public :: fun_123

   end module datetime
```

## References

[1] Metcalf, Reid, Cohen, "[Modern Fortran Explained](https://dl.acm.org/doi/book/10.5555/2090092)", Oxford University Press.

[2] [Style Guide for Python Code](https://peps.python.org/pep-0008/#package-and-module-names)

