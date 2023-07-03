#!/bin/sh

# Create a zip file containing the 'workflow/' and 'workflow-babbitt/' folders:
# - this is suitable for the Babbitt Center to use to initialize their workflow files
# - only include *.tstool command files, the main configuration file,
#   and any other files necessary to perform the analysis
# - otherwise, rely on online documentation and the Git repository to explain folder contents
# - all necessary subfolders are created by the workflow command files
# - the output zip filename is similar to:  build-tmp/swsi-workflow-babbitt-2.1.0.zip 

# Main entry point for script.

# Get the location where this script is located since it may have been run from any folder.
scriptFolder=$(cd $(dirname "$0") && pwd)
# The build-util folder is the same as the script's folder.
buildUtilFolder=${scriptFolder}
buildUtilTmpFolder="${buildUtilFolder}/build-tmp"
buildUtilTmpWorkflowFolder="${buildUtilTmpFolder}/workflow"
# Get the main repository folder.
repoFolder=$(dirname ${buildUtilFolder})

echo "[INFO] buildUtilFolder=${buildUtilFolder}"
echo "[INFO] buildUtilTmpFolder=${buildUtilTmpFolder}"
echo "[INFO] repoFolder=${repoFolder}"

# Get the SWSI workflow version:
# - the version.txt file in the main repo folder contains the version, with format similar to:
#      version="2.1.0 (2023-05-03)"
versionFile="${repoFolder}/version.txt"
if [ ! -e "${versionFile}" ]; then
  echo "[ERROR] SWSI version file does not exist:"
  echo "[ERROR]   ${versionFile}"
  exit 1
fi
swsiVersion=$(cat ${versionFile} | grep 'version=' | grep -v '#' | cut -d '=' -f 2 | cut -d ' ' -f 1 | tr -d ' ' | tr -d '"')
if [ -z "${swsiVersion}" ]; then
  echo "[ERROR] Unable to determine the SWSI version."
  exit 1
fi
echo "[INFO] SWSI version determined to be: ${swsiVersion}"

# Zip file depends on the version:
# - the empty temporary folder exists in the repo
if [ ! -d "${buildUtilTmpFolder}" ]; then
  echo "[ERROR] build-util/tmp folder does not exist:"
  echo "[ERROR]   ${buildUtilTmpFolder}"
  exit 1
fi
zipFile="${buildUtilTmpFolder}/swsi-workflow-babbitt-${swsiVersion}.zip"

# Zip up all files in the folder that have file extensions of interest
# - use 7zip command line (must be installed in normal location)
# - zip with the folder so that there is less chance to clobber existing files
# - use a list file to control what files are included
sevenzipExe='/C/Program Files/7-Zip/7z.exe'
if [ ! -e "${sevenzipExe}" ]; then
  echo "[ERROR] the 7zip program does not exist:"
  echo "[ERROR]   ${sevenzipExe}"
  exit 1
fi

# Remove the file first so there is no merging.
if [ -f "${zipFile}" ]; then
  echo "[INFO] Removing old zip file:"
  echo "[INFO]   ${zipFile}"
  rm "${zipFile}"
else
  echo "[INFO] Old zip file does not exist (will create new file):"
  echo "[INFO]   ${zipFile}"
fi

# Change to main repository folder:
# - zip up the TSTool command files and main configuration file
echo "[INFO] Changing to repository folder:"
echo "[INFO]   ${repoFolder}"
cd ${repoFolder}

listFileUnsorted="${buildUtilTmpFolder}/swsi-file-list-unsorted.txt"
listFile="${buildUtilTmpFolder}/swsi-file-list.txt"
# Include relevant files and ignore dynamic files.
# - ignore specific files that are used in development but should not be included (can't seem to use ls -I for this so use grep)
# - ignore errors for files that don't exist
# - only include 'workflow/' and `workflow-babbitt/` files (essentially `workflow/`), not 'test/'
# - the list file entries apparently must start with 'workflow/' and not './workflow/' in order for 7zip to include the paths in the archive
#   (otherwise just the filenames are used)
# - TODO smalers 2023-05-08 need to streamline this more
find . -name '*.tstool' | grep -E 'workflow/' | grep -v 'build-util' | sed 's#\./workflow#workflow#g' 2> /dev/null > ${listFileUnsorted}
find . -name '*template.tsp' | grep 'workflow/' | grep -v 'build-util' | sed 's#\./workflow#workflow#g' 2> /dev/null >> ${listFileUnsorted}
find . -name 'CO-SWSI-Control.xlsx' | grep 'workflow/' | sed 's#\./workflow#workflow#g' 2> /dev/null >> ${listFileUnsorted}

# Sort the list file.
sort ${listFileUnsorted} > ${listFile}

echo "[INFO] Running 7zip to create zip file:"
echo "[INFO]   ${zipFile}"
"${sevenzipExe}" a -tzip ${zipFile} @${listFile}
exitStatus=$?
if [ ${exitStatus} -ne 0 ]; then
  echo "[ERROR] Error running 7zip, exit status (${exitStatus})."
  exit 1
fi

# Merge the 'workflow-babbitt/' files:
# - need to use a top-level folder 'workflow/' so copy to a temporary folder
if [ -d "${buildUtilTmpWorkflowFolder}" ]; then
  # Remove the existing folder.
  echo "[INFO] Removing the existing folder:"
  echo "[INFO]   ${buildUtilTmpWorkflowFolder}"
  rm -rf "${buildUtilTmpWorkflowFolder}"
fi

# Copy the 'workflow-babbitt' files to the temporary folder.
echo "[INFO] Copying workflow-babbitt/ files:"
echo "[INFO]    from: ${repoFolder}/workflow-babbitt"
echo "[INFO]      to: ${buildUtilTmpWorkflowFolder}"
cp -r ${repoFolder}/workflow-babbitt ${buildUtilTmpWorkflowFolder}
cd "${buildUtilTmpFolder}"

listFile2="${buildUtilTmpFolder}/swsi-file-list2.txt"
# Include the folder workflow folders of interest:
# - include input not output files
find . | grep '01-DownloadColoradoProducts/' | grep -v '.gitignore' | grep -v '.log' | sed 's#\./workflow#workflow#g' 2> /dev/null > ${listFile2}
find . | grep '70-InfoProducts/' | grep -E '.tstool|symtable.csv|HeatMap.tsp' | grep -v '/results' | grep -v '/downloads' | grep -v '.log' | sed 's#\./workflow#workflow#g' 2> /dev/null >> ${listFile2}
find . | grep '80-UploadToCloud-OWF/' | grep -E '.tstool|dataset-details-0.md|dataset-0.json|dataset.png|create-dataset-details-insert.py' | grep -v '/results' | grep -v '/downloads' | grep -v '.log' | grep -v 'x-' | sed 's#\./workflow#workflow#g' 2> /dev/null >> ${listFile2}
find . | grep '80-UploadToCloud-Babbitt/' | grep -E '.tstool|dataset-details-0.md|dataset-0.json|dataset.png|create-dataset-details-insert.py' | grep -v '/results' | grep -v '/downloads' | grep -v '.log' | grep -v 'x-' | sed 's#\./workflow#workflow#g' 2> /dev/null >> ${listFile2}
echo "[INFO] Running 7zip to append workflow-babbitt files to the zip file:"
echo "[INFO]   ${zipFile}"
"${sevenzipExe}" a -tzip ${zipFile} @${listFile2}
exitStatus=$?
if [ ${exitStatus} -ne 0 ]; then
  echo "[ERROR] Error running 7zip, exit status (${exitStatus})."
  exit 1
fi

echo "[INFO] Zip file for current SWSI version is:"
echo "[INFO]   ${zipFile}"

exit 0
