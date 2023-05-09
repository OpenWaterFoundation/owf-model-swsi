# 01-DownloadColoradoProducts #

See the online documentation that explains how to download the SWSI configuration file
prepared by State of Colorado Staff.

The `workflow/CO-SWSI-Control.xlsx` file for the month should be overwritten with
the downloaded file and will control the analysis for the month,
including providing data to fill gaps.

The contents of this folder can be organized to help manage downloaded files,
for example by creating YYYY-MM subfolders as follows:

```
01-DownloadColoradoProducts/
  2023-01/
    DWR_4035453.zip
```

Because each monthly workflow only requires a single State of Colorado download,
the dated folder is not required.
However, if the workflow files are copied forward when initializing new months,
the dated folders will organize previously-downloaded files and will help avoid confusion because
the files from the State of Colorado are not named using the date.
