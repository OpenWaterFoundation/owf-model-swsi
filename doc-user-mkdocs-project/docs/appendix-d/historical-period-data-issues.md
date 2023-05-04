# Appendix D / Historical Period Data Issues #

DWR provided to OWF the initial version of the `CO-SWSI-Control.xlsx` file.
During the development of the Colorado SWSI Automation Tool,
the historical data were reviewed by OWF and the issues are documented herein along with the implemented solutions.
Unresolved issues are noted using red text.

*   [Observed Natural Flows](#observed-natural-flows)
*   [Forecasted Natural Flows](#forecasted-natural-flows)
*   [Reservoir Storage](#reservoir-storage)

--------------------

## Observed Natural Flows ##

*   A station identifier without the leading zero was fixed in the master control file.
*   Multiple stations had no historical SRVO data from the NRCS and were replaced with alternate station selections.
    +   06695000 S Platte abv Eleven Mile: This was a data entry error and was replaced with 06695500 Eleven Mile Canyon Reservoir Inflow.
    +   07097000 Arkansas R abv Portland: Gage was replaced with 07099400 Arkansas R abv Pueblo.
    +   07124200 Purgatoire R at Madrid: Gage was replaced with 07124500 Purgatoire River at Trinidad.
    +   09110000 Taylor R at Almont: Gage was replaced with 09109209 Taylor River below Taylor Park Reservoir.
    +   09166950 Lost Canyon Creek near Dolores: This gage and 09166500 Dolores at Dolores were removed. Replacement gage is 09169000 Dolores River below McPhee Reservoir.
    +   09354500 Los Pinos River at La Boca: Gage was replaced with 09353500 Los Pinos River nr Bayfield.
    +   09362750 Florida R abv Lemon Res: Gage was replaced with 09363100 Florida R Inflow to Lemon Reservoir.
*   Multiple gages start after the historical period start of Oct 1970 or have periods of missing SRVO
    data during the historical period that were filled for a complete dataset.
    +   06710385 Bear Creek above Evergreen: Data start 1984.
    +   07111000 Huerfano River near Redwing: Missing data 1991-94.
    +   07114000 Cucharas River at Boyd Ranch nr La Veta: Missing data 1987-1994.
    +   08241500 Sangre de Cristo: Multiple missing periods, mostly before 1980.
    +   09169000 Dolores River below McPhee Reservoir: Some missing data 1980-1984.
    +   09242500 Elkhead River near Milner: Data start 1990 and winter values missing 2009-2012.
    +   09246200 Elkhead Creek above Long Gulch: Data start 1995.
    +   09370500 Mancos River near Mancos: Data start 1975 and missing data 1984-1990.
    +   **After applying automated filling in the historical and recent periods,
        one data value continues to be missing for 06719505 Clear Creek at Golden for 2014-08.**
*   Multiple gages have negative values in the SRVO time series obtained from the NRCS.
    Natural flow volumes can be computed to be negative if there are errors in the input terms,
    in particular during low flow months.
    If negative values occur in the months of June-August, when data are needed for the previous month’s streamflow component,
    then manual overrides were specified to eliminate the negative values while preserving runoff volumes with adjacent months.
    +   06729500 SOUTH BOULDER CK NR ELDORADO SPRINGS, CO:
        -   Affects HUCs 10190003, 10190005, 10190012.
        -   3 negative values during months when the data are used for SWSI analysis APR-SEP)
        -   Prev Mo Flow Component negative 1989-09
        -   Forecasted Runoff component ok
    +   08250000 CULEBRA CREEK AT SAN LUIS
        -   Affects HUC 13010002
        -   13 negative values during months when the data are used for SWSI analysis APR-SEP)
        -   Prev Mo Flow Component negative: 9 values
        -   Forecasted Runoff component ok
    +   09070500 COLORADO RIVER NEAR DOTSERO
        -   Affects HUC 14010001
        -   No negative values during months when data are used for SWSI analysis
    +   09132500 NORTH FORK GUNNISON R NR SOMERSET
        -   Affects HUC 14020004
        -   No negative values during months when data are used for SWSI analysis
    +   09251000 YAMPA R NEAR MAYBELL
        -   Affects HUC 14050002
        -   1 negative value during months used for SWSI
        -   Prev Mo Flow Component negative: 1 value
        -   Forecasted Runoff component ok
    +   09370500 MANCOS RIVER NEAR MANCOS
        -   Affects HUC 14080107
        -   5 negative values during months when the data are used for SWSI analysis APR-SEP)
        -   Prev Mo Flow Component negative: 5 values
        -   Forecasted Runoff component ok
        -   Manual overrides were specified to correct negative values that occurred in the months when
            data were needed for the previous month’s streamflow component.
            Adjacent months were altered to preserve overall runoff volumes,
            with consideration of whether the values occurred on the rising or falling limb of the hydrograph.
            **However, the specified values are subjective and no investigation was done into
            whether the specified values significantly affect the results.**
*   There were at least two cases where the station identifier and name used by the NRCS are not the same as used by the USGS.
    While the NRCS could not explain the history of this issue, they confirmed the stations being used are correct.
    The NRCS information for these stations follows:
    +   09169000 Dolores River below McPhee Reservoir
    +   09363100 FLORIDA RIVER INFLOW TO LEMON RESERVOIR
*   There was at least one case where the specified stations are redundant
    (i.e., both upstream tributary gages and downstream outlet gages are included)
    and would cause flow volumes to be double-counted.
    +   HUC 14010001 Colorado Headwaters Colorado. OWF removed the upstream tributary gages from the analysis per DWR direction.

## Forecasted Natural Flows ##

*   Multiple HUCs use different station sets for observed natural flows and forecasted natural flows.
    OWF discussed this issue with DWR and this approach is being retained to ensure natural flow values are available in real-time.
    +   HUC 14010001 Colorado Headwaters Colorado: Three additional upstream gages were specified for the observed natural flows.
        OWF removed the upstream tributary gages from the analysis per DWR direction so
        the gage sets are now the same in the observed and forecast period.
    +   HUC 14020002 Upper Gunnison Colorado: **The Gunnison River gage changes between the observed and forecast period.**
    +   HUC 14050001 Upper Yampa: Gage 09246400 was replaced with gage 09246200 so the gage sets are now the same in the observed and forecast period.
*   The NRCS AWDB service returns forecast values with mixed unit codes – some are ac-ft and
    some are kac-ft – although the forecast values do not change order-of-magnitude with the unit changes.
    After e-mails with the NRCS, OWF is assuming all forecast values are kac-ft regardless of the unit code returned.
    **The NRCS intends to fix the unit codes being returned by the web service.**
*   Multiple stations did not return forecast data.
    +   09246400: Gage was replaced with 09246200 ELKHEAD CREEK ABOVE LONG GULCH.
    +   06710500: Gage was replaced with 06710385 BEAR CREEK ABV EVERGREEN.

## Reservoir Storage ##

*   Two reservoirs are not included in the NRCS AWDB service.
    Data need to be obtained from the State of Colorado data sources.
    The ColoradoWaterSMS data service fails for a start date before 2000.
    +   LONRESCO LONG HOLLOW RESERVOIR: Reservoir began filling in 2014.
        Elevation data begin in 2014 but storage data are not available until February 2015.
    +   BKIRESCO BUCKEYE RESERVOIR: Although the reservoir was built many years ago,
        HydroBase data begin in 1992 and SMS data begin in 2007.
        **DWR is investigating StateMod as a potential source for pre-1992 data.
        The Colorado SWSI Automation Tool does not currently read StateMod data.
        DWR can add manual overrides to specify the data or a future tool enhancement
        could include adding StateMod as a data source.**
        For now, the reservoir was removed from the analysis.
*   Multiple reservoirs came on-line after 1970 based on the available storage data.
    The period between the start of the historical period and the start of the storage data are filled with zero values.
    +   16016025 SPINNEY MOUNTAIN RESERVOIR: Data start 1981-10
    +   07007090 PUEBLO RESERVOIR: Data start 1973-12
    +   07007100 TRINIDAD LAKE: Data start 1977-08
    +   09041395 WOLFORD MOUNTAIN RESERVOIR: Data start 1995-06
    +   09125800 SILVER JACK RESERVOIR: Data start 1973-07
    +   09116500 VOUGA RESERVOIR NEAR DOYLEVILLE: Data start 1997-10
    +   09147022 RIDGEWAY RESERVOIR: Data start 1986-10
    +   MPHC2000 MCPHEE RESERVOIR: Data start 1984-03
    +   09237495 STAGECOACH RESERVOIR NR OAK CREEK: Data start 1988-10
    +   YAMRESCO YAMCOLO RESERVOIR: Data start 1980-10
    +   LONRESCO LONG HOLLOW RESERVOIR: Data start 2015-02
*   Based on a visual assessment of the storage data, multiple reservoirs have undergone changes in operations
    during the historical period and/or were filling during the beginning of the historical period.
    No action was taken – these issues are noted for the record.
    +   06016160 JACKSON LAKE RESERVOIR: Apparent operations change in 1990.
    +   07007110 TURQUOISE LAKE: Reservoir was filling in the 70s?
    +   07007120 TWIN LAKES RESERVOIR: Operations change in 1983?
    +   07007070 MEREDITH RESERVOIR: Operations change in 1982
    +   07007010 ADOBE CREEK RESERVOIR: Operations change in 1981?
    +   09009100 PAONIA RESERVOIR: Change in operations ~1980?
    +   MPHC2000 MCPHEE RESERVOIR : Reservoir was filling until 1986?
    +   09237495 STAGECOACH RESERVOIR NR OAK CREEK: Reservoir was filling until 1989?
    +   YAMRESCO YAMCOLO RESERVOIR: Reservoir was filling until 1981?
*   Multiple reservoirs have missing data after the point at which they began storing water.
    These data values can be filled using linear interpolation or historical average monthly data values for a complete dataset.
    +   06016280 STANDLEY RESERVOIR: Missing WY2002
    +   06016260 BUTTONROCK (RALPH PRICE) RESERVOIR: Missing 1975-10 to 1982-09 and 1991-10 to 2005-10 plus other sporadic points
    +   06016040 BOYD LAKE: Missing a few data points
    +   06016180 LAKE LOVELAND RESERVOIR: Missing a few data points
    +   06016190 LONE TREE RESERVOIR: Missing a few data points
    +   06016200 MARIANO RESERVOIR: Missing a few data points
    +   08008150 SANTA MARIA RESERVOIR: Missing WY 1976
    +   MTNRESCO MOUNTAIN HOME: Multiple missing periods (mostly short)
    +   09009330 FRUITLAND RESERVOIR: Missing data 1991-1993
    +   09009340 CRAWFORD RESERVOIR: Missing data 1991-1993
    +   09125800 SILVER JACK RESERVOIR: Sporadic missing data until 1987
    +   09009170 GROUNDHOG RESERVOIR: Sporadic missing
*   For HUC 10190012, Jackson Lake Reservoir was used with station ID 06016160.
    The name was ambiguous but station selection was confirmed using NRCS station metadata.
*   **After automated filling, only one missing value remained for Standley Reservoir for 2015-02.**
