# `compile_commands.json`

`fpm` automatically generates a `compile_commands.json` file during each successful build. This file is placed in the `build/` directory and provides detailed information about how each source file in the project is compiled.

```txt
build/compile_commands.json
```

This file follows the [Clang Compilation Database format](https://clang.llvm.org/docs/JSONCompilationDatabase.html) as is widely used by code editors, IDEs, and developer tools for enhanced navigation, static analysis, and diagnostics.

## Purpose

The `compile_commands.json` file serves as a bridge between `fpm` and tooling such as:

- Language Server Protocol (LSP) servers (e.g. `fortls`)
- Code editors (e.g. Visual Studio Code)
- Static analyzers
- Code linters and formatters

These tools use `compile_commands.json` to understand compilation flags, include directories, and output paths.

## How it Works

- Automatically created during `fpm build`
- Located at `build/compile_commands.json`
- No need to configure or enable it explicitly
- Regenerated each time a build completes successfully

## Example

A minimal `compile_commands.json` entry may look like:

```json
[
  {
    "directory": "/path/to/my/fpm/package",
    "arguments": [
      "gfortran",
      "-c",
      "src/module.f90",
      "-Iinclude",
      "-Jbuild",
      "-o",
      "build/module.o"
    ],
    "file": "src/module.f90"
  }
]
```

## Integration with Tools

### Command Line Tools

`compile_commands.json` is a valid JSON file and can be inspected with any JSON tools. 
A simple way to pretty print and inspect the file from a terminal is:

```bash
cat build/compile_commands.json | jq .
```

## Limitations

- Only generated after a successful build
- Currently not configurable in `fpm.toml`
- Overwrites previous version on each new build

