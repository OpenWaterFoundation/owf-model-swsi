# build-util #

This folder contains scripts that are used in the build process.

| **Script** | **Description** |
| -- | -- |
| `1-create-babbitt-workflow-zip.bash` | Create a zip file containing the SWSI workflow for the Babbit Center indicators, which combines files from `workflow/` and `workflow-babbitt/` folders. |
| `2-copy-babbitt-workflow-zip-to-owf-s3.bash` | Copy the Babbitt Center SWSI installer to OWF's Amazon S3 bucket. |
| `3-create-s3-index.bash` | Create the SWSI product index file on S3, based on the installers that exist on S3. |
| `copy-workflow-to-test.bash` | Copy the current `workflow` folder files to the `test/` folder, to allow testing the workflow in repository files without running in the `workflow/` folder. |
