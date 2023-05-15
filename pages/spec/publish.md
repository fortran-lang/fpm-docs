# Package upload

Packages can be uploaded to the [official registry](https://registry-frontend.vercel.app) using the `fpm publish` command. After a successful upload, users can search for the package and use it in their projects. But be aware that the upload is permanent. Once a package is uploaded, it cannot be deleted. If you want to make changes to a package, you will have to create a new version of the package and upload that.

**!!! Testing period – We are currently building and testing the registry. All uploaded packages will be deleted after the testing period (in June 2023) !!!**

## Prerequisites

### Register

Before you can upload a package, you need to have an account on the official registry. You can create an account by visiting the [registry website](https://registry-frontend.vercel.app).

### Namespace

A package must be uploaded to a given namespace. If you don't have a namespace yet, you need to create one on the website first.

### Token

You need to generate a token for the namespace. You can do this on the website as well. The token is used to authenticate the upload. Do not share the token with anyone else. The token also expires after a certain amount of time. If you need to upload a package again, you will need to generate a new token.

### Version

A package must specify a valid [semver](https://semver.org/) version in its manifest.

You can check the version of the package by running `fpm publish --show-package-version` before publishing.

### License

A package must specify a valid [SPDX](https://spdx.org/licenses/) license in its manifest.

### Upload rights

A package can only be uploaded by package admins and maintainers. Package admins can grant admin and maintainer rights to other users.

## Uploading

fpm will create a tarball and upload the package to the registry when all the requirements are met. You can see all the data being sent to the registry without uploading by running `fpm publish --show-form-data`.

To publish a package, run `fpm publish --token <token>` using the token you generated on the website.