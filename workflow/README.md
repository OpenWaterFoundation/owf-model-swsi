# workflow #

* [Folder Contents](#folder-contents)
* [Running the SWSI Analysis using the Master Copy of the Files](#running-the-swsi-analysis-using-the-master-copy-of-the-Files)
* [Running the SWSI Analysis as if Production Files](#running-the-swsi-analysis-as-if-production-files)
* [Running the SWSI Analysis in Production](#running-the-swsi-analysis-in-production)

---------

## Folder Contents ##

This folder contains the master copy of the SWSI workflow files,
which are run in order to perform the SWSI analysis.

The following are files in this folder, listed alphabetically:

| **File or Folder** | **Description** |
| -- | -- |
| `00-RunSteps01-27/` | Command file to run steps 01 to 27. |
| `00-RunSteps30-55/` | Command file to run steps 30 to 55. |
| `01-DownloadNaturalFlowTimeSeries/` | Download the natural flow time series. |
| `02-DownloadReservoirStorageTimeSeries/` | Download the reservoir storage time series. |
| `04-DownloadNaturalFlowForecastTimeSeries/` | Download the natural flow forecast time series. |
| `20-CheckRawTimeSeries/` | Check the raw time series that were downloaded for missing data. |
| `25-FillDataAuto/` | Fill the input time series using automated processes. |
| `27-FillDataManual/` | Fill the input time series using manually-provided data. |
| `30-CreateTimeSeriesForSWSI/` | Create the SWSI component time series based on stations used for each HUC. |
| `50-CalculateSWSI-HUC/` | Calculate the SWSI for HUC-8 basins. |
| `55-CalculateSWSI-Basin/` | Calculate the SWSI for larger basins (e.g., South Platte). |
| `60-OptionalSteps/` | Optional extra steps to compare with NRCS. |
| `CO-SWSI-Control.xlsx` | Control file used for the State of Colorado analysis (a recent version). |
| `CO-SWSI-Control-orig.xlsx` | Control file used for the State of Colorado analysis (original version developed by OWF). |
| `Input-TimeSeries-ForSWSI/` | Time series that have been filled to use as input to the SWSI analysis. |
| `Input-TimeSeries-Raw/` | Time series that are downloaded from the original sources. |
| `README.md` | This file. |
| `Results-Web/` | SWSI results that are created to publish on the web. |

## Running the SWSI Analysis using the Master Copy of the Files ##

The analysis can be run using the files in this folder,
for example to do development and troubleshooting of the core SWSI command files.
This avoids extra steps of creating a distribution installer,
but care must be taken to not change files prior to packaging for distribution.
All dynamic files will be ignored from the repository.
Any changes to the control file can be saved.

See the [SWSI Procedure documentation](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/co-procedure/co-procedure/)
for a description of how to perform the analysis on the master copy of the files.

## Running the SWSI Analysis as if Production Files ##

The analysis can be run using a copy of the files in the `test` folder, as if production files,
which is useful to mimic production files prior to building an installer.
All the test files will be ignored from the repository.

1. Copy the master files to a test folder using one of the following methods:
    1. Using Git Bash, run the `build-util/copy-workflow-to-test.bash` script to copy the current files
       to the main `test-months/` folder.
    2. Use Windows File Explorer to copy the folders and `CO-SWSI-Control.xslx` file to
       the `test-months` folder in a subfolder named `YYYY-MM` for a month of interest.
2. Run the analysis as if in production mode.
   See the [SWSI Procedure documentation](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/co-procedure/co-procedure/)
   for a description of how to perform the analysis on the copied files.
3. If adjustments are made to the copy and need to be incorporated in the master files,
   copy the TSTool command file(s) and control file to master files, as appropriate.

## Running the SWSI Analysis in Production ##

The analysis can be run in production, using installer files from the Open Water Foundation
[Surface Water Supply website](https://models.openwaterfoundation.org/surface-water-supply-index/).
Typically the files are downloaded once (or when a new version is available).
Subsequent analyses are typically performed by copying the previous analysis files
and following the SWSI procedure:

See the [SWSI Procedure documentation](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/co-procedure/co-procedure/)
for a description of how to perform the analysis on production files.
