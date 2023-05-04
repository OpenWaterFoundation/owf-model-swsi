# owf-model-swsi User Documentation #

This folder contains the user documentation for the Open Water Foundation Surface Water Supply Index tool, including release notes.

See also:

*   [Published Latest Documentation](https://models.openwaterfoundation.org/surface-water-supply-index/latest/doc-user/)
*   [State of CO Drought & Surface Water Supply Index](https://dwr.colorado.gov/services/water-administration/drought-and-swsi)
*   [SWSI model downloads](https://models.openwaterfoundation.org/surface-water-supply-index/)

See the following sections on this page:

*   [Repository Contents](#repository-contents)
*   [Development Environment](#development-environment)
*   [Editing and Viewing Content](#editing-and-viewing-content)
*   [Deploying the Documentation](#deploying-the-documentation)
*   [Style Guide](#style-guide)
    +   [Web Accessibility](#web-accessibility)
*   [License](#license)
*   [Contributing](#contributing)
*   [Maintainers](#maintainers)

---------------------------

## Repository Contents ##

This folder contains the following:

```text
README.md                This file.
build-util/              Useful scripts to view, build, and deploy documentation.
mkdocs-project/          MkDocs project for this documentation.
  mkdocs.yml             MkDocs configuration file for website.
  docs/                  Folder containing source Markdown and other files for documentation website.
    css/                 Custom CSS to augment MkDocs theme.
    markdown files       Files and folders containing Markdown documentation.
  resources/             Documentation resources such as the original Word documentation.
  site/                  Folder created by MkDocs containing the static website - ignored using .gitignore.
```

## Development Environment ##

The development environment for contributing to this documentation requires
installation of Python, MkDocs, and Material MkDocs theme.
Python 3 and Markdown 1+ has been used for development.
See the [OWF / Learn MkDocs](http://learn.openwaterfoundation.org/owf-learn-mkdocs/)
documentation for information about installing MkDocs.

## Editing and Viewing Content ##

If the development environment is properly configured, edit and view content as follows:

1.  Edit content in the `docs` folder and update `mkdocs.yml` as appropriate.
    +   Markdown is used as much as possible.
    +   Screen shot images are typically created using Gimp or similar software,
        using small `png` files if possible to ensure good performance.
2.  Run the `build-util/run-mkdocs-serve-8000.bash` script (Git Bash/Cygwin/Linux) to process and serve the documentation.
    Any issues should be resolved by updating the run script to support as many environments as possible.
3.  View content in a web browser using URL `http://localhost:8000`.

## Deploying the Documentation ##

The documentation is deployed to the public OWF software website by running the following script.
The `version.txt` file in the repository is used to create the version folder for S3.

```
build-util/copy-to-owf-s3.bash
```

## Style Guide ##

The following are general style guide recommendations for this documentation,
with the goal of keeping formatting simple in favor of focusing on useful content:

*   Use the Material MkDocs theme - it looks nice, provides good navigation features, and enables search.
*   Follow MkDocs Markdown standards - use extensions beyond basic Markdown when useful.
*   Show files and program names as `code (tick-surrounded)` formatting.
*   Where a source file can be linked to in GitHub, provide a link so that the most current file can be viewed.
*   Use triple-tick formatting for code blocks, with language specifier.
*   Use ***bold italics*** when referencing UI components such as menus.
*   Use slashes surrounded by spaces to indicate ***Menu / SubMenu*** (slashes in
    menus can be indicated with no surrounding spaces).
*   Images are handled as follows:
    +   Where narrative content pages are sufficiently separated into folders,
        image files exist in those folder with names that match the original TSTool Word documentation.
        This approach has been used for the most part, for example command reference.
    +   If necessary, place images in an `images` folder.
    +   When using images in the documents, consider providing a link to view the full-sized image.
*   Minimize the use of inlined HTML elements, but use it where Markdown formatting is limited.
*   Although the Material theme provides site and page navigation sidebars,
    provide in-line table of contents on pages, where appropriate, to facilitate review of page content.
    Use a simple list at the top of the page with links to sections on the page.

### Web Accessibility ###

Ensuring web accessibility for people with disabilities such as visual impairments is important.
See the following resources:

*   [Federal government:  Guidance on Web Accessibility and the ADA](https://www.ada.gov/resources/web-guidance/)
*   [State of Colorado:  Accessibility for Developers](https://oit.colorado.gov/standards-policies-guides/guide-to-accessible-web-services/accessibility-for-developers)

Specific guidance for this documentation includes:

*   Links:
    +   The MkDocs material custom CSS uses underlines for links to provide a visual cue because
        default reliance on color only is insufficient.
*   Image "alt text":
    +   "alt text" should be specified for all images using human-readable text to facilitate reading by audio tools.
    +   Because this is technical documentation,
        there is no way to fully avoid technical terms such as command names,
        but try to make the text generally understandable.
    +   Many images also have captions and the language for "alt text" may be similar to the caption.
    +   It is OK to include punctuation in "alt text".

## License ##

This documentation is copyrighted by the Colorado Department of Natural Resources.

This documentation is licensed using the
[Creative Commons Attribution International 4.0 (CC BY 4.0) license](https://creativecommons.org/licenses/by/4.0/).

The TSTool software is licensed using the GPL 3 license.
See the [TSTool software repository](https://github.com/OpenCDSS/cdss-app-tstool-main).

## Contributing ##

Contribute to the documentation as follows:

1.  Use GitHub repository issues to report minor issues.
    Fill out the template issue.
2.  Use GitHub pull requests.
3.  A member of the core development team will follow up to issues and pull requests.

## Maintainers ##

This repository is maintained by the OpenCDSS team.

## Release Notes ##

Refer to the [GitHub issues](https://github.com/OpenWaterFoundation/owf-model-swsi)
for change history and see also the
[SWSI release notes](https://models.openwaterfoundation.org/surface-water-supply-index/latest-doc-user/appendix-release-notes/release-nodes/).
