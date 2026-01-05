# st2137-book
Course textbook for ST2137 Statistical Computing and Programming

The rendered html book can be accessed here: <https://singator.github.io/st2137-book/>
The pdf version of the book can be obtained from the release section on this repository.

## Rendering your own version

Here is a brief outline of the steps, for those who wish to create/render a version of your own.

1. Fork the repository and clone it to your local host.
2. Use the requirements.txt file to create a virtual environment in a folder named env/. Configure your Rstudio project
   to use the Python environment in the project directory.
   - The code in the book has been tested with 3.14.
4. Use the renv.lock to install the correct versions of R packages.
5. Install quarto and use it to install tinytex.
6. You should be all set now!

## License

- Text, figures, and other content: © 2025 Vik Gopal, Daisy Pham Thi Kim Cuc. Licensed under
  [CC BY-SA 4.0](https://creativecommons.org/licenses/by/4.0/). 
- Code snippets: Licensed under the [MIT License](./LICENSE-CODE).
- [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17969651.svg)](https://doi.org/10.5281/zenodo.17969651)[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](LICENSE)[![Code: MIT](https://img.shields.io/badge/Code-MIT-blue.svg)](LICENSE-CODE)

Please cite as:

Gopal, V. and Pham, T.K.C. (2025) *Statistical Computing and Programming.* Zenodo. doi:10.5281/zenodo.17969651.
