# Prepare content to insert into the main "Dataset Details" section of the dataset landing page (dataset-details.md):
# - Python is used as an example because Babbitt Center staff use Python for other work
# - a simple main program is used
# - list files in the ../Results-Web folder and creates Markdown tables
# - output is to the 'results/dataset-details-insert.md' file,
#   which can be uploaded to the cloud for processing by TSTool into the dataset landing page.
# - the resulting file should be expanded to show the date for the dataset ${CurrentMonthDate}
# - use simple 'print' statements rather than full logging
# 

from pathlib import Path
import os


if __name__ == '__main__':
    """
    Entry point for the script.
    """

    # Location of the script:
    script_folder : Path = Path(os.path.realpath(__file__)).parent
    print("Script folder: {}".format(script_folder))

    # File that will be inserted in the 'Dataset Details' section of the landing page:
    # - write to a temporary file that TSTool will expand
    insert_file : Path = script_folder / "results" / "dataset-details-insert.md"

    # Prefix to add before GeoJSON file URL:
    # - this is an open source viewer hosted on GitHub
    # - viewer is not currently enabled since need to use a color ramp (rely on Babbitt dashboard)
    #viewer_prefix : str = "https://gavinr.github.io/geojson-viewer/?url="

    # URL prefix for OWF's data website:
    # - 'latest' and 'YYYY-MM' folders will be created
    #url_prefix : str = "https://data.openwaterfoundation.org/country/us/babbitt/indicators-swsi"

    # Full prefix before dataset file:
    # - will be used in links to GeoJSON files
    #view_prefix : str = viewer_prefix + url_prefix

    # Read the HUC reference data so the name can be looked up from the HUC ID.
    huc_ref_path : Path = script_folder / "results" / "huc-reference.csv"
    huc_dict = {}
    line_count = 0
    with open (huc_ref_path) as huc_fp:
        while True:
            line = huc_fp.readline()
            line_count = line_count + 1
            if not line:
                break
            if line_count == 1:
                # Header line
                continue
            # HUC is the first column and HUCName is the second.
            parts = line.split(",")
            if len(parts) > 2:
                huc_dict[parts[0].strip()] = parts[1].strip()

    # The following Markdown file will be expanded by TSTool and converted to HTML.

    f = open(insert_file, "w")
    f.write('This dataset is for SWSI analysis INSERT_CurrentMonthDate_PROPERTY.\n')
    f.write( "\n" +
        "## Downloads ##\n" +
        "\n" +
        "The following files can be downloaded or used directly by specifying the URL to software.\n" +
        "\n" +
        "*   Files are grouped into product categories.\n" +
        "*   Within each category, files are organized by Hydrologic Unit Code (HUC8) identifier,\n" +
        "    or major basin name.\n")

    # ------------------------------------------------------
    # SWSI summary for major river basins and HUC8 basins.
    # ------------------------------------------------------

    f.write( "\n" +
        "### SWSI Products (Summary) ###\n" +
        "\n" +
        "The summary contains SWSI values for each major river basin and HUC8 basins:\n" +
        "\n" +
        "*   all products are for HUC8 basins except for the Major River Basins product\n" +
        "\n" +
        "|**Product** | **File Link** |\n" +
        "|--|--|\n")
    f.write("| Current Summary (`xlsx`) | [`SWSI-Current-Summary.xlsx`](swsi-summary/SWSI-Current-Summary.xlsx)|\n")
    f.write("| Current Summary (`csv`) | [`SWSI-Current-Summary-Basin.csv`](swsi-summary/SWSI-Current-Summary-Basin.csv)|\n")
    f.write("| Current Summary, Upper Colorado (`geojson`) | [`SWSI-Current-Summary-UpperColorado-HUC.geojson`](swsi-summary/SWSI-Current-Summary-UpperColorado-HUC.geojson) |\n")
    f.write("| History Heatmap, Upper Colorado (`png`) | [`SWSI-HeatMap-UpperColorado-History.png`](swsi-summary/SWSI-HeatMap-UpperColorado-History.png) |\n")
    f.write("| Recent Heatmap, Upper Colorado (`png`) | [`SWSI-HeatMap-UpperColorado-Recent.png`](swsi-summary/SWSI-HeatMap-UpperColorado-Recent.png) |\n")
    f.write("| Current Summary, Major River Basins (`csv`) | [`SWSI-Current-Summary.csv`](swsi-summary/SWSI-Current-Summary.csv)|\n")

    # --------------------------------------------------------
    # SWSI graphs and Excel workbooks for major river basins.
    # --------------------------------------------------------

    f.write( "\n" +
        "### SWSI Products - Major River Basins (Details) ###\n" +
        "\n" +
        "SWSI products are available in different formats for each major river basin:\n" +
        "\n" +
        "*   images can be displayed from a link, for example link to the image from a river basin map\n" +
        "*   the SWSI workbook is formatted to facilitate review\n" +
        "*   the time series files organize data in linear fashion over the data period\n" +
        "*   use the `BasinName-DataComposite-SWSI` column to display the overall SWSI value\n" +
        "    (where `BasinName` must be replaced with the specific basin name)\n" +
        "\n" +
        "| **Basin** | **SWSI Graph, History (`png`)** | **SWSI Workbook (`xlsx`)** | **Time Series (`xlsx`)** | **Time Series (`csv`)** | **Time Series (DateValue, `dv`)** |\n" +
        "|--|--|--|--|--|--|\n")

    # Only 'history' file is available:
    #  Basin-Colorado-SWSI-history-graph.png
    #  Basin-Rio Grande-SWSI-history-graph.png
    #
    # Spaces can cause issues:
    # - replace space with %20 in URL filenames but not the visible file name
    #
    # TODO smalers 2022-09-19 need to change to remove space in basin name.

    graphs_png_folder = Path(script_folder).parent / 'Results-Web' / 'graphs-png' / 'ALL-BASIN'
    files = graphs_png_folder.rglob('*.png')
    for file in files:
        # File will list will only include "history" files:
        # - for example:
        #     Basin-Colorado-SWSI-history-graph.png
        #     Basin-San Juan-SWSI-history-graph.png
        # - logic is similar to other code blocks
        # - also list formats other than 'png'
        filename = file.name
        # URL-encode the space in file names so that links work.
        filename_encoded = filename.replace(" ", "%20")
        print("  Basin file: {}".format(filename))
        # Extract the basin name (may include space):
        basin = filename.replace("Basin-", "").replace("-SWSI-history-graph.png","")
        # URL-encode the space in basin names so that links work.
        basin_encoded = basin.replace(" ", "%20")
        print("    Basin:           {}".format(basin))
        print("    Basin (encoded): {}".format(basin_encoded))
        if filename.find("history") > 0:
            history_filename = filename
            history_filename_encoded = filename_encoded
            f.write("| {}".format(basin))
            f.write("| [`{}`](graphs-png/ALL-BASIN/{})".format(history_filename, history_filename_encoded))
            f.write(" | [`{}-SWSI.xlsx`](swsi-by-basin/{}-SWSI.xlsx)".format(basin, basin_encoded))
            f.write(" | [`{}-TimeSeries.xlsx`](ts/{}-TimeSeries.xlsx)".format(basin, basin_encoded))
            f.write(" | [`{}-TimeSeries.csv`](ts/{}-TimeSeries.csv)".format(basin, basin_encoded))
            f.write(" | [`{}-TimeSeries.dv`](ts/{}-TimeSeries.dv) |\n".format(basin, basin_encoded))

    # ----------------------------------
    # SWSI for HUC8 Basins.
    # ----------------------------------

    f.write( "\n" +
        "### SWSI Products - HUC8 Basins ###\n" +
        "\n" +
        "SWSI products are available in different formats for each HUC8 basin:\n" +
        "\n" +
        "*   images can be displayed from a link, for example link to the image from a HUC8 basin map\n" +
        "*   the SWSI workbook is formatted to facilitate review\n" +
        "*   the time series files organize data in linear fashion over the data period\n" +
        "*   use the `HUC8-DataComposite-SWSI` data type to display the overall SWSI value\n" +
        "    (where `HUC8` must be replaced with the specific basin name)\n" +
        "\n" +
        "| **HUC** | **HUC Name** | **SWSI Graph, History (`png`)** | **SWSI Graph, Recent (`png`)** | **SWSI Workbook (`xlsx`)** | **Time Series (`xlsx`)** | **Time Series (`csv`)** | **Time Series (DateValue, `dv`)** |\n" +
        "|--|--|--|--|--|--|--|--|\n")

    graphs_png_folder = Path(script_folder).parent / 'Results-Web' / 'graphs-png' / 'ALL-HUC'
    files = graphs_png_folder.rglob('HUC-14*history*.png')
    for file in files:
        # File will list with "history" file first and then "recent", similar to:
        #  HUC-10180001-SWSI-history-graph.png
        #  HUC-10180001-SWSI-recent-graph.png
        filename = file.name
        # Extract the HUC basin.
        parts = filename.split("-")
        huc = parts[1]

        # Get the HUC name for the code.
        try:
            huc_name = huc_dict[huc]
        except KeyError:
            # Hopefully will not happen.
            huc_name = ""

        history_filename = filename
        recent_filename = filename.replace("history", "recent")
        size = os.stat(file).st_size
        f.write('| {}'.format(huc))
        f.write('| {}'.format(huc_name))
        f.write('| [`{}`](graphs-png/ALL-HUC/{})'.format(history_filename, history_filename))
        f.write('| [`{}`](graphs-png/ALL-HUC/{})'.format(recent_filename, recent_filename))
        f.write('| [`{}-SWSI.xlsx`](swsi-by-huc/{}-SWSI.xlsx)'.format(huc,huc))
        f.write('| [`{}-TimeSeries.xlsx`](ts/{}-TimeSeries.xlsx)'.format(huc,huc))
        f.write('| [`{}-TimeSeries.csv`](ts/{}-TimeSeries.csv)'.format(huc,huc))
        f.write('| [`{}-TimeSeries.dv`](ts/{}-TimeSeries.dv) |\n'.format(huc,huc))

    f.write( "\n" +
        "### SWSI Products - HUC8 Basins by Month ###\n" +
        "\n" +
        "SWSI graph image files are available for each HUC8 basin for each month,\n" +
        "which illustrates the historical variability for each month.\n" +
        "\n" +
        "| **HUC** | **HUC Name** | **JAN** | **FEB** | **MAR** | **APR** | **MAY** | **JUN** | **JUL** | **AUG** | **SIP** | **OCT** | **NOV** | **DEC** |\n" +
        "|--|--|--|--|--|--|--|--|--|--|--|--|--|--|\n")

    # Use January to get the list of files and then expand to all months below.
    graphs_png_folder = Path(script_folder).parent / 'Results-Web' / 'graphs-png' / '01-JAN-HUC'
    files = graphs_png_folder.rglob('HUC-14*history*.png')
    months = [
        'JAN',
        'FEB',
        'MAR',
        'APR',
        'MAY',
        'JUN',
        'JUL',
        'AUG',
        'SEP',
        'OCT',
        'NOV',
        'DEC'
    ]
    for file in files:
        # Filename is similar to:
        #   HUC-10180001-SWSI-history-JAN-graph.png
        filename = file.name
        huc = filename.split("-")[1]
        f.write( '| {}'.format(huc))

        # Get the HUC name for the code.
        try:
            huc_name = huc_dict[huc]
        except KeyError:
            # Hopefully will not happen.
            huc_name = ""
        f.write( '| {}'.format(huc_name))

        for imon in range(0,12):
            f.write( ' | [{}](graphs-png/{:02}-{}-HUC/HUC-{}-SWSI-history-{}-graph.png)'.format(months[imon], (imon + 1), months[imon], huc, months[imon]))
        f.write("|\n")

    # Close the output file.
    f.close()

    print("The output (detail insert) file is:")
    print("  {}".format(insert_file))

    exit(0)
