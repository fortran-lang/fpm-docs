# Module name requirements

:::{note}
Module naming requirements only apply to packages which are uploaded to a fpm registry; by default, no naming rules are enforced for local fpm projects.
:::

The Fortran language does not support namespaces. This means that all public names (modules, but also global subroutines and functions) must be unique in the build space.
Any build which contains duplicate names will fail, because it is impossible to resolve a name to a unique object.
For this reason, the fpm registry requires all registered packages to comply with some simple naming conventions, that should apply to both the package name and all its modules.



