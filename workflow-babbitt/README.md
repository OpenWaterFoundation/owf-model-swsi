# workflow-babbitt #

This folder contains SWSI workflow steps for the Babbitt Center indicators project,
which uses the core Colorado SWSI to create water supply indicators for the Upper Colorado Basin.

The additional workflow steps should be run in the proper sequence based on the workflow step numbers.
These steps are also described in
[Appendix G - Use Case for Babbitt Center Indicators](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/appendix-g/use-case-babbitt-indicators/).

These folders can be combined with the Colorado SWSI workflow steps and can then be copied forward as each month is run.

| **Folder** | **Description** |
| -- | -- |
| `01-DownloadColoradoProducts/` | Download State of Colorado monthly SWSI data products to provide configuration for Babbitt Center workflow. **Run this step after setting up a monthly SWSI folder and before running any other SWSI workflow steps.**|
| `70-InfoProducts/` | Create products for the Babbitt Center dataset, including GeoJSON file and heatmap images. |
| `80-UploadToCloud-Babbitt/` | Publish SWSI output to the Babbitt Center AWS cloud storage and create the dataset landing page. **Run this step after running the monthly SWSI analysis.** |
| `80-UploadToCloud-OWF/` | Publish SWSI output to the Open Water Foundation AWS cloud storage and create the dataset landing page, used for testing the workflow. **Run this step after running the monthly SWSI analysis.** |
| `resources/` | Resources used for the Babbitt Center data website, used with the SWSI indicator, uploaded to the `data.babbittcenter.org` root folders. The Babbitt Center can modify as necessary. |

