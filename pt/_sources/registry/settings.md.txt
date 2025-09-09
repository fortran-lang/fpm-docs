(registry-settings)=
# Settings

The registry settings can be used to customize the registry for all projects. If no registry is specified, the packages will be fetched via HTTP from the [official registry](https://registry-frontend.vercel.app/). The registry settings are specified in the
[global configuration file](#global-configuration-file).

## Global configuration file

The global configuration file can be used to set default options across all fpm projects on the system. It is, by default, located at `~/.local/share/fpm/config.toml` on Unix-like machines and `%APPDATA%\local\fpm\config.toml` on Windows and must be parsable to a TOML structure. It can be used to configure [registry settings](#settings).

## Registry cache

The registry cache contains the source code of previously downloaded packages. It will first be searched for existing packages that satify the requirements of the requesting project before the package is downloaded. The default cache location is `~/.local/share/fpm/dependencies` on Unix-like machines and `%APPDATA%\local\fpm\dependencies` on
Windows. The location of the cache can be changed by setting the `cache_path` in the global config file:

```toml
[registry]
cache_path = "/path/to/cache"
```

## Custom registry

If you want to use a custom registry, you can specify it in the global config file:

```toml
[registry]
url = "https://my-registry.com"
```

Your registry must implement the same [API](https://registry-apis.vercel.app/apidocs/) as the official registry.

## Local registry

Use the following configuration if you want to set up a local registry:

```toml
[registry]
path = "/path/to/registry"
```

fpm will search this directory for packages and will not download packages from the internet or fetch packages from the cache.

The directory must be structured the way fpm expects it to be. A package must be located in a directory named after the namespace name, followed by the name of the package and the package version. For example, the package `my-package` with version `0.1.0`, which is part of `my-namespace`, must be located in the directory `<path_to_local_registry>/my-namespace/my-package/0.1.0` on Unix-like systems. The package directory must contain an `fpm.toml` file that has the package metadata. The manifest must therefore be located at `<path_to_local_registry>/my-namespace/my-package/0.1.0/fpm.toml`.

If a specific version is requested, fpm will look for that version in the local registry. If you do not specify a version, fpm will look for the version with the highest precedence.

For instructions on how to set up **project dependencies** in `fpm.toml` when using a registry see
