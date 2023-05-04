# Surface Water Supply Index (SWSI) #

This is the documentation for the Surface Water Supply Index (SWSI) model,
which consists of:

*   a main configuration Excel workbook
*   analysis workflow as [TSTool software](https://opencdss.state.co.us/opencdss/tstool/) command files
*   files created by the workflow:
    +   time series data files
    +   Excel workbooks containing time series
    +   images

The model is used to compute a monthly index of surface water supply conditions using snowpack, reservoir storage,
and streamflow forecast.
The index provides an indication of water supply conditions in the spectrum of abundant supply to drought.

This documentation has been updated for SWSI version 2.1.0.

This documentation is the online version of the original State of Colorado SWSI documentation.
See [Appendix C - Colorado SWSI Workflow Details](appendix-c/colorado-swsi-workflow-details.md) and
[Appendix G - Use Case for Babbitt Center Indicators](appendix-g/use-case-babbitt-indicators.md)
for examples of how to use the SWSI model.

*   [Acknowledgements](#acknowledgements)
*   [How to Use this Documentation](#how-to-use-this-documentation)

----------------

## Acknowledgements

The original Excel-based SWSI analysis was created by the Natural Resources Conservation Service.

The State of Colorado provided funding starting in 2014 to automate the NRCS SWSI process using TSTool software,
resulting in the initial SWSI tool described in this documentation.
See the [State of Colorado Drought & Surface Water Supply Index](https://dwr.colorado.gov/services/water-administration/drought-and-swsi) documentation.

Additional enhancements to the SWSI tool have been implemented by the [Open Water Foundation (OWF)](https://openwaterfoundation.org)
with funding from the [Lincoln Institute of Land Policy](https://www.lincolninst.edu/)
and [Babbitt Center for Land and Water Policy](https://www.lincolninst.edu/our-work/babbitt-center-land-water-policy) project.

The TSTool software that performs the SWSI analysis has been enhanced over
time by the Open Water Foundation with funding from various sources and
new features have been implemented to improve the original SWSI workflows and output products.

## How to Use this Documentation ##

Use the navigation menu provided on the left side of the page to navigate the documentation sections within the full document.
Use the navigation menu provided on the right side of the page to navigate the documentation sections with a page.
If the page size is narrow, an icon may be shown to access navigation features.

See also the full TSTool documentation:

*   [latest TSTool User Documentation](https://opencdss.state.co.us/tstool/latest/doc-user/) available on the OpenCDSS website
*   [TSTool download page](https://opencdss.state.co.us/tstool/) on the OpenCDSS website
    with access to documentation for different TSTool versions

The TSTool documentation matching the TSTool version being run will be shown when accessed from the TSTool software,
if available, and otherwise the "latest" documentation will be shown.
