# Surface Water Supply Index / Colorado SWSI Methodology  #

* [Introduction](#ntroduction)
* [Forecasted Runoff](#forecasted-runoff)
* [Reservoir Storage](#reservoir-storage)
* [Previous Month’s Streamflow](#previous-months-streamflow)
* [Methodology Summary](#methodology-summary)

-------------

## Introduction ##

The Colorado SWSI is calculated for each month of the year, typically within the first ten days of the month.
As noted previously in Table 1 of the [Introduction](../introduction/introduction.md),
the Colorado SWSI is computed using three components depending on the time of year:

## Forecasted Runoff ##

Forecasted runoff volumes are issued monthly from January through June by the NRCS.
The forecasts represent probabilistic estimates of natural flow volumes for the upcoming season.
They are generated using regression models and hydro-meteorological data as predictor variables
(i.e., snowpack, precipitation, and streamflow).
The Colorado SWSI computations use the 50th percent exceedance (expected value) forecast volumes.
Complete information about the NRCS forecasts can be obtained from the NRCS website (NRCS, 2015).

The forecasts are generated for fixed forecast periods defined by location
that were selected to represent high runoff months.
The Colorado SWSI Automation Tool was developed assuming the forecast period starts in April.
This assumption is true for all locations except the Purgatoire River at Trinidad.
At this location, from January through June, the NRCS issues a March-July forecast.
Starting in April, the NRCS also issues a current month-July forecast.
Until the Colorado SWSI Automation Tool can be updated to handle this case,
when running the SWSI analysis in January-March,
the DWR will use a regression equation that relates March-July runoff volumes
with April-July runoff volumes for Purgatoire River at Trinidad.

For the Colorado SWSI analysis, forecasts that end in September are used for locations
in the Rio Grande Basin and forecasts that end in July are used for locations in other river basins.
The forecasts used in May and June represent expected runoff from the current month until
the end of the forecast period. See Table 2 for a summary of the forecast period used by river basin and SWSI calculation month.

**<p style="text-align: center;">
Table 2 - Forecast Period by Basin and SWSI Calculation Month
</p>**

| **SWSI Calculation Months** | **Forecast Period (Rio Grande Basin)** | **Forecast Period (Non-Rio Grande Basins)** |
| -- | -- | -- |
| January-April | April-September | April-July |
| May           | May-September   | May-July   |
| June          | June-September  | June-July  |
| July-December | Not used        | Not used   |

The Colorado SWSI Automation Tool is configured to obtain forecasted streamflow data from the NRCS AWDB web services.

When the Colorado SWSI is calculated for the months of January through June,
the analysis incorporates the forecasted runoff component as an indicator of future surface water supply.
For the current water year’s forecasted runoff values, the NRCS forecasts are used.
For recent and historical water years, when the actual runoff is known,
the forecasted runoff component is calculated from historical natural flow data.  

## Reservoir Storage ##

The Colorado SWSI always incorporates observed reservoir storage data as an indicator of the current state of the surface water supply.
For a given month’s analysis, the SWSI incorporates beginning-of-month storage values.
For inclusion in the Colorado SWSI analysis, DWR has selected reservoirs that are used as active storage
in a HUC and that increase the available water supply volume in a HUC.
Therefore, the reservoirs that are included are typically municipal and irrigation reservoirs,
not reservoirs used for augmentation.

The Colorado SWSI Automation Tool is set up to obtain observed reservoir storage data from the NRCS and the State of Colorado. 

* The NRCS AWDB web services provide access to end-of-month storage values using the RESC data type. 
* The State of Colorado has two sets of web services: 
    + ColoradoWaterHBGuest services access daily reservoir storage data from HydroBase
      that have been quality controlled and are considered published.
    + ColoradoWaterSMS services access daily reservoir storage data for the recent period that
      have not been quality-controlled and are considered provisional.  
    + The daily reservoir storage data from ColoradoWaterHBGuest and ColoradoWaterSMS are merged to make a continuous record,
      with ColoradoWaterHBGuest data taking precedence. 
* To be consistent with the NRCS AWDB data, end-of-month storage time series are computed from the daily storage values. 
  Before calculating the SWSI values, the end-of-month storage values are shifted forward by
  one month to represent beginning-of-month storage values for the current month’s analysis.

## Previous Month’s Streamflow

Per the State Drought Plan, in the months of July-September,
the Colorado SWSI procedure incorporates a component representing the previous month’s native flow volume (CWCB, 2013). 

The Colorado SWSI Automation Tool is set up to obtain monthly native flow volumes from the NRCS AWDB web services.
[Appendix A – NRCS Native Flow Equations](../appendix-a/nrcs-native-flow-equations.md)
contains the equations used by the NRCS to compute native flow volumes in Colorado.

Before calculating the Colorado SWSI values, the monthly native flow volumes are shifted forward by one month
to represent previous month’s streamflow for the current month’s analysis
(see Table 3 for an example demonstrating the data manipulation).

**<p style="text-align: center;">
Table 3 - Example of Data Transformation from Natural Flow to Previous Month’s Streamflow Component
</p>**

| **Date** | **Natural Flow (ac-ft)** | **SWSI Component (ac-ft)** | **Explanation** |
| -- | -- | -- | -- |
| 2015-06 | 3,000 |     0 | Previous month’s streamflow component is not used in June |
| 2015-07 | 2,000 | 3,000 | July SWSI analysis uses June volume to represent previous month’s streamflow volume |
| 2015-08 | 1,000 | 2,000 | August SWSI analysis uses July volume to represent previous month’s streamflow volume |
| 2015-09 |   800 | 1,000 | September SWSI analysis uses August volume to represent previous month’s streamflow volume |
| 2015-10 |   500 |     0 | Previous month’s streamflow component is not used in October |

If the required native flow data are not available for the current month’s analysis,
the Colorado SWSI Automation Tool has been set up to use observed flows rather
than native flows for the previous month’s streamflow component.
This option is discussed in more detail in the Colorado SWSI Automation Tool
Step-by-Step Procedure and in
[Appendix C – Colorado SWSI Automation Tool Workflow Details](../appendix-c/colorado-swsi-workflow-details.md).

## Methodology Summary ##

The Colorado SWSI analysis is performed on 41 HUC8 watersheds.
DWR selected natural flow locations, water supply reservoirs,
and forecast locations that represent the surface water supply for each HUC8
included in the Colorado SWSI analysis (see [Appendix B – Station Assignments by HUC](../appendix-b/station-assignments-by-huc.md)).
In general, all significant water supply reservoirs with storage data available in real-time are included.
The natural flow and forecast locations were selected to most closely represent total flow in the HUC,
whether at a single location at the HUC outlet or as multiple locations on individual tributaries. 
As part of the current project, Open Water Foundation reviewed the input data being used in the Colorado SWSI analysis.
Issues that were identified, solutions that were implemented, and unresolved issues are documented in the following appendices: 

 * [Appendix D – Historical Period Data Issues](../appendix-d/historical-period-data-issues.md)
 * [Appendix E – Current Water Year Data Issues](../appendix-e/current-water-year-data-issues.md)
 * [Appendix F – Recent Period Data Issues](../appendix-f/recent-period-data-issues.md)

After development of the Colorado SWSI Automation Tool, Riverside Technology,
inc. reviewed sections of the TSTool process to confirm that the implemented
command logic is consistent with the calculation methodology.

The Colorado SWSI methodology includes the following steps:

* The natural flow, reservoir storage, and forecast data are downloaded for all specified stations and reservoirs.
* The raw data are analyzed for missing values.
* Missing values can be filled using automated techniques (such as regression analysis or interpolation)
  and/or the user can manually specify values to be used.
  Automated techniques can be used to fill missing values in the raw data obtained from source agencies.
  Manually-specified values are applied to any data value (missing or not) in the auto-filled dataset.
    + For natural flows, missing values can be filled automatically using monthly regression analysis.
      The user should specify a filling station that is close to the station being filled,
      that has data for the periods that require filling,
      and that has a correlation coefficient of at least 0.7 for the overlapping data with the station being filled.
      Filled values are denoted using a data flag of “R” for regression.
    + For reservoir storage, missing values are filled in multiple ways. 
        - If the values are missing because the reservoir was not yet storing water,
          the storage values are set to 0. Filled values are denoted using a data flag of “Z” for zeroes.
        - If values are missing after the reservoir began storing water,
          the user can elect to fill based on linear interpolation between surrounding values or with historical average monthly values.
          Filled values are denoted using data flags of “I” for interpolation or “H” for historical monthly averages.
        - If a reservoir is decommissioned, the user can elect to fill the storage data with zeroes to the current month.
          Filled values are denoted using a data flag of “Z” for zeroes.
    + No automated filling options are implemented for the forecast data.
    + The user may elect to apply overrides (i.e., values determined by the user) for any time series value.
      Filled values are denoted using a data flag that starts with “MO” for manual overrides.
    + Any missing data in the historical period that are not filled will reduce the number
      of years used to establish the distribution of SWSI and NEP values.
    + Any missing data in the recent and current periods that are not filled will
      produce missing values in the output products. 
* The filled input data are transformed to represent the SWSI components.
  This step includes time shifts, data accumulations,
  and setting component values to zero in months when the component is not used for the SWSI analysis. 
* Results are computed for each station and reservoir. The results include the following values:
    + Component Volume (ac-ft)
    + Component Non-Exceedance Probability by Month (%)
* Results are computed for each HUC. The results include the following values:
    + Data Composite (ac-ft)
    + Data Composite Percent of Average (%)
    + Data Composite Non-Exceedance Probability (%)
    + Data Composite SWSI (--)
    + Reservoir Storage (ac-ft)
    + Reservoir Storage Percent of Average (%)
    + Reservoir Storage Non-Exceedance Probability (%)
    + Reservoir Storage SWSI (--)
    + Previous Month’s Streamflow (ac-ft)
    + Previous Month’s Streamflow Percent of Average (%)
    + Previous Month’s Streamflow Non-Exceedance Probability (%)
    + Previous Month’s Streamflow SWSI (--)
    + Forecasted Runoff (ac-ft)
    + Forecasted Runoff Percent of Average (%)
    + Forecasted Runoff Non-Exceedance Probability (%)
    + Forecasted Runoff SWSI (--)
    + Composite SWSI for the same month last year
    + Change in Composite SWSI from last year to this year
* Results are calculated for each major river basin in Colorado.
  The results include all of the results listed by HUC as well as the following values:
    + Composite SWSI for the previous month
    + Change in Composite SWSI from the previous month to the current month

For each SWSI component and the sum of the components (i.e., the data composite),
the results are computed using the same methodology:

* For a given month, the component’s water supply volumes are ranked over the historical period,
  currently defined as WY 1971-2010, to determine the Gringorten plotting position.
  The plotting position values range from 0.00-1.00.
    + In using the Gringorten plotting position, the analysis assumes an empirical distribution,
      which is to say the historical data are used without fitting a distribution to the dataset. 
    + If there are ties in the water supply volumes, they receive the same plotting position value.
    + DWR expects that the historical period will be moved forward periodically in accordance with the NRCS. 
* The Gringorten plotting position is multiplied by 100 to determine the non-exceedance probabilities (NEP) over the historical period.
  The non-exceedance probabilities range from 0% (driest in the historical record) to 100% (wettest in the historical period).
* The non-exceedance probability values are transformed to a scale of -4.16 (extreme drought conditions)
  to +4.16 (abundant water supply) to determine the SWSI values over the historical period.
  The conversion formula is shown in Equation 1.
  This range of SWSI values is consistent with that used for the Palmer Drought Index and allows users to view familiar values.

*SWSI=(NEP-50)/12*

**<p style="text-align: center;">
Equation 1 - Converting NEP Value to SWSI Values
</p>**

* For months in the recent and current periods,
  the component’s water supply volumes are used to look up corresponding NEP and SWSI values based on the historical dataset.  
