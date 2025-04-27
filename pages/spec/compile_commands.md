# `compile_commands.json`

`fpm` automatically generates a `compile_commands.json` file during each successful build or dry run. The file is placed in the `build/` directory and provides detailed information about how each source file is compiled.

```txt
build/compile_commands.json
```

It follows the [Clang Compilation Database format](https://clang.llvm.org/docs/JSONCompilationDatabase.html), widely used by editors, IDEs, and development tools for navigation, static analysis, and diagnostics.

## Purpose

The `compile_commands.json` file enables integration with tools such as:

- Language Server Protocol (LSP) servers (e.g., `fortls`)
- Code editors (e.g., Visual Studio Code)
- Static analyzers
- Linters and formatters

These tools use it to retrieve compilation flags, include directories, and output paths automatically.

## How It Works

- Generated during `fpm build` or `fpm build --list`
- Created in `build/compile_commands.json`
- No manual configuration required
- Regenerated after each build or dry run

The `--list` option performs a dry run: it downloads dependencies and generates `compile_commands.json` without compiling any source files.

Each command is recorded as a list of parsed arguments, using:
- `shlex` on Unix and macOS
- `mslex` on Windows

This ensures correct handling of spaces, quotes, and escape characters across platforms.

## Example

A minimal entry in `compile_commands.json`:

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

## Working with the File

As a standard JSON file, it can be inspected using any JSON tool. For example, to pretty-print it:

```bash
cat build/compile_commands.json | jq .
```

## Limitations

- Only created after a successful build or dry run
- Currently not configurable via `fpm.toml`
- Overwrites any previous version during each build
- Feature available since `v0.12.0`.
