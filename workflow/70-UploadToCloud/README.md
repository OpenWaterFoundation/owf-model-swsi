# 70-UploadToCloud

This folder contains the workflow to upload the SWSI model run to the cloud as a dataset
that can be navigated and files accessed with a web browser.
The TSTool AWS plugin is used to create a landing page and automate the upload to the cloud.

1. Run the `create-dataset-details-insert.bash` script to automate creation
   of the MarkDown insert that lists dataset files.
2. Run the `70-upload-dataset-to-s3.tstool` command file in TSTool to upload the
   dataset landing page to the AWS S3 dataset bucket.
