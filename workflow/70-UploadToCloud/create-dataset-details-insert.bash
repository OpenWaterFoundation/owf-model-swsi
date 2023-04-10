#!/bin/bash

# Prepare content to insert into the main "Dataset Details" section of the dataset landing page (dataset-details.md):
# - list files in the ../Results-Web folder and creates Markdown tables
# - output is to the 'results/dataset-details-insert.md' file,
#   which can be uploaded to the cloud for processing by TSTool into the dataset landing page.
# - the resulting file should be expanded to show the date for the dataset ${CurrentMonthDate}
# 

insertFile="results/dataset-details-insert.md"
# Prefix to add before GeoJSON file URL:
viewerPrefix="https://gavinr.github.io/geojson-viewer/?url="
# URL prefix for OWF's data website.
urlPrefix="https://data.openwaterfoundation.org/country/us/babbitt/indicators-swsi"
# Full prefix before dataset file.
viewPrefix="${viewerPrefix}${urlPrefix}"

# The following should be expanded by TSTool after creating the MarkDown file.

echo '
This dataset is for SWSI analysis INSERT_CurrentMonthDate_PROPERTY.' > ${insertFile}

echo "
## Downloads ##

The following files can be downloaded or used directly by specifying the URL to software.

* Files are grouped into product categories.
* Within each category, files are organized by Hydrologic Unit Code (HUC8) identifier,
  or major basin name." >> ${insertFile}

# ------------------------------------------------------
# SWSI summary for major river basins and HUC8 basins.
# ------------------------------------------------------

echo '
### SWSI Products (Summary) ###

The summary contains SWSI values for each major river basin and HUC8 basins:

* use the `SWSI` column to display the overall SWSI value for a major river basin or HUC8 basin

| **Current Summary (`xlsx`)** | **Current Summary, Major Rirver Basins (`csv`)** | **Current Summary, HUC8 (`csv`)** |
|--|--|--|
| [`SWSI-Current-Summary.xlsx`](swsi-summary/SWSI-Current-Summary.xlsx) | [`SWSI-Current-Summary-Basin.csv`](swsi-summary/SWSI-Current-Summary-Basin.csv) | [`SWSI-Current-Summary-HUC.csv`](swsi-summary/SWSI-Current-Summary-HUC.csv) |' >> ${insertFile}

# --------------------------------------------------------
# SWSI graphs and Excel workbooks for major river basins.
# --------------------------------------------------------

echo '
### SWSI Products - Major River Basins (Details) ###

SWSI products are available in different formats for each major river basin:

* images can be displayed from a link, for example link to the image from a river basin map
* the SWSI workbook is formatted to facilitate review
* the time series files organize data in linear fashion over the data period
* use the `BasinName-DataComposite-SWSI` column to display the overall SWSI value
  (where `BasinName` must be replaced with the specific basin name)

| **SWSI Graph, Historical (`png`)** | **SWSI Workbook (`xlsx`)** | **Time Series (`xlsx`)** | **Time Series (`csv`)** | **Time Series (DateValue, `dv`)** |
|--|--|--|--|--|' >> ${insertFile}

# Only 'history' file is available:
#  Basin-Colorado-SWSI-history-graph.png
#  Basin-Rio Grande-SWSI-history-graph.png
#
# Spaces can cause issues:
# - replace with %20 in URL filenames but not the visible file name
#
# TODO smalers 2022-09-19 need to change to remove space in basin name.
ls -1 ../Results-Web/graphs-png/ALL-BASIN/*.png | while read filepath; do
  echo "Processing basin file: ${filepath}"
  # File will list with "history" file first and then "recent".
  filename=$(basename "${filepath}")
  echo "  Basin file: ${filename}"
  # Extract the basin name (may include space).
  basin=$(echo ${filename} | sed -e 's/Basin-\(.*\)-SWSI-history-graph.png/\1/g')
  echo "  Basin:      ${basin}"
  if [[ "${filename}" = *"history"* ]]; then
    historyFilename=$(basename "${filepath}")
    echo '| [`'${historyFilename}'`](graphs-png/ALL-BASIN/'${historyFilename}') | [`'${basin}'-SWSI.xlsx`](swsi-by-basin/'${basin}'-SWSI.xlsx) | [`'${basin}'-TimeSeries.xlsx`](ts/'${basin}'-TimeSeries.xlsx) |  [`'${basin}'-TimeSeries.csv`](ts/'${basin}'-TimeSeries.csv) | [`'${basin}'-TimeSeries.dv`](ts/'${basin}'-TimeSeries.dv) |' | sed -e 's/Rio Grande-SWSI-history/Rio%20Grande-SWSI-history/2' | sed -e 's/San Juan-Dolores-SWSI-history/San%20Juan-Dolores-SWSI-history/2' | sed -e 's/South Platte-SWSI-history/South%20Platte-SWSI-history/2' | sed -e 's/Rio Grande-SWSI\.xlsx/Rio%20Grande-SWSI.xlsx/2' | sed -e 's/San Juan-Dolores-SWSI\.xlsx/San%20Juan-Dolores-SWSI.xlsx/2' | sed -e 's/South Platte-SWSI\.xlsx/South%20Platte-SWSI.xlsx/2' | sed -e 's/Rio Grande-TimeSeries\.xlsx/Rio%20Grande-TimeSeries.xlsx/2' | sed -e 's/San Juan-Dolores-TimeSeries\.xlsx/San%20Juan-Dolores-TimeSeries.xlsx/2' | sed -e 's/South Platte-TimeSeries\.xlsx/South%20Platte-TimeSeries.xlsx/2' | sed -e 's/Rio Grande-TimeSeries\.csv/Rio%20Grande-TimeSeries.csv/2' | sed -e 's/San Juan-Dolores-TimeSeries\.csv/San%20Juan-Dolores-TimeSeries.csv/2' | sed -e 's/South Platte-TimeSeries\.csv/South%20Platte-TimeSeries.csv/2' | sed -e 's/Rio Grande-TimeSeries\.dv/Rio%20Grande-TimeSeries.dv/2' | sed -e 's/San Juan-Dolores-TimeSeries\.dv/San%20Juan-Dolores-TimeSeries.dv/2' | sed -e 's/South Platte-TimeSeries\.dv/South%20Platte-TimeSeries.dv/2' >> ${insertFile}
  fi
done

# ----------------------------------
# SWSI for HUC8 Basins.
# ----------------------------------

echo '
### SWSI Products - HUC8 Basins ###

SWSI products are available in different formats for each HUC8 basin:

* images can be displayed from a link, for example link to the image from a HUC8 basin map
* the SWSI workbook is formatted to facilitate review
* the time series files organize data in linear fashion over the data period
* use the `HUC8-DataComposite-SWSI` data type to display the overall SWSI value
  (where `HUC8` must be replaced with the specific basin name)

| **SWSI Graph, Historical (`png`)** | **SWSI Graph, Recent (`png`)** | **SWSI Workbook (`xlsx`)** | **Time Series (`xlsx`)** | **Time Series (`csv`)** | **Time Series (DateValue, `dv`)** |
|--|--|--|--|--|--|' >> ${insertFile}

ls -1 ../Results-Web/graphs-png/All-HUC/*.png | while read filepath; do
  # File will list with "history" file first and then "recent", similar to:
  #  HUC-10180001-SWSI-history-graph.png
  #  HUC-10180001-SWSI-recent-graph.png
  filename=$(basename ${filepath})
  # Extract the HUC basin.
  huc=$(echo ${filename} | cut -d '-' -f 2)
  if [[ "${filename}" = *"history"* ]]; then
    historyFilename=$(basename ${filepath})
  elif [[ "${filename}" = *"recent"* ]]; then
    recentFilename=$(basename ${filepath})
    size=$(stat --printf="%s" ${filepath})
    echo '| [`'${historyFilename}'`](graphs-png/ALL-HUC/'${historyFilename}') | [`'${recentFilename}'`](graphs-png/ALL-HUC/'${recentFilename}') | [`'${huc}'-SWSI.xlsx`](swsi-by-huc/'${huc}'-SWSI.xlsx) | [`'${huc}'-TimeSeries.xlsx`](ts/'${huc}'-TimeSeries.xlsx) |  [`'${huc}'-TimeSeries.csv`](ts/'${huc}'-TimeSeries.csv) | [`'${huc}'-TimeSeries.dv`](ts/'${huc}'-TimeSeries.dv) |' >> ${insertFile}
  fi
done

echo "
### SWSI Products - HUC8 Basins by Month ###

SWSI graph image files are available for each HUC8 basin for each month,
which illustrates the historical variability for each month.

| **HUC** | **JAN** | **FEB** | **MAR** | **APR** | **MAY** | **JUN** | **JUL** | **AUG** | **SIP** | **OCT** | **NOV** | **DEC** |
|--|--|--|--|--|--|--|--|--|--|--|--|--|" >> ${insertFile}

ls -1 ../Results-Web/graphs-png/01-JAN-HUC/*.png | while read filepath; do
  # Filename is similar to:
  #   HUC-10180001-SWSI-history-JAN-graph.png
  filename=$(basename ${filepath})
  huc=$(echo ${filename} | cut -d '-' -f 2)
  echo '|' ${huc} '| [JAN](graphs-png/01-JAN-HUC/HUC-'${huc}'-SWSI-history-JAN-graph.png) | [FEB](graphs-png/02-FEB-HUC/HUC-'${huc}'-SWSI-history-FEB-graph.png) | [MAR](graphs-png/03-MAR-HUC/HUC-'${huc}'-SWSI-history-MAR-graph.png) | [APR](graphs-png/04-APR-HUC/HUC-'${huc}'-SWSI-history-APR-graph.png) | [MAY](graphs-png/05-MAY-HUC/HUC-'${huc}'-SWSI-history-MAY-graph.png) | [JUN](graphs-png/06-JUN-HUC/HUC-'${huc}'-SWSI-history-JUN-graph.png) | [JUL](graphs-png/07-JUL-HUC/HUC-'${huc}'-SWSI-history-JUL-graph.png) | [AUG](graphs-png/08-AUG-HUC/HUC-'${huc}'-SWSI-history-AUG-graph.png) | [SEP](graphs-png/09-SEP-HUC/HUC-'${huc}'-SWSI-history-SEP-graph.png) | [OCT](graphs-png/10-OCT-HUC/HUC-'${huc}'-SWSI-history-OCT-graph.png) | [NOV](graphs-png/11-NOV-HUC/HUC-'${huc}'-SWSI-history-NOV-graph.png) | [DEC](graphs-png/12-DEC-HUC/HUC-'${huc}'-SWSI-history-DEC-graph.png) |' >> ${insertFile}
done

echo ""
echo "The output (detail insert) file is:  ${insertFile}"
echo ""
