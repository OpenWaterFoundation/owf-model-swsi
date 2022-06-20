# Surface Water Supply Index / Introduction #

* [Introduction](#introduction)
* [Natural Resources Conservation Service SWSI](#natural-resources-conservation-service-swsi)
* [State of Colorado SWSI](#state-of-colorado-swsi)
* [Application to Upper Colorado Basin](#application-to-upper-colorado-basin)

-------------

## Introduction ##

The Surface Water Supply Index (SWSI) is a tool that indicates whether surface water supply
is abundant or drought conditions exist.
The tool has evolved over time, as described in the following sections.

## Natural Resources Conservation Service SWSI ##

The SWSI is an index used to describe drought in mountainous areas that
rely primarily on surface water supplies such as snowpack and reservoir storage.
The SWSI was developed by the Soil Conservation Service (now Natural Resources Conservation Service or NRCS)
and the Colorado Division of Water Resources (DWR) in 1981 for the Colorado Drought Plan.
DWR has produced the original SWSI in accordance with the Colorado Drought Plan since 1981.
In 1993, Dave Garen from the NRCS proposed a revised SWSI calculation to improve upon the known
deficiencies of the original SWSI calculation methodology (Garen, 1993).
See the [Surface Water Supply Index Formulation and Issues](http://www.wamis.org/agm/meetings/hdi11/S3-Garen.pdf)
presentation and
[ASCE paper available for download](https://ascelibrary.org/doi/abs/10.1061/%28ASCE%290733-9496%281993%29119%3A4%28437%29).
Other Western States have adopted their own version of the SWSI as well.

## State of Colorado SWSI ##

The State of Colorado monitors conditions that affect water supply, including snowpack, precipitation, reservoir storage, and streamflows.
The Governor of Colorado established the
[Water Availability Task Force (WATF)](https://cwcb.colorado.gov/water-availability-flood-task-forces)
to interpret available
information and to take actions to mitigate drought effects when appropriate.
The WATF has the authority to activate the Colorado Drought Mitigation and Response Plan (CWCB, 2013)
when drought conditions reach significant levels.

The WATF makes drought projections based on a variety of hydro-meteorological data types
(i.e., snowpack, soil moisture, streamflow, reservoir levels, ground water levels, precipitation, and temperature)
and drought indices (i.e., Surface Water Supply Index, Standardized Precipitation Index, and Modified Palmer Drought Index).
More information about the WATF is available on the CWCB website (CWCB, 2015).

The Colorado Water Conservation Board (CWCB) completed a major revision to the Colorado Drought Plan in 2010.
At that time, Colorado adopted a revised SWSI analysis that is calculated on a smaller
geographic scale and that uses streamflow forecasts instead of the weighted precipitation,
streamflow, snowpack, and reservoir storage factors used in the original SWSI.
This approach is similar to what Garen proposed in 1993.
The revised Colorado SWSI is computed on a monthly time step and considers three components depending on the time of year,
as described in the Table 1 below.

**<p style="text-align: center;">
Table 1 - Colorado Revised SWSI Formulation (CWCB, 2013)
</p>**

| **Time Period** | **Components** |
| -- | -- |
| January - June | Forecasted Runoff + Reservoir Storage |
| July - September | Previous Month's Streamflow + Reservoir Storage |
| October - December | Reservoir Storage |

Since 2011, the NRCS has been producing a SWSI product for the WATF similar to the revised SWSI called for in the 2010 Drought Plan.
The NRCS SWSI process relies on Excel spreadsheets to compute values for selected eight-digit Hydrologic Unit Codes (HUC).

In 2015, the State of Colorado undertook the SWSI Automation Tool Enhancement project,
which resulted in the development of an automated SWSI calculation tool based on the criteria set forth in the 2010 Drought Plan.
The automated tool produces results that can be incorporated into DWR’s HydroBase database
and made available to the public using
[Colorado's Decision Support System (CDSS)](https://cdss.colorado.gov/)
the [Colorado Information Marketplace](https://data.colorado.gov/).
The Open Water Foundation collaborated with DWR and CWCB in developing the Colorado SWSI Automation Tool.
Riverside Technology, inc, provided input on the forecast data source and reviewed the implementation of the Colorado SWSI Automation Tool.

The TSTool software tool has been developed as part of the CDSS.
TSTool has the advantages of being able to access many data sources, of automating data processing and visualization,
and of using workflow commands that provide transparency and repeatability to the computation process.
This Colorado Surface Water Supply Index (SWSI) Automation Tool - TSTool Software Guide provides an overview of
the concepts and procedures necessary for a practitioner to use the Colorado SWSI Automation Tool.

## Application to Upper Colorado Basin ##

In 2022, the Open Water Foundation contracted with
the [Babbitt Center for Land and Water Policy](https://www.lincolninst.edu/our-work/babbitt-center-land-water-policy)
to utilize the Colorado automated SWSI tools as a water supply indicator.
The following activities are ongoing:

* the tools developed in the 2015 project have been migrated to a
  [GitHub repository](https://github.com/OpenWaterFoundation/owf-model-swsi)
* the documentation has been migrated to
  [online format](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/)
* the SWSI workflow is being used with latest TSTool software
* additional HUC 8 basins are being implemented for the Upper Colorado Basin
* a generalized workflow is being implemented
* results are being published using the Lincoln Institutes' ArcGIS Online platform
