# owf-model-swsi

[Introduction](#introduction)
[Repository Contents](#repository-contents)

------

## Introduction ##

This repository contains the Open Water Foundation Surface Water Supply Index (SWSI) modeling tool,
which analyzes monthly reservoir storage, snowpack, and streamflow forecast data to produce an index of water availability,
roughly -4 for extreme drought to +4 for abundant supply.
The SWSI is computed by several TSTool command files.

This repository was initialized using initial Open Water Foundation work from the original project,
was updated using the State of Colorado's SWSI files from 2022,
and is being extended to the Upper Colorado Basin and potentially other areas.
Some minor changes were made in the initial commit, such as changing TSTool command file extensions to lowercase as per current conventions.

Output files from running the analysis are not included in the repository (see `.gitignore`).
Output files exist on a local computer and can be published to the web.

## Repository Contents ##

A suggested, but not required, folder structure for the development environment is:

```
C:\Users\user\                      Windows user files.
/C/Users/user/                      Git Basin user files.
/cygdrive/C/Users/user/             Cygwin user files.
/home/user/                         Linux user files.
  owf-dev/                          OWF-related development files.
    Model-SWSI/                     SWSI model folder.
      git-repos/                    Git repositories.
        owf-model-swsi/             Git repository with SWSI workflow files.
```

The following summarizes the repository contents, and closely match the original project folder organization:

```
owf-model-swsi/
  .gitattributes                   Repository properties.
  .gitignore                       Controls which files are ignored in the repository (other .gitignore files may exist).
  doc-user-mkdocs-project/         MkDocs project for online documentation.
  Documents/                       TSTool SWSI workflow documentation.
  FromNrcs/                        Original SWSI Excel workbook files.
  FromState/                       Initial example from State of CO.
  QC/                              Quality control files to validate tool.
  Resources/                       Additional background resources.
  workflow/                        TSTool command files and folders for input/output.
```

