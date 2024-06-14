# Extending fpm with plugins

The Fortran package manager has a plugin system which allows to easily extend its functionality.
This tutorial will show how to install a plugin with fpm and use it.


## Registry search tool

The [fpm-search](https://github.com/urbanjost/fpm-search) project is a plugin to query the package registry.
Since it is built with fpm we can easily install it on our system with

```{code-block} text
git clone https://github.com/urbanjost/fpm-search
cd fpm-search
fpm install --profile release
```

This will install the ``fpm-search`` binary to ``~/.local/bin`` (or ``%APPDATA%\local\bin`` on Windows).

:::::{note}
Ensure that the installed binary is in the ``PATH``, *i.e.* run

```{code-block} text
which fpm-search
~/.local/bin/fpm-search
```

If no binary is found, add the directory to your path using

::::{tab-set}
:::{tab-item} Bash (Linux)

Default settings for the bash shell can be found in the ``.bashrc`` file in the home directory, to append to the ``PATH`` following the instructions below.

```{code-block} text
echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
. ~/.bashrc
```

Make sure to source your ``.bashrc`` after changing it, otherwise the change will not be applied to the current shell.
:::
:::{tab-item} Zsh (MacOS)

Default settings for the zsh shell can be found in the ``.zshrc`` file in the home directory, to append to the ``PATH`` use

```{code-block} text
echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.zshrc
exec zsh
```

Make sure to restart zsh after changing the ``.zshrc`` it, otherwise the change will not be applied to the current shell.
:::
:::{tab-item} CMD (Windows)

The ``PATH`` variable can be modified using the pathman program from the cmd prompt

```{code-block} text
pathman /au %APPDATA%\local\bin
```
:::
::::
:::::

Now with a working installation we can invoke our new plugin from fpm.

```{code-block} text
❯ fpm search
Downloading registry ... https://github.com/fortran-lang/fpm-registry/raw/master/index.json
...
```

Note that we use ``fpm search`` rather than ``fpm-search`` in the command.
To find a package for building a command-line interface we can now type

```{code-block} text
❯ fpm search commandline
M_CLI : Unix-style commandline parsing using a prototype command and NAMELIST (STD:f2008)
M_CLI2 : Unix-style commandline parsing using a prototype command
```

To use one of the packages in our manifest we can generate the necessary dependency line by running

```{code-block} text
❯ fpm search --toml M_CLI2
M_CLI2 = { git = "https://github.com/urbanjost/M_CLI2" }
```

Adding this line to a package manifest allows to depend on the respective project.

:::{admonition} Summary
:class: tip
In this tutorial you learned how to

- installing an fpm plugin
- use the fpm-search plugin to query the registry
- generate a dependency entry from a query result
:::
