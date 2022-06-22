#!/bin/bash
#
# This script copies the current workflow files into a 'test-months/YYYY-MM' folder,
# with user confirmation.

# Supporting functions, alphabetized.

# Copy the current workflow files to the 'test-months' folder:
# - the ${destFolder} must have been set to the 'test-months/subfolder' to copy into
# - return 0 if successful, 1 if an error
copyWorkflowToTest() {
  if [ ! -d "${destFolder}" ]; then
    # The destination folder does not exist so create it.
    mkdir -p "${destFolder}"
    if [ $? -ne 0 ]; then
      echo "[ERROR] unable to create the folder: ${destFolder}"
      return 1
    fi
    # Copy the folders one by one to make sure that only the minimal needed files are copied:
    # - use cp -r to ensure that folders are created
    echo "[INFO] Copying the workflow files to: ${destFolder}"
    createFolder ${destFolder}/00-RunSteps01-27
    cp -v ${workflowFolder}/00-RunSteps01-27/*.tstool ${destFolder}/00-RunSteps01-27
    createFolder ${destFolder}/00-RunSteps30-55
    cp -v ${workflowFolder}/00-RunSteps30-55/*.tstool ${destFolder}/00-RunSteps30-55
    createFolder ${destFolder}/01-DownloadNaturalFlowTimeSeries
    cp -v ${workflowFolder}/01-DownloadNaturalFlowTimeSeries/*.tstool ${destFolder}/01-DownloadNaturalFlowTimeSeries
    createFolder ${destFolder}/02-DownloadReservoirStorageTimeSeries
    cp -v ${workflowFolder}/02-DownloadReservoirStorageTimeSeries/*.tstool ${destFolder}/02-DownloadReservoirStorageTimeSeries
    createFolder ${destFolder}/04-DownloadNaturalFlowForecastTimeSeries
    cp -v ${workflowFolder}/04-DownloadNaturalFlowForecastTimeSeries/*.tstool ${destFolder}/04-DownloadNaturalFlowForecastTimeSeries
    createFolder ${destFolder}/20-CheckRawTimeSeries
    cp -v ${workflowFolder}/20-CheckRawTimeSeries/20-CheckRawTimeSeries.tstool ${destFolder}/20-CheckRawTimeSeries
    cp -v ${workflowFolder}/20-CheckRawTimeSeries/Template-Check-InputTimeSeries.tstool ${destFolder}/20-CheckRawTimeSeries
    createFolder ${destFolder}/25-FillDataAuto
    cp -v ${workflowFolder}/25-FillDataAuto/25-FillDataAuto.tstool ${destFolder}/25-FillDataAuto
    createFolder ${destFolder}/27-FillDataManual
    cp -v ${workflowFolder}/27-FillDataManual/27-FillDataManual.tstool ${destFolder}/27-FillDataManual
    createFolder ${destFolder}/30-CreateTimeSeriesForSWSI
    cp -v ${workflowFolder}/30-CreateTimeSeriesForSWSI/30-CreateTimeSeriesForSWSI.tstool ${destFolder}/30-CreateTimeSeriesForSWSI
    cp -v ${workflowFolder}/30-CreateTimeSeriesForSWSI/Template-Check-ComponentTimeSeries.tstool ${destFolder}/30-CreateTimeSeriesForSWSI
    createFolder ${destFolder}/50-CalculateSWSI-HUC
    cp -v ${workflowFolder}/50-CalculateSWSI-HUC/50-CalculateSWSI-HUC.tstool ${destFolder}/50-CalculateSWSI-HUC
    cp -v ${workflowFolder}/50-CalculateSWSI-HUC/*.tsp ${destFolder}/50-CalculateSWSI-HUC
    createFolder ${destFolder}/55-CalculateSWSI-Basin
    cp -v ${workflowFolder}/55-CalculateSWSI-Basin/*.tstool ${destFolder}/55-CalculateSWSI-Basin
    cp -v ${workflowFolder}/55-CalculateSWSI-Basin/*.tsp ${destFolder}/55-CalculateSWSI-Basin
    createFolder ${destFolder}/60-OptionalSteps/60a-CompareHistSWSI-NRCS
    cp -v ${workflowFolder}/60-OptionalSteps/60a-CompareHistSWSI-NRCS/*.tstool ${destFolder}/60-OptionalSteps/60a-CompareHistSWSI-NRCS
    cp -v ${workflowFolder}/60-OptionalSteps/60a-CompareHistSWSI-NRCS/*.tsp ${destFolder}/60-OptionalSteps/60a-CompareHistSWSI-NRCS
    createFolder ${destFolder}/60-OptionalSteps/60b-GenerateCurrentSummaries
    cp -v ${workflowFolder}/60-OptionalSteps/60b-GenerateCurrentSummaries/*.tstool ${destFolder}/60-OptionalSteps/60b-GenerateCurrentSummaries
    createFolder ${destFolder}/60-OptionalSteps/60c-CompareFcstSWSI-NRCS
    cp -v ${workflowFolder}/60-OptionalSteps/60c-CompareFcstSWSI-NRCS/*.tstool ${destFolder}/60-OptionalSteps/60c-CompareFcstSWSI-NRCS
    cp -v ${workflowFolder}/60-OptionalSteps/60c-CompareFcstSWSI-NRCS/*.tsp ${destFolder}/60-OptionalSteps/60c-CompareFcstSWSI-NRCS
    cp "${workflowFolder}/CO-SWSI-Control.xlsx" ${destFolder}
    if [ ! -d "${destFolder}/Input-TimeSeries-ForSWSI" ]; then
      mkdir "${destFolder}/Input-TimeSeries-ForSWSI"
    fi
    if [ ! -d "${destFolder}/Input-TimeSeries-Raw" ]; then
      mkdir "${destFolder}/Input-TimeSeries-Raw"
    fi
    if [ ! -d "${destFolder}/Results-Web" ]; then
      mkdir "${destFolder}/Results-Web"
    fi
  fi
  return 0
}

# Create a folder if it does not exist.
createFolder() {
  folder=$1
  if [ -z "${folder}" ]; then
    return
  fi
  if [ ! -d "${folder}" ]; then
    mkdir -p "${folder}"
  fi
}

# Main entry point into the script.

# Get the folder where this script is located since it may have been run from any folder.
scriptFolder=$(cd $(dirname "$0") && pwd)
repoFolder=$(dirname ${scriptFolder})
workflowFolder="${repoFolder}/workflow"
testMonthsFolder="${repoFolder}/test-months"

echo "[INFO] Existing testing folders in: ${testMonthsFolder}"
ls -1 ${testMonthsFolder} | grep -v README

echo ""
echo "Specify a month folder YYYY-MM to create/update for testing, for example $(date +%Y-%m)."
echo "The required files from the current 'workflow' folder will be copied to the test folder."
echo "It is OK to use a variation such as: $(date +%Y-%m).ver1"
read -p "YYYY-MM (or q to quit): " answer

if [ -z "${answer}" ]; then
  echo "[ERROR] No month was specified. Exiting."
  exit 0
elif [ "${answer}" = "Q" -o "${answer}" = "q" ]; then
  exit 0
fi

# Determine the folder for testing.
destFolder="${testMonthsFolder}/${answer}"

# If the folder exists, ask whether to remove.

if [ -d "${destFolder}" ]; then
  echo ""
  echo "The destination folder exists: ${destFolder}"
  read -p "Remove before copying (Y/q)?  " answer
  if [ -z "${answer}" -o "${answer}" = "Y" -o "${answer}" = "y" ]; then
    rm -rf "${destFolder}"
    if [ $? -ne 0 ]; then
      echo "[ERROR] unable to remove the folder: ${destFolder}"
      echo "[ERROR] Make sure that files and command shells are not open in the folder."
      exit 1
    else
      echo "[INFO] Successfully removed folder: ${destFolder}"
    fi
  elif [ "${answer}" = "Q" -o "${answer}" = "q" ]; then
    exit 0
  fi
fi

# Copy the workflow files.
copyWorkflowToTest

exit $?
