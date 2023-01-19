# Module name requirements

:::{note}
Module naming requirements only apply to packages which are uploaded to a fpm registry; by default, no naming rules are enforced for local fpm projects.
:::

The Fortran language does not support namespaces. This means that all public names (modules, but also global subroutines and functions) must be unique in the build space.
Any build which contains duplicate names will fail, because it is impossible to resolve a name to a unique object.
For this reason, the fpm registry requires all registered packages to comply with some simple naming conventions, that should apply to both the package name and all its modules.

## Fortran names

As of Fortran 2003 onward, valid Fortran names need to comply with the following rules:

- Up to 63 characters long;
- Letters are case insensitive;
- Must begin with a letter;
- Only alphanumeric characters (letters, numbers) and underscores `_` are allowed.

*Examples of invalid Fortran names: *

```fortran
  1_package    ! Begins with #
  package$     ! Contains invalid symbol
  _package     ! Does not begin with letter
  my package   ! Contains space
```

*Examples of valid Fortran names:*

```fortran
  my_package
  mypackage
  package_module
  my_package_123
```

## Rules for module names in packages

In order to reduce the chance of name collisions, ``all Fortran modules`` in all packages of the registry are required to comply with the following simple rules:

1. All package names may be translatable to Fortran. So, they're not case-sensitive, and must comply with the Fortran naming rules.
2. All module names should begin with the package name.
3.

## Guidelines

Enter guidelines here. Test.


Test again.


## References

[1] Metcalf, Reid, Cohen, "Modern Fortran Explained", Oxford University Press.

[2] [PyPI documentation](https://peps.python.org/pep-0008/#package-and-module-names)

