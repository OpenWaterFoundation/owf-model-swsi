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
    # Copy the folders one by one to make sure that only the minimal needed files are copied.
    echo "[INFO] Copying the workflow files to: ${destFolder}"
    cp -rv "${workflowFolder}/00-RunSteps01-27/" ${destFolder}
    cp -rv "${workflowFolder}/00-RunSteps30-55/" ${destFolder}
    cp -rv "${workflowFolder}/01-DownloadNaturalFlowTimeSeries/" ${destFolder}
    cp -rv "${workflowFolder}/02-DownloadReservoirStorageTimeSeries/" ${destFolder}
    cp -rv "${workflowFolder}/04-DownloadNaturalFlowForecastTimeSeries/" ${destFolder}
    cp -rv "${workflowFolder}/20-CheckRawTimeSeries/" ${destFolder}
    cp -rv "${workflowFolder}/25-FillDataAuto/" ${destFolder}
    cp -rv "${workflowFolder}/27-FillDataManual/" ${destFolder}
    cp -rv "${workflowFolder}/30-CreateTimeSeriesForSWSI/" ${destFolder}
    cp -rv "${workflowFolder}/50-CalculateSWSI-HUC/" ${destFolder}
    cp -rv "${workflowFolder}/55-CalculateSWSI-Basin/" ${destFolder}
    cp -rv "${workflowFolder}/60-OptionalSteps/" ${destFolder}
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
