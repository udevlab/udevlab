The User Development Lab project provides documentation and tools to help to setup an opensource based development environment for Windows, without requiring admin privileges.

1. Download GitBash from https://git-scm.com/downloads, install using the default options
1. Download VSCode from https://code.visualstudio.com/, install using the default options
1. Download Miniforge from https://github.com/conda-forge/miniforge, install using the default options

Start a Git Bash terminal window and run the following command:
```sh
$ curl -sO https://udevlab.org/setup.sh && sh setup.sh
```

## Features

- [x] VSCode preconfigured to use GitBash
- [x] GitBash configured to be used Miniconda
- [x] Some developer friend utilites like httpie and ptpython



Using [httpie]:
[httpie]: https://httpie.io/

![](images/screen.png)

Using [ptpython] console:

[ptpython]: https://github.com/prompt-toolkit/ptpython

![](images/ptpython.png)

Using the [ipython]: console:

[ipython]: https://ipython.org/

![](images/ipython.png)