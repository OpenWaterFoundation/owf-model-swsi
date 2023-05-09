# Surface Water Supply Index / Release Notes #

Release notes are available for the core TSTool product and SWSI tool.
Each component is maintained separately and may be updated at different times.
See the [TSTool release notes](http://opencdss.state.co.us/tstool/latest/doc-user/appendix-release-notes/release-notes/).

SWSI release notes:

*   [Version 2.1.0](#version-210)
*   [Version 2.0.0](#version-200)
*   [Version 1.0.0](#version-100)

----------

## Version 2.1.0 ##

**Clean up the Babbitt Center indicators use case using TSTool 14.8.0.**

*   ![change](change.png) [2.1.0] Use TSTool 14.8.0 and TSTool AWS Plugin 1.4.0 features
    to enhance the workflow for the Babbitt Center SWSI workflow use case:
    +   The TSTool command files have been updated to use indentation for
        [`If`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/If/If/) and
        [`For`](https://opencdss.state.co.us/tstool/latest/doc-user/command-ref/For/For/)
        command blocks  to improve readability.
    +   New ***Object Processing*** commands are used to automate creation of the SWSI GeoJSON output file.
    +   Time series heat map output products have been added to evaluate their usefulness in summarizing the SWSI.
*   ![change](change.png) [2.1.0] Enhance the Colorado SWSI workflow for Babbitt Center indicators project:
    +   Add repository folder `workflow-babbitt/` to separate
        the Babbitt Center workflow files from the Colorado SWSI workflow files.
    +   Add repository folder `test-babbitt/` for testing the workflow within the development environment.
    +   Add `build-util` scripts to create a deployable installer zip file containing the combined Colorado SWSI workflow
        and the additional Babbitt Center workflow steps.
        This merges the separate development workflow files into a combined workflow that can be run in production.
    +   Add command files to create graph heat map visualization output product.
*   ![change](change.png) [2.1.0] Enhance the documentation:
    +   Add [Appendix G - Use Case for Babbitt Center Indicators](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/appendix-g/use-case-babbitt-indicators).

## Version 2.0.0 ##

**Initial version in GitHub repository and generalized for Babbitt Center indicators project.**

*   ![change](change.png) [2.0.0] The [source code repository](https://github.com/OpenWaterFoundation/owf-model-swsi)
    has been created to manage the SWSI tools for research and development, including generalized use beyond the State of Colorado.
*   ![change](change.png) [2.0.0] The State of Colorado SWSI tool has being generalized to apply to the Upper Colorado Basin,
    to allow additional basins to be added in the future.
*   ![change](change.png) [2.0.0] The TSTool command file extensions have been changed from `.TSTool` to `.tstool`
    and command files that contain `RunCommands` commands, etc., have been updated to use lowercase extension.
*   ![change](change.png) [2.0.0] Update workflows and software that have nuisance warnings to avoid such warnings.
    For example, the `ReadDateValue` command has been updated to have `IfNotFound=Ignore` parameter for commands that
    are used for troubleshooting and may generate warnings if a file is not found.
*   ![change](change.png) [2.0.0] Update the control Excel workbook ***Combined Inputs*** worksheet
    and TSTool command files that download data to use the current HydroBase web services, as follows,
    where the datastore is the last part of the TSID.
    The current `ColoradoHydroBaseRestDataStore` is configured by default as a datastore named `HydroBaseWeb`
    and includes historical time series (that previously required using `ColoradoWaterHBGuest` web service datastore)
    and telemetry station time series (the previously required using `ColoradoWaterSMS` database datastore).
    Some issues were identified, as indicated below.
    **Note that only some of these basins are in the Upper Colorado basin, and others are linked by transbasin diversions.**

    | **Old TSID** | **New TSID** | **Note** |
    | -- | -- | -- |
    | Datastore2:<br>`06752000.DWR.Streamflow.Month`<br>`~ColoradoWaterHBGuest`<br><br>Datastore3:<br>`CLAFTCCO.DWR.DISCHRG.Month`<br>`~ColoradoWaterSMS` | | HUC 10190003 (Middle South Platte-Cherry Creek -> South Platte), Cache la Poudre at Canyon Mouth (**need to fix identifier**). |
    | Datastore2:<br>`06719505.USGS.Streamflow.Month`<br>`~ColoradoWaterHBGuest` | | HUC 10190004 (Clear), Clear Creak at Golden (**need to fix identifier**). |
    | Datastore2:<br>`06752000.DWR.Streamflow.Month`<br>`~ColoradoWaterHBGuest`<br><br>Datastore3:<br>`CLAFTCCO.DWR.DISCHRG.Month`<br>`~ColoradoWaterSMS` | | HUC 10190007 (Cache la Poudre -> South Platte), Cache la Poudre at Canyon Mouth (**need to fix identifier**). |
    | Datastore2:<br>`06752000.DWR.Streamflow.Month`<br>`~ColoradoWaterHBGuest`<br><br>Datastore3:<br>`CLAFTCCO.DWR.DISCHRG.Month`<br>`~ColoradoWaterSMS` | | HUC 10190012 (Middle South Platte-Sterling -> South Platte), Cache la Poudre at Canyon Mouth (**need to fix identifier**). |
    | Datastore2:<br>`ARKPUECO.DWR.Streamflow.Month`<br>`~ColoradoWaterHBGuest`<br><br>Datastore3:<br>`ARKPUECO.DWR.DISCHRG.Month`<br>`~ColoradoWaterSMS` | | HUC 11020002 (Upper Arkansas -> Arkansas), Arkansas River above Pueblo (**need to fix identifier**). |
    | `MTNRESCO.DWR.STORAGE.Month`<br>`~ColoradoWaterSMS`<br><br>Datastore2:<br>`3503529.DWR.ResMeasStorage.Month`<br>`~ColoradoWaterHBGuest` | | HUC 13010002 (Alamosa-Trinchera -> Rio Grande), Mountain Home Reservoir, **not currently included in the analysis since AWDB alternative is included?** |
    | `BKIRESCO.DWR.STORAGE.Month`<br>`~ColoradoWaterSMS`<br><br>Datastore2:<br>`6103551.DWR.ResMeasStorage.Month`<br>`~ColoradoWaterHBGuest` | | HUC 14030003 (San Miguel -> Gunnison), Buckeye Reservoir, **not currently included in the analysis but maybe should be, small reservoir?** |
    | `LONRESCO.DWR.STORAGE.Month`<br>`~ColoradoWaterSMS`<br><br>Datastore2:<br>`LONRESCO.DWR.ResMeasStorage.Month`<br>`~ColoradoWaterHBGuest` | | HUC 14080105 (Middle San Juan -> San Juan-Dolores), Long Hollow Reservoir (**need to fix identifier**). |
    | Datastore2:<br>`MANMANCO.DWR.Streamflow.Month`<br>`~ColoradoWaterHBGuest`<br><br>Datastore3:<br>`MANMANCO.DWR.DISCHRG.Month`<br>`~ColoradoWaterSMS` | | HUC 14080107 (Mancos -> San Juan-Dolores), Mancos River near Mancos (**need to fix identifier**). |

## Version 1.0.0 ##

**Initial release.**

*   ![new](new.png) [1.0.0] The initial TSTool-based production release was made to the State of Colorado in June, 2015.
    The orginal version has been used by the State of Colorado since that date.
