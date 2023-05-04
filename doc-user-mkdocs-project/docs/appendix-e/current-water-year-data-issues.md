# Appendix E / Current Water Year Data Issues #

During the development of the Colorado SWSI Automation Tool (in 2015),
the current water year data were reviewed by OWF and the issues are documented
herein along with the implemented solutions. Unresolved issues are noted using red text.

*   The Cucharas Reservoir has been decommissioned and is no longer storing water.
    In Step `25-FillDataAuto`, the storage data for Cucharas Reservoir are filled with zeroes through the current month.
*   Mountain Home Reservoir storage data were missing from the NRCS AWDB web service beginning in February 2015,
    which prevented results from being computed for HUC 13010002 Alamosa-Trinchera and for the Rio Grande basin.
    The data source was switched to ColoradoWaterSMS and ColoradWaterHBGuest.
*   The remaining missing values are documented in Table 14.
    DWR should consider specifying manual overrides to fill these values.

**<p style="text-align: center;">
Table 14 - Missing Data Values that Require Overrides
</p>**

| Time Series Alias | Station ID | Station Name | Date |
| -- | -- | -- | -- |
| 07124500-ForecastedNaturalFlow-Month | 07124500 | PURGATOIRE RIVER AT TRINIDAD | 2015-03 |
| 06016280-ReservoirStorage-Month | 06016280 | STANDLEY RESERVOIR | 2015-02 |
| 07124500-ForecastedNaturalFlow-Month | 07124500 | PURGATOIRE RIVER AT TRINIDAD | 2015-02 |
| 07124500-ForecastedNaturalFlow-Month | 07124500 | PURGATOIRE RIVER AT TRINIDAD | 2015-01 |
| 06719505-NaturalFlow-Month | 06719505 | CLEAR CREEK AT GOLDEN | 2014-08 |
