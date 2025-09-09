# Cleaning build artifacts with fpm

The `fpm clean` command allows you to remove build artifacts to free up disk space or ensure a fresh build. This guide covers both general cleaning and selective cleaning options.

## Overview

By default, `fpm clean` prompts for confirmation before deleting directories in the `build/` folder while preserving dependencies. The command supports several modes of operation:

- **Interactive cleaning** (default): Prompts for confirmation
- **Automatic cleaning**: Skip prompts with `--skip` or `--all`  
- **Selective cleaning** *(fpm v0.14.0+)*: Target specific executable types
- **Registry cache cleaning**: Remove cached registry data

## General cleaning options

### Default behavior

```bash
fpm clean
```

Prompts for confirmation before deleting build artifacts, excluding dependencies. This is the safest option for regular use.

### Skip confirmation, preserve dependencies

```bash
fpm clean --skip
```

Deletes build directories without prompting but preserves dependency builds. Useful in automated scripts where you want to clean your project but keep external dependencies intact.

### Clean everything including dependencies

```bash
fpm clean --all
```

Deletes all build directories without prompting, including dependencies. Use this when you need a completely fresh build environment or when dependency issues require rebuilding everything from scratch.

### Clean registry cache

```bash
fpm clean --registry-cache
```

Removes cached registry data. Useful when registry metadata becomes stale or when troubleshooting package resolution issues.

### Custom configuration file

```bash
fpm clean --config-file /path/to/config.toml
```

Use a custom global configuration file location for the clean operation.

## Selective cleaning options

:::{note}
Available since fpm v0.14.0
:::

Selective cleaning allows you to remove only specific types of executables, which speeds up recompilation by preserving other build outputs.

### Available selective cleaning flags

- `--test`: Clean only test executables
- `--apps`: Clean only application executables  
- `--examples`: Clean only example executables

### Selective cleaning examples

#### Clean test executables only

```bash
fpm clean --test
```

This removes only the compiled test executables while preserving application executables, example executables, and all object files. Useful when you've modified test code and want to ensure tests are rebuilt from scratch.

#### Clean application executables only

```bash
fpm clean --apps
```

This removes only the compiled application executables while preserving test executables, example executables, and object files. Useful when you've made changes that affect only your main applications.

#### Clean example executables only

```bash
fpm clean --examples
```

This removes only the compiled example executables while preserving application and test executables, and object files. Useful when working on documentation examples.

### Combining selective flags

You can combine multiple flags to clean several types of executables simultaneously:

```bash
# Clean both test and application executables
fpm clean --test --apps

# Clean all executable types (equivalent to targeting all executables)
fpm clean --test --apps --examples
```

## Use cases and workflows

### Common scenarios

#### Debugging failing tests

When tests are failing and you suspect cached executables might be the issue:

```bash
fpm clean --test
fpm test
```

This ensures test executables are rebuilt from scratch while preserving your application builds.

#### Preparing for release

Before building release versions of your applications:

```bash
fpm clean --apps
fpm build --release
```

This ensures your applications are built fresh while preserving test and example builds for ongoing development.

### Working on examples

When updating documentation examples:

```bash
fpm clean --examples
fpm run --example my_example
```

This rebuilds only the example you're working on without affecting your main application or tests.

### Managing disk space efficiently

For large projects where full rebuilds are time-consuming:

```bash
# Clean only what you're currently working on
fpm clean --test          # If working on tests
fpm clean --apps          # If working on applications
fpm clean --examples      # If working on examples
```

## Command reference

### Complete option summary

| Command | What gets removed | Dependencies | Prompts | Use when |
|---------|------------------|--------------|---------|----------|
| `fpm clean` | All build artifacts | Preserved | Yes | Safe interactive cleaning |
| `fpm clean --skip` | All build artifacts | Preserved | No | Automated scripts, preserve deps |
| `fpm clean --all` | All build artifacts | Removed | No | Fresh start, dependency issues |
| `fpm clean --registry-cache` | Registry cache only | N/A | No | Registry troubleshooting |
| `fpm clean --test` | Test executables only | Preserved | Variable | Test-specific issues |
| `fpm clean --apps` | Application executables only | Preserved | Variable | Application changes |
| `fpm clean --examples` | Example executables only | Preserved | Variable | Documentation updates |

### Combining options

You can combine general and selective cleaning options:

```bash
# Clean test and apps without prompting, preserve dependencies
fpm clean --skip --test --apps

# Clean everything including dependencies and registry cache
fpm clean --all --registry-cache
```

## Performance benefits

Selective cleaning provides several advantages:

- **Faster rebuilds**: Preserves object files and unmodified executables
- **Targeted workflow**: Clean only what you're working on
- **Disk space management**: Remove executables while keeping compiled objects
- **Parallel development**: Different team members can clean different components

## Best practices

1. **Use selective cleaning during development**: Avoid full `fpm clean` unless necessary
2. **Clean specific targets when troubleshooting**: If tests fail, try `fpm clean --test` first
3. **Combine with build flags**: `fpm clean --apps && fpm build --release` for release builds
4. **Clean examples regularly**: Examples often have different build requirements than main code

:::{tip}
If you're unsure which executables to clean, start with the most specific flag (e.g., `--test` if working on tests) and escalate to broader cleaning only if needed.
:::