#!/bin/bash
#
# Copy the latest Babbitt Center SWSI workflow installer matching the
# current version to the models.openwaterfoundation.org website:
# - replace the installer file on the web with local file if it exists
# - also update the catalog file that lists available SWSI downloaders
# - must specify the Amazon profile as argument to the script
# - DO NOT FORGET TO CHANGE THE programVersion and programVersionDate when making changes

# Supporting functions, alphabetized

# Check input:
# - make sure that the Amazon profile was specified
checkInput() {
  if [ -z "${awsProfile}" ]; then
    logError ""
    logError "Amazon profile to use for upload was not specified with --aws-profile option.  Exiting."
    printUsage
    exit 1
  fi
}

# Determine the operating system that is running the script
# - sets the variable operatingSystem to 'cygwin', 'linux', or 'mingw' (Git Bash)
# - sets the variable operatingSystemShort to 'cyg', 'lin', or 'min' (Git Bash)
checkOperatingSystem() {
  if [ ! -z "${operatingSystem}" ]; then
    # Have already checked operating system so return.
    return
  fi
  operatingSystem="unknown"
  os=$(uname | tr [a-z] [A-Z])
  case "${os}" in
    CYGWIN*)
      operatingSystem="cygwin"
      operatingSystemShort="cyg"
      ;;
    LINUX*)
      operatingSystem="linux"
      operatingSystemShort="lin"
      ;;
    MINGW*)
      operatingSystem="mingw"
      operatingSystemShort="min"
      ;;
  esac
  logInfo ""
  logInfo "Detected operatingSystem=${operatingSystem} operatingSystemShort=${operatingSystemShort}"
  logInfo ""
}

# Echo to stderr
# - if necessary, quote the string to be printed
# - this function is called to print various message types
echoStderr() {
  echo "$@" 1>&2
}

# Get the CloudFront distribution ID from the bucket so the ID is not hard-coded.
# The distribution ID is echoed and can be assigned to a variable.
# The output is similar to the following (obfuscated here):
# ITEMS   arn:aws:cloudfront::123456789000:distribution/ABCDEFGHIJKLMN    learn.openwaterfoundation.org   123456789abcde.cloudfront.net   True    HTTP2   ABCDEFGHIJKLMN  True    2022-01-05T23:29:28.127000+00:00        PriceClass_100  Deployed
getCloudFrontDistribution() {
  local cloudFrontDistributionId subdomain
  subdomain="models.openwaterfoundation.org"
  cloudFrontDistributionId=$(${awsExe} cloudfront list-distributions --output text --profile "${awsProfile}" | grep ${subdomain} | grep "arn:" | awk '{print $2}' | cut -d ':' -f 6 | cut -d '/' -f 2)
  echo ${cloudFrontDistributionId}
}

# Get the SWSI version (e.g., 2.1.0):
# - the version.txt file in the main repo folder contains the version, with format similar to:
#      version="2.1.0 (2023-05-03)"
# - 'repoFolder' variable must be set to the path to the repository
# - the version is printed to stdout so assign function output to a variable
getSwsiVersion() {
  versionFile="${repoFolder}/version.txt"
  if [ -f "${versionFile}" ]; then
    cat ${versionFile} | grep 'VERSION =' | cut -d '"' -f 2 | cut -d ' ' -f 1 | tr -d '"' | tr -d ' '
  else
    # Don't echo error to stdout.
    echoStderr "[ERROR] Source file with version does not exist:"
    echoStderr "[ERROR]   ${versionFile}"
    cat ""
  fi
  swsiVersion=$(cat ${versionFile} | grep 'version=' | grep -v '#' | cut -d '=' -f 2 | cut -d ' ' -f 1 | tr -d ' ' | tr -d '"')
  if [ -z "${swsiVersion}" ]; then
    echoStderr "[ERROR] Unable to determine the SWSI version from file:"
    echoStderr "[ERROR]   ${versionFile}"
    exit 1
  fi
  # Echo so calling code can assign to a variable.
  echo "${swsiVersion}"
}

# Invalidate a CloudFront distribution for files:
# - first parameter is the CloudFront distribution ID
# - second parameter is the CloudFront path (file or folder path).
# - ${awsProfile} must be set in global data
invalidateCloudFront() {
  local errorCode cloudFrontDistributionId cloudFrontPath
  if [ -z "$1" ]; then
    logError "CloudFront distribution ID is not specified.  Script error."
    return 1
  fi
  if [ -z "$2" ]; then
    logError "CloudFront path is not specified.  Script error."
    return 1
  fi
  # Check global data.
  if [ -z "${awsProfile}" ]; then
    logError "'awsProfile' is not set.  Script error."
    exit 1
  fi
  cloudFrontDistributionId=$1
  cloudFrontPath=$2

  # Invalidate for CloudFront so that new version will be displayed:
  # - see:  https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html
  # - TODO smalers 2020-04-13 for some reason invalidating /index.html does not work, have to do /index.html*
  echo "Invalidating files so CloudFront will make new version available..."
  if [ "${operatingSystem}" = "mingw" ]; then
    # The following is needed to avoid MinGW mangling the paths, just in case a path without * is used:
    # - tried to use a variable for the prefix but that did not work
    MSYS_NO_PATHCONV=1 ${awsExe} cloudfront create-invalidation --distribution-id "${cloudFrontDistributionId}" --paths "${cloudFrontPath}" --output json --profile "${awsProfile}"
  else
    ${awsExe} cloudfront create-invalidation --distribution-id "${cloudFrontDistributionId}" --paths "${cloudFrontPath}" --output json --profile "${awsProfile}"
  fi
  errorCode=$?

  return ${errorCode}
}

# Print a DEBUG message, currently prints to stderr.
logDebug() {
   echoStderr "[DEBUG] $@"
}

# Print an ERROR message, currently prints to stderr.
logError() {
   echoStderr "[ERROR] $@"
}

# Print an INFO message, currently prints to stderr.
logInfo() {
   echoStderr "[INFO] $@"
}

# Print an WARNING message, currently prints to stderr.
logWarning() {
   echoStderr "[WARNING] $@"
}

# Parse the command parameters:
# - use the getopt command line program so long options can be handled
parseCommandLine() {
  # Single character options.
  optstring="hv"
  # Long options.
  optstringLong="aws-profile::,dryrun,help,include-windows::,version"
  # Parse the options using getopt command.
  GETOPT_OUT=$(getopt --options $optstring --longoptions $optstringLong -- "$@")
  exitCode=$?
  if [ $exitCode -ne 0 ]; then
    # Error parsing the parameters such as unrecognized parameter.
    echoStderr ""
    printUsage
    exit 1
  fi
  # The following constructs the command by concatenating arguments.
  eval set -- "$GETOPT_OUT"
  # Loop over the options.
  while true; do
    #logDebug "Command line option is ${opt}".
    case "$1" in
      --aws-profile) # --aws-profile=profile  Specify the AWS profile (use default).
        case "$2" in
          "") # Nothing specified so error.
            logError "--aws-profile=profile is missing profile name"
            exit 1
            ;;
          *) # profile has been specified.
            awsProfile=$2
            shift 2
            ;;
        esac
        ;;
      --dryrun) # --dryrun  Indicate to AWS commands to do a dryrun but not actually upload.
        logInfo "--dryrun dectected - will not change files on S3"
        dryrun="--dryrun"
        shift 1
        ;;
      -h|--help) # -h or --help  Print the program usage.
        printUsage
        exit 0
        ;;
      -v|--version) # -v or --version  Print the program version.
        printVersion
        exit 0
        ;;
      --) # No more arguments.
        shift
        break
        ;;
      *) # Unknown option.
        logError "" 
        logError "Invalid option $1." >&2
        printUsage
        exit 1
        ;;
    esac
  done
}

# Print the program usage to stderr:
# - calling code must exit with appropriate code
printUsage() {
  echoStderr ""
  echoStderr "Usage:  ${programName} --aws-profile=profile"
  echoStderr ""
  echoStderr "Copy the Babbit Center SWSI workflow installer file to the Amazon S3 static website folder:"
  echoStderr "  ${s3FolderUrl}"
  echoStderr "The latest installer matching the current SWSI version is uploaded."
  echoStderr ""
  echoStderr "--aws-profile=profile   Specify the Amazon profile to use for AWS credentials."
  echoStderr "--dryrun                Do a dryrun but don't actually upload anything."
  echoStderr "-h or --help            Print the usage."
  echoStderr "-v or --version         Print the version and copyright/license notice."
  echoStderr ""
}

# Print the script version and copyright/license notices to stderr.
# - calling code must exit with appropriate code
printVersion() {
  echoStderr ""
  echoStderr "${programName} version ${programVersion} ${programVersionDate}"
  echoStderr ""
}

# Set the AWS executable:
# - handle different operating systems
# - for AWS CLI V2, can call an executable
# - for AWS CLI V1, have to deal with Python
# - once set, use ${awsExe} as the command to run, followed by necessary command parameters
setAwsExe() {
  if [ "${operatingSystem}" = "mingw" ]; then
    # "mingw" is Git Bash:
    # - the following should work for V2
    # - if "aws" is in path, use it
    awsExe=$(command -v aws)
    if [ -n "${awsExe}" ]; then
      # Found aws in the PATH.
      awsExe="aws"
    else
      # Might be older V1.
      # Figure out the Python installation path.
      pythonExePath=$(py -c "import sys; print(sys.executable)")
      if [ -n "${pythonExePath}" ]; then
        # Path will be something like:  C:\Users\sam\AppData\Local\Programs\Python\Python37\python.exe
        # - so strip off the exe and substitute Scripts
        # - convert the path to posix first
        pythonExePathPosix="/$(echo "${pythonExePath}" | sed 's/\\/\//g' | sed 's/://')"
        pythonScriptsFolder="$(dirname "${pythonExePathPosix}")/Scripts"
        echo "${pythonScriptsFolder}"
        awsExe="${pythonScriptsFolder}/aws"
      else
        echo "[ERROR] Unable to find Python installation location to find 'aws' script"
        echo "[ERROR] Make sure Python 3.x is installed on Windows so 'py' is available in PATH"
        exit 1
      fi
    fi
  else
    # For other Linux, including Cygwin, just try to run.
    awsExe="aws"
  fi
}

# Update the Amazon S3 index that lists files for download:
# - this calls the 3-create-s3-index.bash script
updateIndex() {
  local answer
  echo ""
  read -p "Do you want to update the S3 index file [Y/n]? " answer
  if [ -z "$answer" -o "$answer" = "y" -o "$answer" = "Y" ]; then
    # TODO smalers 2020-04-06 comment out for now.
    if [ -z "${awsProfile}" ]; then
      # No AWS profile given so rely on default.
      ${scriptFolder}/3-create-s3-index.bash
    else
      # AWS profile given so use it.
      ${scriptFolder}/3-create-s3-index.bash --aws-profile=${awsProfile}
    fi
  fi
}

# Upload local installer files to Amazon S3
# - includes the most recent .zip file for the SWSI version
uploadInstaller() {
  # The location of the installer is
  # ===========================================================================
  # Step 1. Upload the installer file for the current version
  #         - use copy to force upload

  # Get the latest zip file for the SWSI version.
  # Count of successful installer uploads.
  installerUploadCount=0
  logInfo "Processing installers for SWSI version=${swsiVersion}"

  # File for the zip file (Windows).
  zipFilePattern="${distFolder}/swsi-workflow-babbitt-${swsiVersion}*.zip"
  logInfo "Zip file pattern is: ${zipFilePattern}"
  # Get the latest installer for the version.
  latestZipFile=$(ls -1 ${zipFilePattern} | sort -r | head -1)
  # File for S3.
  s3ZipUrl="${s3FolderUrl}/${swsiVersion}/download/$(basename ${latestZipFile})"
  if [ -f "${latestZipFile}" ]; then
    logInfo "  Uploading installer using following command:"
    logInfo "    ${awsExe} s3 cp ${latestZipFile} ${s3ZipUrl} ${dryrun} --profile \"${awsProfile}\""
    # Set this in case aws command is commented out, so 'if' statement below continues to work.
    # errorCode=0
    ${awsExe} s3 cp ${latestZipFile} ${s3ZipUrl} ${dryrun} --profile "${awsProfile}"
    errorCode=$?
    # { set +x; } 2> /dev/null
    if [ ${errorCode} -ne 0 ]; then
      logError ""
      logError "    [ERROR ${errorCode}] Error uploading SWSI installer file."
    else
      installerUploadCount=$(( ${installerUploadCount} + 1 ))

      # Invalidate the CloudFront distribution.
      cloudFrontDistributionId=$(getCloudFrontDistribution)
      if [ -z "${cloudFrontDistributionId}" ]; then
        echo "Error getting the CloudFront distribution."
        exit 1
      fi
      # Use a wildcard to invalidate subfolders.
      cloudFrontFile="/surface-water-supply-index/${swsiVersion}/download/*"
      invalidateCloudFront ${cloudFrontDistributionId} ${cloudFrontFile}
    fi
  else
    logError "  SWSI installer zip file does not exist:"
    logError "    ${latestZipFile}"
  fi
}

# Entry point into script.

# Get the location where this script is located since it may have been run from any folder.
programName=$(basename $0)
programVersion="1.0.0"
programVersionDate="2022-06-08"

# Check the operating system:
# - used to make logic decisions and for some file/folder names so do first
checkOperatingSystem

# Define top-level folders - everything is relative to this below to avoid confusion.
scriptFolder=$(cd $(dirname "$0") && pwd)
buildUtilFolder=${scriptFolder}
buildUtilTmpFolder="${buildUtilFolder}/build-tmp"
# Same as above.
distFolder="${buildUtilTmpFolder}"
repoFolder=$(dirname ${buildUtilFolder})

# Set the 'aws' program to use:
# - must set after the operating system is set
setAwsExe

# Root AWS S3 location where files are to be uploaded.
s3FolderUrl="s3://models.openwaterfoundation.org/surface-water-supply-index"

# Parse the command line.
# Specify AWS profile with --aws-profile
awsProfile=""
# Default is not to do 'aws' dry run
# - override with --dryrun
dryrun=""
parseCommandLine "$@"

# Check input:
# - check that Amazon profile was specified
checkInput

# Get the current SWSI version number from development environment files.
swsiVersion=$(getSwsiVersion)
if [ -z "${swsiVersion}" ]; then
  logError "Unable to determine SWSI version."
  exit 1
fi

# Upload the installer file(s) to Amazon S3:
# - depends on current SWSI version
uploadInstaller

# Also update the index, which lists all available installers that exist on S3:
# -installerUploadCount is set in uploadInstaller()
if [ "${installerUploadCount}" -eq 0 ]; then
  logInfo ""
  logInfo "No installers were uploaded - not updating the catalog."
  logInfo "Run 3-create-s3-index.bash separately if necessary."
else
  # Update the index for the installer.
  updateIndex
fi

# Print useful information to use after running the script.
logInfo ""
logInfo "${installerUpdateCount} SWSI installers were uploaded to Amazon S3 location:"
logInfo ""
logInfo "  ${s3FolderUrl}"
logInfo ""

exit 0
