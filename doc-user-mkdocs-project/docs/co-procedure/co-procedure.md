# Surface Water Supply Index / Colorado SWSI Procedure #

* [Introduction](#introduction)
* [Colorado SWSI Automation Tool Step-by-Step Procedures](#colorado-swsi-automation-tool-step-by-step-procedures)
    + [To modify the methodology in the control file](#to-modify-the-methodology-in-the-control-file)
    + [To run the monthly SWSI analysis](#to-run-the-monthly-swsi-analysis)
        - [Set up activities](#set-up-activities)
        - [Run the TSTool processing steps](#run-the-tstool-processing-steps)
        - [Review and disseminate the output products](#review-and-disseminate-the-output-products)
    + [To run Colorado SWSI Re-forecasts](#to-run-colorado-swsi-re-forecasts)
        - [Optional: Compare Colorado Forecast SWSI Values to NRCS Forecast SWSI Values](#optional-compare-colorado-forecast-swsi-values-to-nrcs-forecast-swsi-values)

-----------

## Introduction ##

This chapter presents step-by-step procedures for a practitioner running the Colorado SWSI Automation Tool.
Additional details of the process are documented in
[Appendix C – Colorado SWSI Automation Tool Workflow Details](../appendix-c/colorado-swsi-workflow-details.md).

## Colorado SWSI Automation Tool Step-by-Step Procedures ##

### To modify the methodology in the control file ###

1. Open the master version of the Excel file named `CO-SWSI-Control.xlsx`.
2. The ***Config*** worksheet contains properties needed to run the analysis.
   Properties highlighted in blue are entered by the user.
    1. The ***NumberOfBasins*** property specifies the number of river basins that are processed.
       This property is used for automated error checking.
       If basins are added or removed, this property should be updated.
    2. The ***NumberOfHUCs*** property specifies the number of HUCs that are processed.
       This property is used for automated error checking.
       If HUCs are added or removed, this property should be updated.
    3. The ***RecentPeriodFlowType*** property determines how the forecasted runoff component is treated in the recent period.
       To run a typical monthly analysis and generate historical SWSI values in the recent period,
       this property should be set to `NaturalFlow`.
       To run a re-forecast analysis and generate forecast SWSIs in the forecast period,
       this property should be set to `ForecastedNaturalFlow`.
3. The ***Combined Inputs*** worksheet specifies all station information necessary to run the Colorado SWSI analysis by HUC and river basin.
    1. To include or exclude stations from the HUC analysis, set the ***Include*** column to `YES` or `NO`, respectively.
    2. To use observed flows for the previous month’s streamflow for a station, set the ***Include*** column to `YES-OBS`.
        1. If the observed flow option is being used, consider whether all natural flow stations in the HUC should use observed flows.
    3. To include or exclude stations from the Basin analysis, set the ***Basinwide Analysis*** column to `YES` or `NO`, respectively.
    4. To change a data source for a natural flow station:
        1. The only option is to set all ***Datastore*** options to use the NRCS AWDB web services to obtain SRVO data.
    5. To use observed flow data for a natural flow station:
        1. The ***Datastore*** options should be retained to use the NRCS AWDB web services to obtain SRVO data.
           These data are used in the forecasted runoff component.
        2. The ***Datastore2*** options should be set up to obtain data from the ColoradoWaterHBGuest datastore.
        3. The ***Datastore3*** options can be set up to obtain data from the ColoradoWaterSMS datastore.
    6. To change a data source for a forecasted natural flow station:
        1. The only option is to set all ***Datastore*** options to use the NRCS AWDB web services to obtain SRVO forecast data.
    5. To change a data source for a reservoir storage station:
        1. The default option is to set all ***Datastore*** options to use the NRCS AWDB web services to obtain RESC data.
        2. Alternatively, the ***Datastore*** options can be set to use the ColoradoWaterSMS web services to obtain STORAGE data.
        3. If ***Datastore*** options are changed to use ColoradoWaterSMS,
           ***Datastore2*** options can be changed to use ColoradoWaterHBGuest web services to obtain ResMeasStorage data.
4. If a station is removed from the ***Combined Inputs*** worksheet,
   it should also be removed from the filling worksheets (***FlowDataFill***, ***ReservoirDataFill***, and ***Overrides***) to avoid processing errors.
   It suffices to set the ***Include*** column to `NO`; rows do not need to be deleted.
   For flow stations, this applies to both natural flow and observed flow stations.
5. In general, changes such as adding cell comments or inserting rows or columns to the control file should not
   disrupt the TSTool process because TSTool does not generally refer to specific cell ranges.
   The exceptions to this are in the ***Overrides*** and ***Reforecast List*** worksheets.
   However, it is very important not to disrupt named cell ranges, which are used heavily in the TSTool process.
   It is good practice to make a backup of the control workbook before making changes in case an error is introduced into the process.

### To run the monthly SWSI analysis ###

#### Set up activities ####

1. **Create the current month’s analysis directory by copying the previous month’s directory.**
   The directories should be named to indicate the year and month being analyzed (`YYYY-MM`).
    1. Note: During the TSTool processing steps, output files are first removed so that,
       in the event that a step fails to create an output,
       the user will be able to detect this situation and not mistake old files for current results.
2. **Navigate to the new directory to open the control file (CO-SWSI-Control.xlsx) in Excel.**
    1. Go to the ***Config*** worksheet.
       Configuration properties that are entered by the user are highlighted in blue.
       Configuration properties that are calculated automatically are highlighted in gray.
        1. Every month, the following value should be updated:
            * ***CurrentMonthDate***
        2. If this is the first analysis of the water year,
           the following values should be reviewed and changed as necessary:
            * ***HistoricalPeriodStartDate***
            * ***HistoricalPeriodEndDate***
            * ***SMSInputPeriodStartDay***
            * ***RecentPeriodGraphStartDate***
    2. Go to the ***Overrides*** worksheet.
       Turn off last month’s override values by setting ***Include***=`NO` for any values applied to the previous month’s analysis.
       Those data values may now be available from the source agencies.
    3. Close all Excel workbooks (and any other open files in the `YYYY_MM` directory).
       The process will fail if a file is open and cannot be removed and re-written.

    #### Run the TSTool processing steps ####

3. Open the TSTool software program.
    1. The TSTool software program is installed in the folder `C:\CDSS\TSTool-XX.YY.ZZ\bin\TSTool.exe` and
       menu ***Start / CDSS / TSTool-XX.YY.ZZ***.
    2. TSTool version 11.04.03 or later is required to run the Colorado SWSI Automation Tool,
       which corresponds to the 2015 release of the tool for the State of Colorado.
       However, it is recommended that the most recent stable version is used.
       The analysis command files have been updated for TSTool version 14.3.0 to streamline the analysis and improve messages.
    3. Files with `.tstool` extension are TSTool command files that can be opened and run using TSTool.
       The TSTool command files need to be run in sequence to complete the Colorado SWSI analysis,
       with opportunities to review the inputs and results between steps.
       Table 10 summarizes the approximate run time for each step and the overall processing time.
    4. To run a TSTool command file, the user should navigate to the ***File / Open Command File*** menu option,
       browse to the command file, click ***Open*** to load the command file, and then click the ***Run All Commands*** button.
    5. After running a TSTool processing step,
       all output files created by the TSTool process will be accessible from the TSTool ***Output Files*** tab.
       Note that the control file is not created by TSTool, and therefore must be accessed through Windows File Explorer.
    6. The TSTool processing steps are linear, sequential steps. When changes are made to a particular step,
       that step needs to be rerun along with any subsequent steps in the numbered order.
       This concept is particularly important to understand during the data filling steps:
        1. In Step 25 (based on workflow folder names),
           the automated filling process always uses the raw data files from Steps 1-4 as input,
           and writes out auto-filled data files.
        2. In Step 27 (based on workflow folder names),
           the manual filling process always uses the auto-filled data from Step 25 as inputs,
           and writes out manual-filled data files.

    **<p style="text-align: center;">
    Table 10 - Approximate Run Times for TSTool Processing Steps (data from 2015)
    </p>**

    | **Step (Workflow Folder)** | **Approximate Run Time (minutes)** |
    | -- | -- |
    | 01-DownloadNaturalFlowTimeSeries | <1 |
    | 02-DownloadReservoirStorageTimeSeries | <1 |
    | 04-DownloadNaturalFlowForecastTimeSeries | <1 |
    | 20-CheckRawTimeSeries | <1 |
    | 25-FillDataAuto | 1 |
    | 27-FillDataManual | 1 |
    | 30-CreateTimeSeriesForSWSI | <1 |
    | 50-CalculateSWSI-HUC | 20 |
    | 55-CalculateSWSI-Basin | 5 |
    | Total Processing Time (required steps only) | 35 |
    | 60a-CompareHistSWSI-NRCS | <1 |
    | 60b-GenerateCurrentSummaries | 10 |
    | 60c-CompareFcstSWSI-NRCS | <1 |
    | Total Processing Time (with additional steps) | 47 |

    Note: Rather than running TSTool steps 01-27 separately (based on workflow folder names),
    the command file in the `00-RunSteps01-27.tstool` folder can be used to run multiple steps.

4. **Download the raw input data:**
   All available data are downloaded to ensure that a full archive of data is kept for the month’s analysis,
   and to minimize the need for subsequent downloads during the analysis.
   Input data are downloaded for each station listed in the control file on the ***Combined Inputs***
   worksheet without consideration of which HUC or Basin will use the data.
   Station data are downloaded once and can then be used in multiple HUCs.
    1. **Download natural flow time series (and observed flow time series, if being used):**
        1. Open the `01-DownloadNaturalFlowTimeSeries.tstool` command file in TSTool.
            * In the command list, there may be a warning at the bottom of the command file indicating
              that the `Input file does not exist: "YYYY-MM\Input-TimeSeries-Raw\NaturalFlow\ObservedFlow-Month.dv.`
              This file is not created if observed flow are not being used, so this warning can be disregarded.
        2. Click ***Run All Commands.***
        3. When the run is finished, click on the ***Problems*** tab.
            * Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
              The ***Problem*** column gives details about the severity status.
            * A ***Warning*** with a ***Problem*** of `Input file does not exist: "YYYY-MM\Input-TimeSeries-Raw\NaturalFlow\ObservedFlow-Month.dv`
              is OK if observed flow data are not being used in the analysis.
            * A ***Warning*** with a ***Problem*** of `For the natural flow data type, HUC ${HUCID} is assigned a mixture of observed and natural flow stations`
              is OK if this situation was intentional.
              Otherwise, the user can go to the Combined Inputs worksheet in the control file and specify
              that all natural flow stations for a given HUC use observed flow data.
            * A ***Warning*** with a ***Problem*** of `${NumStations} expected but ${NumTimeSeries} created`
              indicates that the number of time series created does not match the number of stations.
              The message will indicate if the problem is with the natural flow data from NRCS,
              the observed flow data from ColoradoWaterSMS, or the observed flow data from ColoradoWaterHBGuest.
              The data source or the data source specifications on the Combined Inputs worksheet need to be investigated.
            * A ***Warning*** with a ***Problem*** of `No data was returned for ${NumTimeSeriesDefault} stations`
              indicates that the data source specified on the ***Combined Inputs*** worksheet needs to be investigated.
              The message will indicate if the problem is with the natural flow data from NRCS,
              the observed flow data from ColoradoWaterSMS, or the observed flow data from ColoradoWaterHBGuest.
            * If changes are made in the ***Combined Inputs*** worksheet, the TSTool command file has to be re-run.
        4. The output files can be opened from the ***Output Files*** tab.
           The `Flow-Month.xlsx` workbook includes all the raw flow data. Missing values are denoted by blanks.
    2. **Download reservoir storage data:**
        1. Open the `02-DownloadReservoirStorageTimeSeries.tstool` command file in TSTool.
        2. Click ***Run All Commands***.
        3. When the run is finished, click on the ***Problems*** tab:
            * Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
              The ***Problem*** column gives details about the severity status.
            * A ***Warning*** with a ***Problem*** of `${NumTimeSeries} time series created but ${ReservoirCount} time series expected`
              indicates that the number of time series created does not match the number of reservoirs.
              The message will indicate if the problem is with the data from NRCS AWDB, ColoradoWaterSMS, or ColoradoWaterHBGuest.
              The data source or the data source specifications on the ***Combined Inputs*** worksheet need to be investigated.
            * A ***Warning*** with a ***Problem*** of `No data was returned for ${NumTimeSeries} stations` indicates that
              the data source specified on the ***Combined Inputs*** worksheet needs to be investigated.
              The message will indicate if the problem is with the NRCS AWDB, ColoradoWaterSMS, or ColoradoWaterHBGuest data.
            * If changes are made in the ***Combined Inputs*** worksheet, the TSTool command file has to be re-run.
        4. The output files can be opened from the ***Output Files*** tab.
           The `ReservoirStorage-Month.xlsx` workbook includes all the end-of-month storage data. Missing values are denoted by blanks.
    3. **Download forecasted natural flow data:**
        1. Open the `04-DownloadNaturalFlowForecast.tstool` command file in TSTool.
        2. Click ***Run All Commands***.
        3. When the run is finished, click on the ***Problems*** tab:
            * Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
              The ***Problem*** column gives details about the severity status.
            * A Warning with a ***Problem*** of `${NumTS} time series created but ${ForecastedCount} time series expected`
              indicates that the data source specified on the ***Combined Inputs*** worksheet needs to be investigated.
            * If changes are made in the ***Combined Inputs*** worksheet, the TSTool command file has to be re-run.
        4. The output files can be opened from the ***Output Files*** tab.
           The `ForecastedNaturalFlow-Month.xlsx` workbook includes all the forecasted natural flow data.
           Missing values are denoted by blanks.
5. **Analyze the raw data for missing values:**
    1. Open the `20-CheckRawTimeSeries.tstool` command file in TSTool.
    2. Click ***Run All Commands***.
    3. When the run is finished, click on the ***Problems*** tab:
        1. Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
           The ***Problem*** column gives details about the severity status.
        2. There will be a ***Warning*** with a ***Problem*** of `Severity for RunCommands (WARNING) is max of commands in command file that was run.`
           This warning is OK and simply means that warnings were generated due to missing values.
        3. There will likely be many ***Warnings*** with ***Type***=`Missing` and ***Problems*** of
           `Time series {TS_Alias} value NaN at {YYYY-MM} is missing`.
           These warnings are OK and simply mean that warnings were generated due to missing values.
    4. Use Windows File Explorer to navigate to the `20-CheckRawTimeSeries` folder.
       Open `TimeSeriesChecks.xlsx` file in Excel.
        1. On the ***Natural Flow***, ***Observed Flow***, ***Reservoir Storage***, and ***Forecasted Natural Flow*** worksheets,
           cells that contain the missing count are highlighted in red if a station has missing data.
        2. On the ***Missing Value List*** worksheet, missing values are listed by descending date.
        3. Note that during the Colorado SWSI Automation Tool development,
           the Open Water Foundation performed a significant review of the historical data and
           addressed most issues using the automated filling options.
           However, new issues may arise because of changes in data availability.
        4. On the ***Natural Flow*** worksheet, make note of any stations with missing data,
           particularly in the historical period or for the previous month.
           (The data have not yet been shifted and transformed into component values,
           so the previous month’s flow value is needed for the previous month’s streamflow component.)
           The user should determine whether missing values should be filled, and if so,
           whether automatically using regression analysis or manually using user-determined override values.
            * Note: if the user has specified to use observed flow data for the previous month’s streamflow component for a station,
              the missing counts for that station’s natural flow data will be too high.
              There is no effect on the results if the user chooses to fill unnecessary missing natural flow values;
              some of the filled data values will not be used where observed flow data are being used instead.
        5. On the ***Reservoir Storage*** worksheet, make note of any stations with missing data,
           particularly in the historical period or for the previous month.
           Determine whether missing values should be filled, and if so,
           whether automatically (using interpolation, historical monthly averages,
           or zeroes) or manually using user-determined override values.
           (Note that the data have not yet been shifted and transformed into component values,
           so the previous month’s storage value is needed for the reservoir storage component.)
        6. On the ***Forecasted Natural Flow*** worksheet, make note of any stations with missing data, particularly for the current month.
           Determine whether missing values should be filled.
           The only filling option currently implemented is user-determined override values.
        7. On the ***Observed Flow*** worksheet, make note of any stations with missing data,
           particularly in the historical period or for the previous month.
           (The data have not yet been shifted and transformed into component values,
           so the previous month’s flow value is needed for the previous month’s streamflow component.)
           The user should determine whether missing values should be filled, and if so,
           whether automatically using regression analysis or manually using user-determined override values.
        8. Open the control workbook (`CO-SWSI-Control.xlsx`) and enter new filling information (if needed) on the ***FlowDataFill***,
           ***ReservoirDataFill***, and ***Overrides*** worksheets. Note: the auto-filling indicated on the
           ***FlowDataFill*** and ***ReservoirDataFill*** worksheets will only fill values that are missing in the raw datasets.
           In contrast, the manual overrides specified on the ***Overrides*** worksheet will be used
           regardless of whether the value in the auto-filled datasets is missing or not.
        9. Close all workbooks. The process will fail if a file is open and cannot be removed and re-written.
           If the process does fail, simply close all workbooks and rerun this step. The user does not need to rerun earlier steps.
6. **Fill missing values using automated filling techniques in TSTool:**
    1. Open the `25-FillDataAuto.tstool` command file in TSTool.
        1. In the command list, warnings may be associated with the observed data files if they don’t exist.
           This is OK if observed data are not being used in the analysis.
    2. Click ***Run All Commands***.
    3. When finished running, click on the ***Problems*** tab.
        1. Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
           The ***Problem*** column gives details about the severity status.
        2. There will be a ***Warning*** with a ***Problem*** of `Severity for RunCommands (WARNING) is max of commands in command file that was run.`
           This warning is OK and simply means that warnings were generated due to missing values.
        3. There will likely be several Warnings with ***Type***=`Missing` and ***Problems*** of `Time series {TS_Alias} value NaN at {YYYY-MM} is missing`.
           These warnings are OK and simply mean that warnings were generated due to missing values.
        4. A Warning with a ***Problem*** of `${StationsCount} filling stations expected, but data read for only ${NumStationsRead} stations`
           indicates that the filling data source information specified on the flow filling worksheet needs to be investigated.
           The message will indicate whether the issue is with the natural flow filling or the observed flow filling data.
            * If changes are made on the ***FlowDataFill*** worksheet, the TSTool command file has to be re-run.
    4. To review the regression statistics from the natural flow filling,
       view the ***Tables*** tab and open the `NatFlow_RegressionStats` table. This table summarizes:
        1. The dependent station being filled (ID).
        2. The independent station used for filling (Independent_ID).
        3. Dates of available data (DependentAnalysisStart, DependentAnalysisEnd, IndependentAnalysisStart, IndependentAnalysisEnd).
        4. Period used for filling (FillStart and FillEnd).
        5. Regression statistics for each month (where the month is denoted by suffixes of _1 to _12),
           such as correlation coefficient (e.g., R_1) and coefficient of determination (e.g., R2_1).
    5. If observed data are being used, and filling is being performed on the observed flow data,
       the regression statistics will be written to the `ObsFlow_RegressionStats` table.
    6. To compare the raw and filled time series, commands are provided at the end of the command file.
       Run the commands to read the raw and filled time series.
       For a given station, select the raw and filled time series to plot using a line graph.
        1. To see the data flags, right-click on the graph and select ***Properties***.
        2. Under ***Time Series Properties***, select the ***Symbol*** tab.
        3. Select a symbol for the flagged data symbol and choose a symbol size larger than 0.
        4. Close the ***Properties*** window.
    7. Alternatively, to review the filled data using Excel, go to the ***Output Files*** tab:
        1. Open the `NaturalFlow-Month-1AutoFilled.xlsx` workbook to review the filled natural flow data.
        2. If observed data are being used, open the `ObservedFlow-Month-1AutoFilled.xlsx` workbook to review the filled observed flow data.
        3. Open the `ReservoirStorage-Month-1AutoFilled.xlsx` workbook to review the filled reservoir storage data.
        4. Missing values are denoted using blanks.
    8. Use Windows File Explorer to navigate to the `25-FillDataAuto` folder. Open `TimeSeriesChecks.xlsx` in Excel.
        1. Determine whether adjustments are needed to the auto-filling specifications.
            * If changes are made to the auto-filling specifications, this step needs to be re-run in TSTool,
              as well as all subsequent steps. Previous steps do not need to be rerun.
        2. Determine whether additional missing values should be filled using overrides.
            1. Open the control workbook (`CO-SWSI-Control.xlsx`) and enter filling information on the ***Overrides*** worksheet.
               Manual overrides can be used for any date in the historical period, recent period, or current water year,
               for example to provide data where automated filling is difficult to perform,
               or for current data that may not yet be available from web services.
            2. Note that at this point in the process, the data have not yet been time-shifted and transformed into component values.
               The manual overrides should be specified using the date stamps and data types associated with the raw data.
    9. Close all workbooks. The process will fail if a file is open and cannot be removed and re-written.
7. **Fill missing values using manual overrides specified by the user:**
    1. Open the `27-FillDataManual.tstool` command file in TSTool.
        1. In the command pane, warnings may be associated with the observed data files if they don’t exist.
           This is OK if observed data are not being used in the analysis.
    2. Click ***Run All Commands***.
    3. When finished running, click on the ***Problems*** tab.
        1. Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
           The ***Problem*** column gives details about the severity status.
        2. There will be a Warning with a ***Problem*** of `Severity for RunCommands (WARNING) is max of commands in command file that was run.`
           This warning is OK and simply means that warnings were generated due to missing values.
        3. There will likely be several ***Warnings*** with ***Type***=`Missing` and ***Problems*** of
           `Time series {TS_Alias} value NaN at {YYYY-MM} is missing`.
           These warnings are OK and simply mean that warnings were generated due to missing values.
    4. To check that the manual overrides were applied, open a filled time series as a table.
       Choose to have the flags shown as a superscript.
       Scroll to the override dates and confirm that the values and flags were set as expected.
    5. Alternatively, to review the filled data using Excel, go to the ***Output Files*** tab:
        1. Open the `Input-Data-Final.xlsx` workbook.
           This workbook contains the final input data and all data flags denoting data source, quality, and manipulations.
           Table 11 contains a list of the data flags that are used in the process.
        2. Missing values are denoted using blanks.

            **<p style="text-align: center;">
            Table 11 - Data Flags and Definitions
            </p>**

            | **Data Flag Abbreviation** | **Data Flag Description** |
            | -- | -- |
            | `R` | Value is filled using monthly linear regression. |
            | `Z` | Value is filled using 0. |
            | `RZ` | Value is filled using monthly linear regression was negative and was replaced with 0. |
            | `I` | Value is filled using linear interpolation between surrounding values. |
            | `H` | Value is filled using historical monthly averages. |
            | `MO-*` | Value is filled using manual override. |
            | `M` | Value is missing. |
            | `HB` | Value is obtained from the State of CO HydroBase database. |
            | `SMS` | Value is obtained from the State of CO Satellite Monitoring System. |
            | `E` | Value is edited (assigned by NRCS, value can be treated the same as a value without a data flag). |

    6. Use Windows File Explorer to navigate to the `27-FillDataManual folder`. Open `TimeSeriesChecks.xlsx` in Excel.
        1. Determine whether any additional missing values should be filled.
           If so, make changes to the ***FlowDataFill***, ***ReservoirDataFill***, and ***Overrides*** worksheets.
           Repeat steps 6 and 7 of this checklist as needed.
        2. Moving forward, the impacts of missing data are as follows:
            * If data are missing in the historical period,
              fewer years will be used to establish the SWSI and NEP distributions,
              and the ranges of possible SWSI and NEP values will narrow.
            * If data are missing in the recent period,
              SWSI and NEP results will also be missing in the recent period, which affects the graphical and tabular outputs.
            * If data are missing in the current month, SWSI and NEP results will also be missing.
            * The exception to this is stations where natural flow data are noted as missing,
              but are not being used because the user has elected to use observed
              streamflow for the previous month’s streamflow component.
              As long as the needed observed flow data are available, the SWSI and NEP results will be calculated.
    7. Close all Excel workbooks. The process will fail if a file is open and cannot be removed and re-written.

    Note: Rather than running TSTool steps 30-55 separately (based on workflow folder names),
    run the aggregated steps can be run using the `00-RunSteps30-50.tstool` command file.

8. **Create the SWSI component input data:**
    1. Open the `30-CreateTimeSeriesForSWSI.tstool` command file in TSTool.
        * In the command pane, warnings may be associated with the observed data files if they don’t exist.
          This is OK if observed data are not being used in the analysis.
    2. Click ***Run All Commands***.
    3. When finished running, click on the ***Problems*** tab.
        1. Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
           The ***Problem*** column gives details about the severity status.
        2. There will be a ***Warning*** with a ***Problem*** of `Severity for RunCommands (WARNING) is max of commands in command file that was run.`
           This warning is OK and simply means that warnings were generated due to missing values.
        3. There will likely be several ***Warnings*** with ***Type***=`Missing` and ***Problems*** of `Time series {TS_Alias} value NaN at {YYYY-MM} is missing`
           These warnings are OK and simply mean that warnings were generated due to missing values.
    4. If desired, scroll to the bottom of the command file and run the commands to read the raw and transformed data.
    5. From this point forward in the process, the input data have been time-shifted and transformed into component values.
    6. Use Windows File Explorer to navigate to the `30-CreateTimeSeriesForSWSI` folder. Open `TimeSeriesChecks.xlsx` in Excel.
        1. If no observed flow data are being used, the missing value information should be the same as was obtained in Step 27
           (based on workflow folder names),
           although the dates may have been time-shifted in creating the components.
        2. If observed flow data are being used, there should be fewer missing values because the program has at
           this point substituted observed flow for the previous month’s streamflow component.
    7. On the ***Output Files*** tab, open the `SWSI-Components-Data.xlsx` workbook.
       This workbook contains the final component data by station after transformations and time shifts.
       Most data flags are shown, though the forecasted runoff component no longer has data flags
       where historical natural flow data have been used, due to data accumulations.
    8. Close all workbooks. The process will fail if a file is open and cannot be removed and re-written.
9. **Calculate the SWSI results by HUC:**
    1. Open the `50-CalculateSWSI-HUC.tstool` command file in TSTool.
    2. Click ***Run All Commands***.
    3. When finished running, click on the ***Problems*** tab.
        1. Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
           The ***Problem*** column gives details about the severity status.
        2. A ***Failure*** with a ***Problem*** of `ERROR - ${HUCCount} HUCs found but ${NumberOfHUCs} expected.  Check HUC IDs and HUC Names in control file.`
           Indicates that there are typos in the HUC information on the ***Combined Inputs*** worksheet, resulting in duplicates.
           Fix the problem and then re-run this step.
        3. A Failure with a ***Problem*** similar to `ERROR for HUC ${HUCID} - ${SelectReservoirCount} reservoirs found but ${NumReservoirs} expected. FIX!`
           indicates a problem with the TSTool process and/or possibly duplicate stations assigned to a HUC for the same data type.
           Fix the problem and then re-run this step.
    4. Review all HUC products in the `Results-Web` folder,
       in particular the SWSI Current Summary workbook and the HUC graphical outputs, to quality control the results.
10. **Calculate the SWSI results by Basin:**
    1. Open the `55-CalculateSWSI-Basin.tstool` command file in TSTool.
    2. Click ***Run All Commands***.
    3. When finished running, click on the ***Problems*** tab.
        1. Any rows that have a ***Severity*** of `WARNING` or `FAILURE` should be reviewed.
           The ***Problem*** column gives details about the severity status.
        2. A ***Failure*** with a ***Problem*** of `ERROR - ${BasinCount} Basins found but ${NumberOfBasins} expected. Check control file.`
           Indicates that there are typos in the Basin information on the ***Combined Inputs*** worksheet,
           resulting in duplicates. Fix the problem and then re-run this step.
        3. A ***Failure*** with a ***Problem*** similar to `ERROR for Basin ${Basin} - ${SelectReservoirCount} reservoirs found but ${NumReservoirs} expected. FIX!`
           indicates a problem with the TSTool process and/or possibly duplicate stations assigned to a
           Basin for the same data type. Fix the problem and then re-run this step.
    4. Review all Basin products in the `Results-Web` folder,
       in particular the SWSI Current Summary workbook and the graphical outputs, to quality control the results.

    #### Review and disseminate the output products ####

11. Go to the `YYYY_MM\Results_Web folder` to review available graphical and tabular output products.
12. Provide the `SWSI-Current-Summary.xlsx` file to OIT to load into HydroBase.
13. Archive the following files (at a minimum) so that the Colorado SWSI outputs can be re-generated in the future:
    * `CO-SWSI-Control.xlsx`
    * `Input-TimeSeries-Raw/Input-Data-Final.xlsx` (Note: this file is not required to rerun the SWSI analysis,
       but it contains the final input data with all data flags that indicate data sources
       and filling that may be of interest to the user in understanding and troubleshooting results.)
    * `Input-TimeSeries-ForSWSI/ForecastedRunoff/SWSI-Component-ForecastedRunoff.dv`
    * `Input-TimeSeries-ForSWSI/ForecastedRunoff/Station-ForecastedRunoff-NEP.dv`
    * `Input-TimeSeries-ForSWSI/PrevMoStreamflow/SWSI-Component-PrevMoStreamflow.dv`
    * `Input-TimeSeries-ForSWSI/PrevMoStreamflow/Station-PrevMoStreamflow-NEP.dv`
    * `Input-TimeSeries-ForSWSI/ReservoirStorage/SWSI-Component-ReservoirStorage.dv`
    * `Input-TimeSeries-ForSWSI/ReservoirStorage/Station-ReservoirStorage-NEP.dv`

      Note: With the above files saved, the user can rerun the SWSI analysis starting from
      Step 50 (based on workflow folder names) in the TSTool process.

    #### Optional: Compare Colorado Historical SWSI Values to NRCS Historical SWSI Values

14. **Run Historical SWSI Comparison:**
    1. Open the `60a-CompareHistSWSI-NRCS.tstool` command file in TSTool.
    2. Click ***Run All Commands***.
    3. Click on the ***Problems*** tab and confirm there are no warnings or failures.
    4. On the ***Output Files*** tab, click on the results graphs to review.

## To run Colorado SWSI Re-forecasts

1. Set ***RecentPeriodFlowType*** property in control workbook to `ForecastedNaturalFlow`. Save and exit the workbook.
2. Follow the procedure specified above in [To run the monthly SWSI analysis](#to-run-the-monthly-swsi-analysis)
3. Extend the NRCS Forecast SWSI dataset. This process uses NRCS Forecast SWSI data contained in the
   `Input-TimeSeries-ForSWSI/ComparisonData/NRCS-SWSI-Recent.dv` file.
    New values can be added to this dataset in one of two ways:
    1. New values can be manually added using a text editor by copying a previous line and then updating the values.
       If this approach is used, the user also needs to manually update the End property in the DateValue file header.
    2. Rename the existing file and then use TSTool to read the existing file and the file containing new values,
       merge the time series, and write out a new file with the original file name (`Input-TimeSeries-ForSWSI/ComparisonData/NRCS-SWSI-Recent.dv`).
4. Generate dated Current SWSI Summaries for each month in the recent period.
    1. Open the `60b-GenerateCurrentSummaries.tstool` command file in TSTool.
    2. Click ***Run All Commands***.
    3. When finished, click on the ***Problems*** tab to ensure no warnings or failures were generated.
    4. Open the dated summary files from the ***Output Files*** tab.

    #### Optional: Compare Colorado Forecast SWSI Values to NRCS Forecast SWSI Values ####

5. **Run Forecast SWSI Comparison:**
    1. Open the `60c-CompareFcstSWSI-NRCS.tstool` command file in TSTool.
    2. Click ***Run All Commands***.
    3. Click on the ***Problems*** tab and confirm there are no warnings or failures.
    4. On the ***Output Files*** tab, click on the results graphs to review.
