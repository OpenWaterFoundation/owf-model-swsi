# Surface Water Supply Index / TSTool Command Summary #

The following TSTool commands are used in the Colorado SWSI Automation Tool.
The latest documentation for each command can be accessed using the links below. 

**<p style="text-align: center;">
TSTool Commands Used in the SWSI Analysis Workflows (alphabetized)
</p>**

| **TSTool Command**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **Description** |
| -- | -- |
| [`Add`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Add/Add/) | Add one or more time series to a time series. |
| [`AddConstant`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/AddConstant/AddConstant/) | Add a constant or monthly constants to one or more time series. |
| [`AdjustExtremes`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/AdjustExtremes/AdjustExtremes/) | Adjust the extreme values in a time series while conserving mass, for example to adjust for negative streamflow. |
| [`AnalyzePattern`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/AnalyzePattern/AnalyzePattern/) | Analyze time series for wet/average/dry conditions. |
| [`AppendTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/AppendTable/AppendTable/) | Append a table to another table. |
| [`CalculateTimeSeriesStatistic`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CalculateTimeSeriesStatistic/CalculateTimeSeriesStatistic/) | Calculate a single statistic for time series. |
| [`ChangeInterval`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ChangeInterval/ChangeInterval/) | Change the interval for time series to create new interval time series. |
| [`ChangePeriod`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ChangePeriod/ChangePeriod/) | Change the period of time series, for example to extend and fill. |
| [`CheckTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CheckTimeSeries/CheckTimeSeries/) | Check time series values for specific criteria and output to a table and warnings. |
| [`CheckTimeSeriesStatistic`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CheckTimeSeriesStatistic/CheckTimeSeriesStatistic/) | Calculate a time series statistic and then check the statistic against criteria. |
| [`CloseExcelWorkbook`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CloseExcelWorkbook/CloseExcelWorkbook/) | Close an Excel workbook that is being written to. |
| [`Comment`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Comment/Comment/) | A single line `#`-comment to provide explanatory information. |
| [`CommentBlockEnd`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CommentBlockEnd/CommentBlockEnd/) | Multi-line `*/` comment block end. |
| [`CommentBlockStart`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CommentBlockStart/CommentBlockStart/) | Single line `/*` comment block start. |
| [`ConvertDataUnits`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ConvertDataUnits/ConvertDataUnits/) | Convert time series data units. |
| [`Copy`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Copy/Copy/) | Create new time series by copying a time series. |
| [`CopyFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CopyFile/CopyFile/) | Create a new file by copying a file. |
| [`CopyPropertiesToTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CopyPropertiesToTable/CopyPropertiesToTable/) | Copy processor properties to a table. |
| [`CopyTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CopyTable/CopyTable/) | Create a new table by copying a table, with options to copy specific columns, rename columns, and filter rows. |
| [`CopyTimeSeriesPropertiesToTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/CopyTimeSeriesPropertiesToTable/CopyTimeSeriesPropertiesToTable/) | Copy time series properties to a table. |
| [`DeselectTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/DeselectTimeSeries/DeselectTimeSeries/) | Deselect time series, used to create lists of time series used with `TSList=SelectedTS` command parameter. |
| [`Disaggregate`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Disaggregate/Disaggregate/) | Disaggregate time series from longer interval to shorter interval data. |
| [`Divide`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Divide/Divide/) | Divide time series by another time series. |
| [`Empty`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Empty/Empty/) | Blank command line. |
| [`EndFor`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/EndFor/EndFor/) | End of `For` command block. |
| [`EndIf`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/EndIf/EndIf/) | End of `If` command block. |
| [`Exit`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Exit/Exit/) | Exit processing, useful when testing a partial command file. |
| [`ExpandTemplateFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ExpandTemplateFile/ExpandTemplateFile/) | Expand a FreeMarker syntax template text file into an expanded file, useful for repeating common processing. |
| [`FillConstant`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillConstant/FillConstant/) | Fill missing data in time series with a constant value. |
| [`FillFromTS`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillFromTS/FillFromTS/) | Fill missing data using values in a time series from another time series' data values. |
| [`FillHistMonthAverage`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillHistMonthAverage/FillHistMonthAverage/) | Fill missing data in monthly time series using the monthly averages from the same time series. |
| [`FillHistYearAverage`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillHistYearAverage/FillHistYearAverage/) | Fill missing data in yearly time series using the yearly averages from the same time series. |
| [`FillInterpolate`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillInterpolate/FillInterpolate/) | Fill missing data in time series by interpolating between non-missing values. |
| [`FillPattern`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillPattern/FillPattern/) | Fill missing data in time series by using wet/average/dry values for the same time series. |
| [`FillRegression`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillRegression/FillRegression/) | Fill missing data in time series using ordinary least squares regression. |
| [`FillRepeat`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FillRepeat/FillRepeat/) | Fill missing data in time series by repeating values forward or backward. |
| [`For`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/For/For/) | For-loop start. |
| [`FormatDateTimeProperty`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FormatDateTimeProperty/FormatDateTimeProperty/) | Format date/time property into a new processor string property given a format specifier, useful when a specific string version of date/time is needed. |
| [`FormatStringProperty`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FormatStringProperty/FormatStringProperty/) | Format a new string processor property given other properties as input. |
| [`FormatTableDateTime`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FormatTableDateTime/FormatTableDateTime/) | Format a date/time column in a table, for example to output a specific date/time format for output. |
| [`FormatTableString`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FormatTableString/FormatTableString/) | Format a table string column using other table columns as input. |
| [`Free`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Free/Free/) | Free a time series - it will no longer be available for further processing, useful when using temporary time series for processing. |
| [`FreeTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/FreeTable/FreeTable/) | Free a table - it will no longer be available for further processing, useful when using temporary tables for processing. |
| [`If`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/If/If/) | If block start. |
| [`InsertTableColumn`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/InsertTableColumn/InsertTableColumn/) | Insert a column into a table. |
| [`InsertTableRow`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/InsertTableRow/InsertTableRow/) | Insert a row into a table. |
| [`JoinTables`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/JoinTables/JoinTables/) | Join tables horizontally using one or more common columns. |
| [`ListFiles`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ListFiles/ListFiles/) | List files in a folder. |
| [`LookupTimeSeriesFromTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/LookupTimeSeriesFromTable/LookupTimeSeriesFromTable/) | Create a new time series by looking up time series values from a table. |
| [`ManipulateTableString`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ManipulateTableString/ManipulateTableString/) | Manipulate a table string in a table - see also FormatTableString() command. |
| [`Message`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Message/Message/) | Generate a message for logging and user. |
| [`Multiply`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Multiply/Multiply/) | Multiply one time series by another. |
| [`NewEndOfMonthTSFromDayTS`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewEndOfMonthTSFromDayTS/NewEndOfMonthTSFromDayTS/) | Create a new end of month time series from a daily time series, useful for determining reservoir end or month time series. |
| [`NewExcelWorkbook`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewExcelWorkbook/NewExcelWorkbook/) | Create a new Excel workbook that can be written to by other commands. |
| [`NewPatternTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewPatternTimeSeries/NewPatternTimeSeries/) | Create a new time series filled with an initial pattern of values and flags, useful for automated testing. |
| [`NewStatisticTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewStatisticTimeSeries/NewStatisticTimeSeries/) | Create a new time series containing a statistic of all similar date/times, for example average of all January 1 daily values. |
| [`NewStatisticYearTS`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewStatisticYearTS/NewStatisticYearTS/) | Create a new Time series containing a statistic of all annual values, useful to create an annual time series to compare to other time series. |
| [`NewTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewTable/NewTable/) | Create a new empty table. |
| [`NewTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/NewTimeSeries/NewTimeSeries/) | Create a new time series to receive results from other commands. |
| [`ProcessTSProduct`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ProcessTSProduct/ProcessTSProduct/) | Process a time series product into views and image files. |
| [`ReadDateValue`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadDateValue/ReadDateValue/) | Read time series from a "DateValue" format file, one of the primary formats used by TSTool. |
| [`ReadDelimitedFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadDelimitedFile/ReadDelimitedFile/) | Read time series from a delimited file, for example a comma-separated-value (CSV) file. |
| [`ReadHydroBase`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadHydroBase/ReadHydroBase/) | Read time series from the State of Colorado's HydroBase database. |
| [`ReadNrcsAwdb`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadNrcsAwdb/ReadNrcsAwdb/) | Read time series from Natural Resources Conservation Service (NRCS) Air and Water Database web services. |
| [`ReadPatternFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadPatternFile/ReadPatternFile/) | Read time series from wet/average/dry pattern file produced by AnalyzePattern() command. |
| [`ReadPropertiesFromExcel`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadPropertiesFromExcel/ReadPropertiesFromExcel/) | Read processor properties from an Excel worksheet. |
| [`ReadPropertiesFromFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadPropertiesFromFile/ReadPropertiesFromFile/) | Read processor properties from a text file. |
| [`ReadStateMod`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadStateMod/ReadStateMod/) | Read time series from the State of Colorado's StateMod water allocation model text input files. |
| [`ReadTableCellsFromExcel`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadTableCellsFromExcel/ReadTableCellsFromExcel/) | Read table cells from specific cells in an Excel worksheet, useful for transferring form input into a flat data table. |
| [`ReadTableFromDataStore`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadTableFromDataStore/ReadTableFromDataStore/) | Read a table from a database datastore. |
| [`ReadTableFromExcel`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadTableFromExcel/ReadTableFromExcel/) | Read a table from an Excel worksheet. |
| [`ReadTimeSeriesFromDataStore`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadTimeSeriesFromDataStore/ReadTimeSeriesFromDataStore/) | Read time series from a datastore. |
| [`ReadTimeSeriesList`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReadTimeSeriesList/ReadTimeSeriesList/) | Read time series using a table with list of identifiers. |
| [`RemoveFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/RemoveFile/RemoveFile/) | Remove a file. |
| [`ReplaceValue`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ReplaceValue/ReplaceValue/) | Replace values in a time series with alternate values. |
| [`RunCommands`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/RunCommands/RunCommands/) | Run a command file, used to create master command files to run larger workflows. |
| [`RunningStatisticTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/RunningStatisticTimeSeries/RunningStatisticTimeSeries/) | Create a running statistic time series using various methods to determine the sample size. |
| [`Scale`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Scale/Scale/) | Scale time series by a constant value. |
| [`SelectTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SelectTimeSeries/SelectTimeSeries/) | Select time series for processing, used with the TSList=SelectedTS parameter. |
| [`SetConstant`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetConstant/SetConstant/) | Set time series data values to a constant. |
| [`SetFromTS`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetFromTS/SetFromTS/) | Set time series data values using values from another time series. |
| [`SetInputPeriod`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetInputPeriod/SetInputPeriod/) | Set the global input period default when reading time series, useful for datastores that have an inconvenient default input period. |
| [`SetOutputPeriod`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetOutputPeriod/SetOutputPeriod/) | Set the global output period default when writing time series, useful to standardize all output to a consistent period. |
| [`SetOutputYearType`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetOutputYearType/SetOutputYearType/) | Set the global output year type (e.g., calendar, water year). |
| [`SetProperty`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetProperty/SetProperty/) | Set a processor property. |
| [`SetPropertyFromTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetPropertyFromTable/SetPropertyFromTable/) | Set a processor property from a table. |
| [`SetTableValues`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetTableValues/SetTableValues/) | Set table values based on filters. |
| [`SetTimeSeriesPropertiesFromTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetTimeSeriesPropertiesFromTable/SetTimeSeriesPropertiesFromTable/) | Set time series properties from a table, useful to cross-reference data from different data sources. |
| [`SetTimeSeriesProperty`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetTimeSeriesProperty/SetTimeSeriesProperty/) | Set a single time series property. |
| [`SetTimeSeriesValuesFromLookupTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetTimeSeriesValuesFromLookupTable/SetTimeSeriesValuesFromLookupTable/) | Set time series values from a lookup table, for example to set values based on a distribution. |
| [`SetTimeSeriesValuesFromTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetTimeSeriesValuesFromTable/SetTimeSeriesValuesFromTable/) | Set time series values from a table, similar to other commands that set time series values. |
| [`SetWorkingDir`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SetWorkingDir/SetWorkingDir/) | Set the working directory for processing - generally not used given newer features to access processor `${WorkingDir}` property. |
| [`ShiftTimeByInterval`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/ShiftTimeByInterval/ShiftTimeByInterval/) | Shift time series values by an interval, useful to handle time zone changes, routing, and use of previous timestep(s) as input. |
| [`SortTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SortTable/SortTable/) | Sort a table based on one or more columns. |
| [`SortTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/SortTimeSeries/SortTimeSeries/) | Sort a list of time series based on identifier or other time series properties. |
| [`StartLog`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/StartLog/StartLog/) | Start a new log file for logging. |
| [`Subtract`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/Subtract/Subtract/) | Subtract time series from another time series. |
| [`TableMath`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/TableMath/TableMath/) | Calculate table column values using input table column(s) and/or constant values. |
| [`TableTimeSeriesMath`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/TableTimeSeriesMath/TableTimeSeriesMath/) | Manipulate time series values using data from a table. |
| [`TableToTimeSeries`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/TableToTimeSeries/TableToTimeSeries/) | Create new time series using values from a table. |
| [`TimeSeriesToTable`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/TimeSeriesToTable/TimeSeriesToTable/) | Create a table using values from time series. |
| [`WriteDateValue`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteDateValue/WriteDateValue/) | Write time series to a DateValue format file. |
| [`WriteDelimitedFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteDelimitedFile/WriteDelimitedFile/) | Write time series to a delimited (e.g., CSV) file. |
| [`WritePropertiesToFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WritePropertiesToFile/WritePropertiesToFile/) | Write processor properties to a text file. |
| [`WriteTableCellsToExcel`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTableCellsToExcel/WriteTableCellsToExcel/) | Write table cells to cells in an Excel worksheet, useful for transferring "flat" table data into Excel forms. |
| [`WriteTableToDataStore`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTableToDataStore/WriteTableToDataStore/) | Write a table to a database datastore. |
| [`WriteTableToDelimitedFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTableToDelimitedFile/WriteTableToDelimitedFile/) | Write a table to a delimited (e.g., CSV) file. |
| [`WriteTableToExcel`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTableToExcel/WriteTableToExcel/) | Write a table to an Excel worksheet. |
| [`WriteTableToHTML`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTableToHTML/WriteTableToHTML/) | Write a table to an HTML file. |
| [`WriteTimeSeriesPropertiesToFile`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTimeSeriesPropertiesToFile/WriteTimeSeriesPropertiesToFile/) | Write time series properties to a file, useful for automated tests. |
| `WriteTimeSeriesProperty` | Write time series property to a file, replaced by `WriteTimeSeriesProperiesToFile`. |
| [`WriteTimeSeriesToDataStore`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTimeSeriesToDataStore/WriteTimeSeriesToDataStore/) | Write time series to a database datastore, useful for generic database designs. |
| [`WriteTimeSeriesToExcel`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/WriteTimeSeriesToExcel/WriteTimeSeriesToExcel/) | Write time series to an Excel worksheet, with formatting based on data values. |
