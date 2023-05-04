# owf-model-swsi

*   [Introduction](#introduction)
*   [Repository Contents](#repository-contents)

------

## Introduction ##

This repository contains the Surface Water Supply Index (SWSI) monthly modeling tool
developed by the Open Water Foundation for the State of Colorado.
The SWSI tool analyzes monthly reservoir storage, snowpack, and streamflow forecast data to produce an index of water availability.
The index value has a range of roughly -4 for extreme drought to +4 for abundant supply.
The SWSI is computed by running several TSTool command files in sequence to download, check, and process the data.

This repository was initialized using initial Open Water Foundation work from the original project,
was updated using the State of Colorado's SWSI files from 2022,
and is being extended to the Upper Colorado Basin and potentially other areas.
Some minor changes were made in the initial commit, such as changing TSTool command file extensions to lowercase
as per current file naming conventions.

Output files from running the analysis are not included in the repository (see `.gitignore`).
Output files exist on a local computer and can be published to the web, such as cloud-hosted storage and website.

The SWSI workflow in this repository should be run in the `test` or `test-babbitt` folder.

See the following:

*   [Latest documentation (at the Open Water Foundation)](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/)
*   [Surface Water Supply Index download web page (at the Open Water Foundation)](https://models.openwaterfoundation.org/surface-water-supply-index/)

## Repository Contents ##

A suggested, but not required, folder structure for the development environment is as follows,
which recognizes the hierarchy of file ownership and technical focus:

```
C:\Users\user\                      Windows user files.
/C/Users/user/                      Git Basin user files.
/cygdrive/C/Users/user/             Cygwin user files.
/home/user/                         Linux user files.
  owf-dev/                          OWF-related development files.
    Model-SWSI/                     SWSI model folder.
      git-repos/                    Git repositories.
================== above is recommended (or similar) ===================
        owf-model-swsi/             Git repository with SWSI workflow files.
```

The following summarizes the repository contents.

```
owf-model-swsi/
  .gitattributes                   Repository properties.
  .gitignore                       Controls which files are ignored in the repository.
                                   Other .gitignore files are found in other folders.
  doc-user-mkdocs-project/         MkDocs project for online documentation.
  test/                            Folder used for testing within the repository (mimics deployed files).
  test-babbitt/                    Folder used to test the Babbitt Center indicators use case (mimics deployed files).
  workflow/                        TSTool command files and folders for input/output
                                   for the State of Colorado SWSI (development files).
  workflow-babbitt/                Additional workflow steps used with the
                                   Babbitt Center indicators use case (development files).
```
