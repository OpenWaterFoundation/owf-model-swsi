<#-- template graph to create Historical SWSI Comparison graphs by HUC -->
# Template file to create
[Product]

ProductType = "Graph"
TotalHeight = "600"
TotalWidth = "1200"

[SubProduct 1]

GraphType = "Line"
LeftYAxisTitleString = "SWSI"
LegendFormat = "%A"
MainTitleString = "HUC ${HUCID} (${hucName}) Historical SWSI Comparison"
SubTitleString = "2015 Colorado SWSI Methodology vs. NRCS Revised SWSI Methodology"

[Data 1.1]

TSAlias = "HUC:${HUCID}-DataComposite-SWSI"
Color = "Black"
LineWidth = 2

[Data 1.2]

TSAlias = "${HUCID}-NRCS-Historical-SWSI"
Color = "Red"
LineWidth = 2