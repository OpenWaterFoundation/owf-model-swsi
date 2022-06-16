<#-- template graph to create HUC SWSI monthly graphs -->
# Template file to create
[Product]

ProductType = "Graph"
TotalHeight = "600"
TotalWidth = "1200"

[SubProduct 1]

GraphType = "AreaStacked"
LeftYAxisLabelPrecision = "0"
LeftYAxisTitleString = "ACFT"
LegendFormat = "%A ${r"${ts:HUCAnnotation}"}"
MainTitleString = "HUC ${HUCID} (${hucName}) Surface Water Supply - ${MonthAbbrev}"
SubTitleString = "Monthly component volumes"
LayoutYPercent = ""

[Data 1.1]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-ReservoirStorage"
TSID = "HUC:${HUCID}..ReservoirStorage.Year"
#Color = "198,244,247"
Color = LightGray

[Data 1.2]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-ForecastedRunoff"
TSID = "HUC:${HUCID}..ForecastedRunoff.Year"
# light blue
Color = "142,237,232"

[Data 1.3]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-PrevMoStreamflow"
TSID = "HUC:${HUCID}..PrevMoStreamflow.Year"
#Color = "247,247,198"
Color = "Blue"

[Data 1.4]

GraphType = "Line"
TSAlias = "HUC:${HUCID}-${MonthAbbrev}-DataComposite"
TSID = "HUC:${HUCID}..DataComposite.Year"
Color = "Black"
LineWidth = "3"

[Annotation 1.1]

ShapeType = "Line"
Color = "DarkGray"
YAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "3"
Points = "${HistoricalPeriodEndDateDecimalText},0,${HistoricalPeriodEndDateDecimalText},100"

[Annotation 1.2]

ShapeType = "Text"
YAxisSystem = "Percent"
FontSize = "10"
Point = "${HistoricalPeriodAnnotationDecimalText},98"
Text = "Historical Period"
TextPosition = "LowerLeft"

[Annotation 1.3]

ShapeType = "Text"
YAxisSystem = "Percent"
FontSize = "10"
Point = "${RecentPeriodAnnotationDecimalText},98"
Text = "Recent Period"
TextPosition = "LowerRight"

[Annotation 1.4]

ShapeType = "Line"
Color = "DarkGray"
YAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "2"
Points = "${CurrentWaterYearStartDateDecimalText},0,${CurrentWaterYearStartDateDecimalText},100"

#[Annotation 1.5]

#ShapeType = "Text"
#YAxisSystem = "Percent"
#FontSize = "10"
#Point = "${CurrentPeriodAnnotationDecimalText},98"
#Text = "Current Period"
#TextPosition = "LowerRight"

[SubProduct 2]

GraphType = "Line"
LeftYAxisTitleString = "SWSI"
LegendFormat = "%A"
MainTitleString = "HUC ${HUCID} (${hucName}) SWSI Values - ${MonthAbbrev}"
SubTitleString = "Historical period SWSI values establish the SWSI distribution to lookup recent and current SWSI values."

[Data 2.1]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-PrevMoStreamflow-SWSI"
TSID = "HUC:${HUCID}..PrevMoStreamflow-SWSI.Year"
#Color = "247,247,198"
Color = "Blue"
LineWidth = 2

[Data 2.2]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-ForecastedRunoff-SWSI"
TSID = "HUC:${HUCID}..ForecastedRunoff-SWSI.Year"
# light blue
Color = "142,237,232"
LineWidth = 2

[Data 2.3]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-ReservoirStorage-SWSI"
TSID = "HUC:${HUCID}..ReservoirStorage-SWSI.Year"
#Color = "198,244,247"
Color = LightGray
LineWidth = 2

[Data 2.4]

TSAlias = "HUC:${HUCID}-${MonthAbbrev}-DataComposite-SWSI"
TSID = "HUC:${HUCID}..DataComposite-SWSI.Year"
Color = "Black"
LineWidth = 3

[Annotation 2.1]

ShapeType = "Line"
Order = "BehindData"
Color = "DarkGray"
YAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "3"
Points = "${HistoricalPeriodEndDateDecimalText},0,${HistoricalPeriodEndDateDecimalText},100"

[Annotation 2.2]

ShapeType = "Text"
YAxisSystem = "Percent"
FontSize = "10"
Point = "${HistoricalPeriodAnnotationDecimalText},98"
Text = "Historical Period"
TextPosition = "LowerLeft"

[Annotation 2.3]

ShapeType = "Text"
YAxisSystem = "Percent"
FontSize = "10"
Point = "${RecentPeriodAnnotationDecimalText},98"
Text = "Recent Period"
TextPosition = "LowerRight"

[Annotation 2.4]

ShapeType = "Line"
Color = "DarkGray"
YAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "2"
Points = "${CurrentWaterYearStartDateDecimalText},0,${CurrentWaterYearStartDateDecimalText},100"

[Annotation 2.5]

ShapeType = "Line"
Order = "BehindData"
Color = "LightGray"
YAxisSystem = "Data"
XAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "2"
Points = "0,0,100,0"

#[Annotation 2.6]

#ShapeType = "Text"
#YAxisSystem = "Percent"
#FontSize = "10"
#Point = "${CurrentPeriodAnnotationDecimalText},98"
#Text = "Current Period"
#TextPosition = "LowerRight"