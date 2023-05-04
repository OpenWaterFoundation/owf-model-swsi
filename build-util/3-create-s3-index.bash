#!/bin/bash
#
# Create the SWSI product 'index.html' page on Amazon S3,
# which serves as the main download page for the product.
# The installers that are listed are determined by listing the S3 bucket contents.
# The following files are created on the S3 bucket:
#
# models.openwaterfoundation.org/surface-water-supply-index/index.html
# models.openwaterfoundation.org/surface-water-supply-index/index.csv
#

# Supporting functions, alphabetized.

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
    # Have already checked operating system so return
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

# Create a local catalog file by listing the S3 bucket contents:
# - this is used to create the index.html
#
# 'aws ls' output similar to:
#   2023-05-03 16:16:22          0 surface-water-supply-index/
#   2023-05-03 16:16:37          0 surface-water-supply-index/2.1.0/
#   2023-05-03 16:17:19   46281975 surface-water-supply-index/2.1.0/swsi-workflow-babbitt-2.1.0.zip
createCatalogFile() {
  logInfo "Creating catalog file from contents of Amazon S3 files."
  # For debugging.
  #set -x
  logInfo "Listing AWS S3 installers with:"
  logInfo "  ${awsExe} s3 ls \"${s3FolderUrl}\" --profile \"${awsProfile}\" --recursive > ${tmpS3ListingPath}"
  ${awsExe} s3 ls "${s3FolderUrl}" --profile "${awsProfile}" --output text --recursive > ${tmpS3ListingPath}
  errorCode=$?
  #{ set +x; } 2> /dev/null
  if [ ${errorCode} -ne 0 ]; then
    logError ""
    logError "Error listing SWSI download files to create catalog (maybe missing --aws-profile)?"
    exit 1
  fi
  # Pull out the installers available for all platforms since the catalog
  # is used to download to all platforms.
  # - search for tar.gz and zip files
  tmpS3CatalogPath="/tmp/${USER}-swsi-catalog-ls-installers.txt"
  # Only list installers that match the current download filename specification
  cat ${tmpS3ListingPath} | grep -E '.*swsi-.*.zip' > ${tmpS3CatalogPath}
  logInfo "Available SWSI installers:"
  logInfo "  List file: ${tmpS3CatalogPath}"
  logInfo "  List file contents (below):"
  cat ${tmpS3CatalogPath}
}

# Upload the index.html file for the download static website:
# - this is basic at the moment but can be improved in the future such as
#   software.openwaterfoundation.org page, but for only one product, with list of variants and versions
createIndexHtmlFiles() {
  # Create an index.html file for upload:
  # - include Google Analytics for OWF
  indexHtmlTmpFile="/tmp/${USER}-swsi-index.html"
  s3IndexHtmlUrl="${s3FolderUrl}/index.html"
  indexFaviconFile="OWF-Logo-Favicon-32x32.png"
  s3IndexFaviconUrl="${s3FolderUrl}/${indexFaviconFile}"
  echo '<!DOCTYPE html>
<head>' > ${indexHtmlTmpFile}
  echo "<link rel=\"icon\" type=\"image/x-icon\" href=\"${indexFaviconFile}\">" >> ${indexHtmlTmpFile}
  echo '
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta charset="utf-8"/>' >> ${indexHtmlTmpFile}

echo "
<!-- Start Google Analytics 4 property. -->
<script async src=\"https://www.googletagmanager.com/gtag/js?id=G-KJFMBY739T\"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'G-KJFMBY739T');
</script>
<!-- End Google Analytics 4 property. -->" >> ${indexHtmlTmpFile}

echo '
<style>
   body {
     font-family: "Trebuchet MS", Helvetica, sans-serif !important;
   }
   table {
     border-collapse: collapse;
     padding: 3px;
   }
   tr {
     border: none;
   }
   th {
     border-right: solid 1px;
     border-left: solid 1px;
     border-bottom: solid 1px;
     padding: 3px;
   }
   td {
     border-right: solid 1px;
     border-left: solid 1px;
     padding: 3px;
   }
</style>

<title>SWSI Workflow Downloads</title>
</head>' >> ${indexHtmlTmpFile}

echo '
<body>
<h1>Surface Water Supply Index (SWSI) Workflow Downloads</h1>
<p>
The SWSI is a monthly index to estimate water supply conditions, using snowpack, reservoir storage, and streamflow data.
It is implemented as a workflow of TSTool command files.
</p>
<p>
The workflow files are run using the
<a href="https://opencdss.state.co.us/tstool/">TSTool software</a>.
Installers that include `babbitt` in the name are for the Babbitt Center indicators project,
which is an extension of the core SWSI workflow,
as described in Appendix G of the documentation.
</p>
<p>
<ul>
<li> See the latest <a href="https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/"> documentation</a>
     for information (or follow a link below for specific version documentation).</li>
<li>The SWSI workflow requires that TSTool is also installed if not already installed:
    <ul>
    <li><a href="https://opencdss.state.co.us/tstool/">Download TSTool</a>.</li>
    </ul>
    </li>
<li><b>If clicking on a file download link does not download the file, right-click on the link and use "Save link as..." (or similar).</b></li>
</ul>' >> ${indexHtmlTmpFile}

  # Generate a table of available versions.
  createIndexHtmlFile_Table win

echo '
</body>
</html>' >> ${indexHtmlTmpFile}

}

# Create a table of downloads for an operating system to be used in the index.html file.
createIndexHtmlFile_Table() {
  # Operating system is passed in as the required first argument.
  downloadOs=$1
  echo '<table>' >> ${indexHtmlTmpFile}
  # List the available download files.
  # Listing local files does not show all available files on Amazon but may be useful for testing.
  catalogSource="aws"  # "aws" or "local".
  if [ "${catalogSource}" = "aws" ]; then
    # Use AWS list from catalog file for the index.html file download file list,
    # with format like the following (no space at beginning of the line):
    #
    # 2023-05-03 23:47:46     224712 surface-water-supply-index/2.1.0/download/swsi-workflow-babbitt-2.1.0.zip
    #
    # Use awk below to print the line with single space between tokens.
    # awk by default allows multiple spaces to be used.
    # Replace normal version to have -zzz at end and "dev" version to be "-dev" so that sort is correct,
    #   then change back to previous strings for output.
    # The use space as the delimiter and sort on the 3rd token.
    echo '<tr><th>Download File</th><th>Product</th><th>Version</th><th>File Timestamp</th><th>Size (Bytes)</th><th>Operating System</th><th>User Doc</th><th>Dev Doc</th></tr>' >> ${indexHtmlTmpFile}
    # Version before sort...
    # cat "${tmpS3CatalogPath}" | grep "${downloadOs}-" | sort -r | awk '
    logInfo "Processing S3 catalog file to create index.html:"
    logInfo "  AWS catalog:  ${tmpS3CatalogPath}"
    logInfo "   index.html:  ${indexHtmlTmpFile}"
    cat "${tmpS3CatalogPath}" | awk '{ printf "%s %s %s %s\n", $1, $2, $3, $4 }' | sed -E 's|([0-9][0-9]/)|\1-zzz|g' | sed 's|/-zzz|-zzz|g' | sed 's|dev|-dev|g' | sort -r -k4,4 | sed 's|-zzz||g' | sed 's|-dev|dev|g'  | awk '
      {
        # Download file is the full line
        downloadFileDate = $1
        downloadFileTime = $2
        downloadFileSize = $3
        downloadFilePath = $4
        # Split the download file path into parts to get the download file without path
        split(downloadFilePath,downloadFilePathParts,"/")
        # Split the download file into parts to get other information.
        filenameSpecVersion = 1
        downloadFile=""                   # Only the filename part of the file
        downloadFileProduct=""            # The product name (e.g., swsi-workflow)
        downloadFileOs=""                 # Operating system
        docUserUrl=""                     # User documentation URL
        docDevUrl=""                      # Developer documentation URL
        if ( filenameSpecVersion = 1 ) {
          # Initial filename spec using format:  surface-water-supply-index/2.1.0.dev/download/swsi-workflow-babbitt-2.1.0.zip
          downloadFile=downloadFilePathParts[4]
          # Split the download file into parts.
          split(downloadFile,downloadFileParts,"-")
          #downloadFileProduct=downloadFileParts[1]
          # Product is in multiple tokens so hard code.
          downloadFileProduct="swsi-workflow-babbitt"
          # The following will be something like 2.1.0.zip so have to remove the extension.
          partLength=length(downloadFileParts[4])
          downloadFileVersion=substr(downloadFileParts[4],1,(partLength - 4))
          downloadFileOs="all"
        }
        # Set the URL to the download file.
        downloadFileUrl=sprintf("https://models.openwaterfoundation.org/surface-water-supply-index/%s/download/%s", downloadFileVersion, downloadFile)
        product = "SWSI Workflow"
        # Documentation URLs are based on the software version.
        # Documentation links for development and user documentation are only shown if exist
        # - the file returned by curl is actually the index.html file
        docDevUrl=sprintf("https://models.openwaterfoundation.org/surface-water-supply-index/%s/doc-dev",downloadFileVersion)
        docDevCurl=sprintf("curl --insecure --output /dev/null --silent --head --fail \"%s\"",docDevUrl)
        returnStatus=system(docDevCurl)
        if ( returnStatus == 0 ) {
          docDevHtml=sprintf("<a href=\"%s\">View</a>",docDevUrl)
        }
        else {
          docDevHtml=""
        }
        docUserUrl=sprintf("https://models.openwaterfoundation.org/surface-water-supply-index/%s/doc-user",downloadFileVersion)
        docDevCurl=sprintf("curl --insecure --output /dev/null --silent --head --fail \"%s\"",docUserUrl)
        returnStatus=system(docDevCurl)
        if ( returnStatus == 0 ) {
          docUserHtml=sprintf("<a href=\"%s\">View</a>",docUserUrl)
        }
        else {
          docUserHtml=""
        }
        printf "<tr><td><a href=\"%s\"><code>%s</code></a></td><td>%s</td><td>%s</td><td>%s %s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", downloadFileUrl, downloadFile, product, downloadFileVersion, downloadFileDate, downloadFileTime, downloadFileSize, downloadFileOs, docUserHtml, docDevHtml
      }' >> ${indexHtmlTmpFile}
  else
    # List local files in the index.html file download file list
    # Change to the folder where *.zip and *.tar.gz files are and list, with names like:
    #     gp-1.2.0dev-win-venv.zip
    #     gptest-1.0.0-cyg-venv.tar.gz
    # cd ${virtualenvTmpFolder}
    # echo '<tr><th>Download File</th><th>Product</th><th>Version</th><th>Operating System</th></tr>' >> $indexHtmlTmpFile
    # ls -1 *.zip *.tar.gz | grep "${downloadOs}-" | sort -r | awk '
    #   {
    #     # Download file is the full line
    #     downloadFile = $1
    #     # Version is the second part of he download file, dash-delimited
    #     split(downloadFile,downloadFileParts,"-")
    #     downloadFileProduct=downloadFileParts[1]
    #     downloadFileVersion=downloadFileParts[2]
    #     downloadFileOs=downloadFileParts[3]
    #     printf "<tr><td><a href=\"%s/%s\"><code>%s</code></a></td><td>%s</td><td>%s</td><td>%s</td></tr>", downloadFileUrl, downloadFile, downloadFile, downloadFileProduct, downloadFileVersion, downloadFileOs
    #   }' >> $indexHtmlTmpFile
    :
  fi
  echo '</table>' >> ${indexHtmlTmpFile}
}

# Get the CloudFront distribution ID from the bucket so the ID is not hard-coded.
# The distribution ID is echoed and can be assigned to a variable.
# The output is similar to the following (obfuscated here):
# ITEMS   arn:aws:cloudfront::123456789000:distribution/ABCDEFGHIJKLMN    models.openwaterfoundation.org   123456789abcde.cloudfront.net   True    HTTP2   ABCDEFGHIJKLMN  True    2022-01-05T23:29:28.127000+00:00        PriceClass_100  Deployed
getCloudFrontDistribution() {
  local cloudFrontDistributionId subdomain
  subdomain="models.openwaterfoundation.org"
  cloudFrontDistributionId=$(${awsExe} cloudfront list-distributions --output text --profile "${awsProfile}" | grep ${subdomain} | grep "arn:" | awk '{print $2}' | cut -d ':' -f 6 | cut -d '/' -f 2)
  logInfo "CloudFront distribution ID = ${cloudFrontDistributionId}"
  # Echo so that calling code can set to a variable.
  echo ${cloudFrontDistributionId}
}

# Get the user's login.
# - Git Bash apparently does not set $USER environment variable, not an issue on Cygwin
# - Set USER as script variable only if environment variable is not already set
# - See: https://unix.stackexchange.com/questions/76354/who-sets-user-and-username-environment-variables
getUserLogin() {
  if [ -z "${USER}" ]; then
    if [ ! -z "${LOGNAME}" ]; then
      USER=${LOGNAME}
    fi
  fi
  if [ -z "${USER}" ]; then
    USER=$(logname)
  fi
  # Else - not critical since used for temporary files.
}

#### Start logging functions. ####

# Echo to stderr.
echoStderr() {
  # If necessary, quote the string to be printed.
  echo "$@" 1>&2
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

#### End logging functions.   ####

# Parse the command parameters:
# - use the getopt command line program so long options can be handled
parseCommandLine() {
  # Single character options.
  optstring="hv"
  # Long options.
  optstringLong="aws-profile::,dryrun,help,noupload,version"
  # Parse the options using getopt command.
  GETOPT_OUT=$(getopt --options $optstring --longoptions $optstringLong -- "$@")
  exitCode=$?
  if [ $exitCode -ne 0 ]; then
    # Error parsing the parameters such as unrecognized parameter.
    echo ""
    printUsage
    exit 1
  fi
  # The following constructs the command by concatenating arguments.
  eval set -- "$GETOPT_OUT"
  # Loop over the options.
  while true; do
    #echo "Command line option is ${opt}".
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
      --noupload) # --noupload  Indicate not upload to S3, just create the local files.
        logInfo "--noupload dectected - will create local files but not change files on S3"
        doUpload="no"
        shift 1
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
        echo "" 
        echo "Invalid option $1." >&2
        printUsage
        exit 1
        ;;
    esac
  done
}

# Print the usage to stderr.
printUsage() {
  echoStderr ""
  echoStderr "Usage:  ${scriptName}"
  echoStderr ""
  echoStderr "Create the models.openwaterfoundation.org/surface-water-supply-index/index.html and related files."
  echoStderr "This script can be run independent of the SWSI installer upload."
  echoStderr "The installers that are listed in the index are those that exist on the S3 bucket."
  echoStderr ""
  echoStderr "--aws-profile=profile   Specify the Amazon profile to use for AWS credentials."
  echoStderr "--dryrun                Dry run (do not overwrite files on S3)."
  echoStderr "-h                      Print usage."
  echoStderr "--noupload              Create the index files but do not upload to S3."
  echoStderr "-v                      Print version."
  echoStderr ""
}

# Print the version to stderr.
printVersion() {
  echoStderr ""
  echoStderr ${scriptName} ${scriptVersion} ${scriptVersionDate}
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

# Upload index and related files between local and S3 locations:
# - index.html
# - catalog.txt?
uploadIndexFiles() {
  local cloudFrontDistributionId invalidationId tmpFile

  # ===========================================================================
  # Step 1. Create and upload installer files
  #  - was done by 2-copy-babbitt-workflow-zip-to-owf-s3.bash script and exist on S3
  logInfo "Assuming that the SWSI workflow installer files were previously uploaded to S3."

  # ===========================================================================
  # Step 3. Upload the catalog file so download software can use:
  # - for now upload in same format as generated by aws s3 ls command
  logInfo "Uploading catalog file."
  s3CatalogTxtFileUrl="${s3FolderUrl}/catalog.txt"
  if [ -f "${s3CatalogTxtFileUrl}" ]; then
    # set -x
    ${awsExe} s3 cp ${tmpS3CatalogPath} ${s3CatalogTxtFileUrl} ${dryrun} --profile "${awsProfile}"
    errorCode=$?
    # { set +x; } 2> /dev/null
    if [ ${errorCode} -ne 0 ]; then
      logError ""
      logError "Error uploading SWSI catalog file."
      # Not fatal.
    fi
  else
    # TODO smalers 2022-06-08 Evaluate if need to enable.
    #logWarning ""
    #logWarning "Catalog file to upload does not exist:  ${tmpS3CatalogPath}"
    # Not fatal
    :
  fi

  # ===========================================================================
  # Step 5. Upload the index.html file, which provides a way to navigate downloads
  #         - for now do a very simple html file but in the future may do vue.js
  #           similar to software.openwaterfoundation.org website
  logInfo "Uploading index.html file."
  if [ -f "${indexHtmlTmpFile}" ]; then
    # set -x
    ${awsExe} s3 cp ${indexHtmlTmpFile} ${s3IndexHtmlUrl} ${dryrun} --profile "${awsProfile}"
    errorCode=$?
    # { set +x; } 2> /dev/null
    if [ ${errorCode} -ne 0 ]; then
      logError ""
      logError "Error uploading index.html file."
      exit 1
    fi
  else
    logError ""
    logError "index.html file to upload does not exist:  ${indexHtmlFile}"
    exit 1
  fi

  # ===========================================================================
  # Step 6. Upload the favicon file.
  logInfo "Uploading favicon file."
  if [ -f "${indexHtmlTmpFile}" ]; then
    # Processed the index.html file above so try to process the favicon file.
    # set -x
    ${awsExe} s3 cp "web-resources/${indexFaviconFile}" ${s3IndexFaviconUrl} ${dryrun} --profile "${awsProfile}"
    errorCode=$?
    # { set +x; } 2> /dev/null
    if [ ${errorCode} -ne 0 ]; then
      logWarning ""
      logWarning "Error uploading favicon ${indexFaviconFile} file."
      # Not fatal.
      #exit 1
    fi
  else
    logWarning ""
    logWarning "Favicon file to upload does not exist:  web-resources/${indexFaviconFile}"
    # Not fatal.
    #exit 1
  fi

  # Also invalidate the CloudFront distribution so that new version will be displayed:
  # - see:  https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html
  # Determine the distribution ID:
  # The distribution list contains a line like the following (the actual distribution ID is not included here):
  # ITEMS   arn:aws:cloudfront::132345689123:distribution/E1234567891234    models.openwaterfoundation.org  something.cloudfront.net    True    HTTP2   E1234567891334  True    2022-01-06T19:02:50.640Z        PriceClass_100Deployed
  subdomain="models.openwaterfoundation.org"
  cloudFrontDistributionId=$(getCloudFrontDistribution)
  if [ -z "${cloudFrontDistributionId}" ]; then
    logError "Unable to find CloudFront distribution."
    return 1
  else
    logInfo "Found CloudFront distribution ID: ${cloudFrontDistributionId}"
  fi
  # The invalidation output is like the following where "Id" is the invalidation ID.
  #  {
  #    "Location": "https://cloudfront.amazonaws.com/2020-05-31/distribution/E1OLDBANEI7OML/invalidation/I2SM79N0DN566C",
  #    "Invalidation": {
  #        "Id": "I2SM79N0DN566C",
  #        "Status": "InProgress",
  #        "CreateTime": "2022-12-03T07:38:35.307000+00:00",
  #        "InvalidationBatch": {
  #            "Paths": {
  #                "Quantity": 1,
  #                "Items": [
  #                    "/surface-water-supply-index/index*"
  #                ]
  #            },
  #            "CallerReference": "cli-1670053115-235914"
  #        }
  #    }
  #  }

  # Save the output to a temporary file and then extract the invalidation ID.
  tmpFile=$(mktemp)
  logInfo "Invalidating files so that CloudFront will make new files available..."
  logInfo "  Save output to: ${tmpFile}"
  #logInfo "Running: ${awsExe} cloudfront create-invalidation --distribution-id \"${cloudFrontDistributionId}\" --paths '/surface-water-supply-index/index.html*' --output json --profile \"${awsProfile}\""
  if [ "${operatingSystem}" = "mingw" ]; then
    # The following is needed to avoid MinGW mangling the paths, just in case a path without * is used:
    # - tried to use a variable for the prefix but that did not work
    MSYS_NO_PATHCONV=1 ${awsExe} cloudfront create-invalidation --distribution-id "${cloudFrontDistributionId}" --paths '/surface-water-supply-index/index.html' '/surface-water-supply-index/' '/surface-water-supply-index' "/surface-water-supply-index/${indexFaviconFile}" --output json --profile "${awsProfile}" | tee ${tmpFile}
  else
    ${awsExe} cloudfront create-invalidation --distribution-id "${cloudFrontDistributionId}" --paths '/surface-water-supply-index/index.html' '/surface-water-supply-index/' '/surface-water-supply-index' "/surface-water-supply-index/${indexFaviconFile}" --output json --profile "${awsProfile}" | tee ${tmpFile}
  fi
  invalidationId=$(cat ${tmpFile} | grep '"Id":' | cut -d ':' -f 2 | tr -d ' ' | tr -d '"' | tr -d ',')
  errorCode=${PIPESTATUS[0]}
  if [ ${errorCode} -ne 0 ]; then
    logError " "
    logError "Error invalidating CloudFront file(s)."
    return 1
  else
    logInfo "Success invalidating CloudFront file(s)."
    # Now wait on the invalidation.
    waitOnInvalidation ${cloudFrontDistributionId} ${invalidationId}
  fi

  return 0
}

# Wait on an invalidation until it is complete:
# - first parameter is the CloudFront distribution ID
# - second parameter is the CloudFront invalidation ID
waitOnInvalidation () {
  local distributionId invalidationId output totalTime
  local inProgressCount totalTime waitSeconds

  distributionId=$1
  invalidationId=$2
  if [ -z "${distributionId}" ]; then
    logError "No distribution ID provided."
    return 1
  fi
  if [ -z "${invalidationId}" ]; then
    logError "No invalidation ID provided."
    return 1
  fi

  # Output looks like this:
  #   INVALIDATIONLIST        False           100     67
  #   ITEMS   2022-12-03T07:00:47.490000+00:00        I3UE1HOF68YV8W  InProgress
  #   ITEMS   2022-12-03T07:00:17.684000+00:00        I30WL0RTQ51PXW  Completed
  #   ITEMS   2022-12-03T00:46:38.567000+00:00        IFMPVDA8EX53R   Completed

  totalTime=0
  waitSeconds=5
  logInfo "Waiting on invalidation for distribution ${distributionId} invalidation ${invalidationId} to complete..."
  while true; do
    # The following should always return 0 or greater.
    #logInfo "Running: ${awsExe} cloudfront list-invalidations --distribution-id \"${cloudFrontDistributionId}\" --no-paginate --output text --profile \"${awsProfile}\""
    #${awsExe} cloudfront list-invalidations --distribution-id "${cloudFrontDistributionId}" --no-paginate --output text --profile "${awsProfile}"
    inProgressCount=$(${awsExe} cloudfront list-invalidations --distribution-id "${cloudFrontDistributionId}" --no-paginate --output text --profile "${awsProfile}" | grep "${invalidationId}" | grep InProgress | wc -l)
    #logInfo "inProgressCount=${inProgressCount}"

    if [ -z "${inProgressCount}" ]; then
      # This should not happen?
      logError "No output from listing invalidations for distribution ID:  ${cloudFrontDistributionId}"
      return 1
    fi

    if [ ${inProgressCount} -gt 0 ]; then
      logInfo "Invalidation status is InProgress.  Waiting ${waitSeconds} seconds (${totalTime} seconds total)..."
      sleep ${waitSeconds}
    else
      # Done with invalidation.
      break
    fi

    # Increment the total time.
    totalTime=$(( ${totalTime} + ${waitSeconds} ))
  done

  logInfo "Invalidation is complete (${totalTime} seconds total)."

  return 0
}

# Entry point for the script.

# Get the location where this script is located since it may have been run from any folder.
scriptFolder=$(cd $(dirname "$0") && pwd)
buildUtilFolder=$(cd $(dirname "$0") && pwd)
scriptName=$(basename $0)
repoFolder=$(dirname "${scriptFolder}")
scriptsFolder="${repoFolder}/scripts"
buildUtilTmpFolder="${buildUtilFolder}/build-tmp"

scriptVersion="1.0.0"
scriptVersionDate="2023-05-03"

# Control debugging.
debug=false

if [ "$debug" = "true" ]; then
  echo "scriptFolder=${scriptFolder}"
  echo "repoFolder=${repoFolder}"
  echo "srcFolder=${srcFolder}"
fi

# Default is not to do 'aws' dry run:
# - override with --dryrun
dryrun=""

# Default is to upload:
# - override with --noupload
doUpload="yes"

# Root AWS S3 location where files are to be uploaded.
s3FolderUrl="s3://models.openwaterfoundation.org/surface-water-supply-index"

# Parse the command line.
parseCommandLine "$@"

# Check the operating system.
checkOperatingSystem

# Check input:
# - check that Amazon profile was specified
checkInput

# Set the 'aws' program to use:
# - must set after the operating system is set
setAwsExe

# This ensures that a user login is set, used to create unique temporary file names.
getUserLogin

# File that contains output of `aws ls`, used to create catalog:
# - user ID is used to help create more unique temporary files
user=""
tmpS3ListingPath="/tmp/${USER}-swsi-catalog-ls.txt"

# Create a list of available installers
createCatalogFile

# Create the 'index.html' and related files.
# TODO smalers 2020-04-06 disable for now
createIndexHtmlFiles

# Upload the 'index.html' and related files
# TODO smalers 2020-04-06 disable for now
doUpload="yes"
if [ "${doUpload}" = "yes" ]; then
  uploadIndexFiles
fi

exit $?
