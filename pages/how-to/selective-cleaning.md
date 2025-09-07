# Selective cleaning with fpm

:::{note}
Available since fpm v0.14.0
:::

The `fpm clean` command allows you to remove build artifacts to free up disk space or ensure a fresh build. By default, `fpm clean` removes all build artifacts, but you can use selective cleaning to remove only specific types of executables, which speeds up recompilation by preserving other build outputs.

## Command overview

The selective cleaning feature provides three flags to target specific executable types:

- `--test`: Clean only test executables
- `--apps`: Clean only application executables  
- `--examples`: Clean only example executables

## Basic usage

### Clean test executables only

```bash
fpm clean --test
```

This removes only the compiled test executables while preserving application executables, example executables, and all object files. Useful when you've modified test code and want to ensure tests are rebuilt from scratch.

### Clean application executables only

```bash
fpm clean --apps
```

This removes only the compiled application executables while preserving test executables, example executables, and object files. Useful when you've made changes that affect only your main applications.

### Clean example executables only

```bash
fpm clean --examples
```

This removes only the compiled example executables while preserving application and test executables, and object files. Useful when working on documentation examples.

## Combining flags

You can combine multiple flags to clean several types of executables simultaneously:

```bash
# Clean both test and application executables
fpm clean --test --apps

# Clean all executable types (equivalent to targeting all executables)
fpm clean --test --apps --examples
```

## Practical use cases

### Debugging failing tests

When tests are failing and you suspect cached executables might be the issue:

```bash
fpm clean --test
fpm test
```

This ensures test executables are rebuilt from scratch while preserving your application builds.

### Preparing for release

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

## Comparison with full cleaning

| Command | What gets removed | Use when |
|---------|------------------|----------|
| `fpm clean` | All build artifacts | Starting completely fresh, major build system changes |
| `fpm clean --test` | Test executables only | Test-specific issues, modified test code |
| `fpm clean --apps` | Application executables only | Application-specific changes |
| `fpm clean --examples` | Example executables only | Documentation updates, example modifications |

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