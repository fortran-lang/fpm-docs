---
author: Minh Dao, Federico Perini 
date: 2023-05-11
category: release
...

# Fpm version 0.8.2 released

Registry preview release.

This release introduces fpm support for uploading packages to the fpm-registry server directly from the command-line interface, via 
```fortran
fpm upload --token <token-here>
```
fpm will now interact with a web interface that will help to manage the namespaces & packages.
The release includes furhter bugfixes and extensions for C/C++ support as detailed in the changelog.

Thanks to [@minhqdao](https://github.com/minhqdao), [@perazz](https://github.com/perazz) and everyone who contributed to this release! This release was supported by the Sovereign Tech Fund ([STF](https://sovereigntechfund.de/de/)).
 
## Changelog

* Not store temporary data in .local (#900) by @minhqdao 
* Add flags to link main programs with C/C++ main (#896) by @perazz 
* replace unix with is_unix to avoid intel fpp collisions (#894) by @perazz 
* Fix bootstrapping on Windows (#892) by @minhqdao
* Improve error message for [build] structure errors (#890) by @perazz 
* Fix multiple installs (#888) by @perazz 
* Fix --show-package-version (#887) by @minhqdao 
* Update Windows CI image compiler to MinGW gfortran 10.4.0 (#881) by @perazz
* Implement fpm publish (#876) by @minhqdao 
* Automated dependency update: restore deterministic behavior (#875) by @perazz

**Full Changelog**: https://github.com/fortran-lang/fpm/compare/v0.8.1...v0.8.2

