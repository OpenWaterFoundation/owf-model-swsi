<#-- template graph to create Basin SWSI graph -->
# Template file to create
[Product]

ProductType = "Graph"
TotalHeight = "600"
TotalWidth = "1200"

[SubProduct 1]

GraphType = "Bar"
BarPosition = "RightOfDate"
LeftYAxisTitleString = "SWSI"
LegendFormat = "%A"
MainTitleString = "${BasinName} Basin SWSI History"
SubTitleString = "Historical period SWSI values establish the SWSI distribution to lookup recent and current SWSI values. ${BasinPrevMoFlowFlagAnnotation}"

[Data 1.1]

TSAlias = "${BasinName}-DataComposite-SWSI"
TSID = "${BasinName}.CALC.DataComposite-SWSI.Month"
Color = "Black"

[Annotation 1.1]

ShapeType = "Line"
Order = "BehindData"
Color = "Red"
YAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "2"
Points = "${HistoricalPeriodEndDateDecimalText},0,${HistoricalPeriodEndDateDecimalText},100"

[Annotation 1.2]

ShapeType = "Text"
YAxisSystem = "Percent"
FontSize = "10"
Point = "${HistoricalPeriodAnnotationDecimalText},98"
Text = "Historical Period"
TextPosition = "LowerLeft"
Color = "Red"

[Annotation 1.3]

ShapeType = "Text"
YAxisSystem = "Percent"
FontSize = "10"
Point = "${RecentPeriodAnnotationDecimalText},98"
Text = "Recent Period"
TextPosition = "LowerRight"
Color = "Red"

[Annotation 1.4]

ShapeType = "Line"
Color = "Red"
YAxisSystem = "Percent"
LineStyle = "Solid"
LineWidth = "2"
Points = "${CurrentWaterYearStartDateDecimalText},0,${CurrentWaterYearStartDateDecimalText},100"

#[Annotation 1.5]

#ShapeType = "Text"
#YAxisSystem = "Percent"
#FontSize = "10"
#Point = "${CurrentPeriodAnnotationDecimalText},100"
#Text = "Current Period"
#TextPosition = "LowerRight"