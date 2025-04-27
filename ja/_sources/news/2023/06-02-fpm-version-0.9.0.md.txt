---
author: Federico Perini, Minh Dao, Giannis Nikiteas 
date: 2023-06-02
category: release
...

# Fpm version 0.9.0 released

Registry and Metapackages.

This release introduces fpm support for system-dependent packages ("metapackages"). 
Most applications require dependencies that are not self-contained Fortran packages; but rather involve libraries with system-dependent installation steps, often provided with multiple language interfaces.
To remove friction to the fpm user, as of version 0.9.0, fpm supports the automated discovery, and binding, of a subset of such libraries to packages via the `metapackage` feature.

Metapackages can be enabled in the manifest in the `[dependencies]` section, just by recalling their name. Here is how one enables OpenMP in a package:

```toml
name = "my_openmp_package"
dependencies.openmp = "*"
```

Note: the `any` (`*`) version wildcard is currently supported, not a boolean flag. Version requirements are not yet supported and will be introduced in a future release. Several pre-built examples were prepared and can be found in fpm's `example_packages/metapackage_*` folders under the [fpm installation directory](https://github.com/fortran-lang/fpm/tree/main/example_packages). More help can be found on the [fpm website](https://fpm.fortran-lang.org/en/spec/metapackages.html).

This release also includes fixes and improvements to the centralized registry functionality, and to enable fpm to be built with the Intel oneAPI compilers.

Thanks to @gnikit @arteevraina @henilp105, @minhqdao, @perazz and everyone who contributed to this release! This release was supported by the Sovereign Tech Fund ([STF](https://sovereigntechfund.de/de/)).

## Changelog

* fpm release v0.9.0 by @perazz (#922)
* Add more infos to `fpm help publish` by @minhqdao (#915)
* Fix return type in `c_realpath` by @minhqdao (#914)
* `install.sh`: fallback to 0.8.0 if in trouble fetching github by @perazz (#913)
* Not get `tmp` folder from `env` by @minhqdao (#912)
* build: changed file ext to enable preprocessor by @gnikit (#911)
* Fix failing tests with Intel compiler by @perazz (#901) 
* Metapackages by @perazz (#859)

Full Changelog: https://github.com/fortran-lang/fpm/compare/v0.8.2...v0.9.0

Discourse thread: https://fortran-lang.discourse.group/t/fpm-0-9-0-released/5900 

