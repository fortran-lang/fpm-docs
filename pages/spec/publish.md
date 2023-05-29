# Package upload

Packages can be uploaded to the [official registry](https://registry-frontend.vercel.app) using the `fpm publish` command. After a successful upload, users can search for the package and use it in their projects. But be aware that the upload is permanent. Once a package is uploaded, it cannot be deleted. If you want to make changes to a package, you will have to create a new version of the package and upload that.

fpm version 0.8.2 and higher is required to upload packages to the registry.

:::{note}
We are currently building and testing the registry. All uploaded packages will be deleted after the testing period (in June 2023)
:::

## Prerequisites

### Register

Before you can upload a package, you need to have an account on the official registry. You can create an account by visiting the [registry website](https://registry-frontend.vercel.app).

### Namespace

A package must be uploaded to a given namespace. If you don't have a namespace yet, you need to create one on the website first. A user can have multiple namespaces and a namespace can accomodate multiple packages.

### Token

After having created a namespace, you will need to generate a token to upload a package to that namespace. You can do this on the website as well. The token is used to authenticate the upload and is linked to your username. Do not share the token with anyone else. The token also expires after a certain amount of time. You can generate a new token after the old one has expired.

### Version

A package must specify a valid [semver](https://semver.org/) version in its manifest.

You can check the version of the package by running `fpm publish --show-package-version` before publishing.

### License

A package must specify a valid [SPDX](https://spdx.org/licenses/) license in its manifest.

### Upload rights

Users can upload a package to a namespace if they are either an admin or maintainer of the namespace or a maintainer of the package. Namespace admins can grant namespace admin and maintainer rights to other users. Users can be granted maintainer rights for individual packages by namespace admins, maintainers, and package maintainers.

## Uploading

fpm will create a tarball and upload the package to the registry with all the requirements being met.

### Show package version

To check the version of the package, run `fpm publish --show-package-version`.

### Show uploaded data

You can see all the data being sent to the registry without uploading by running `fpm publish --show-upload-data`. The token will be included if you specify it on the command line (`fpm publish --show-upload-data --token <token>`).

### Dry run

A dry run can be performed with `fpm publish --dry-run --token <token>`. This will create the tarball and simulate the upload without publishing the package to the registry. You will be provided with the path to the locally created tarball for your inspection.

### Publishing

To publish a package, run `fpm publish --token <token>` using the token you generated on the website.