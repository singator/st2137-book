# st2137-book
Course textbook for ST2137 Statistical Computing and Programming

The rendered html book can be accessed here: <https://singator.github.io/st2137-book/>
The pdf version of the book can be obtained from here: <https://blog.nus.edu.sg/stavg/textbooks/>

## Rendering your own version

Here is a brief outline of the steps, for those who wish to create/render a version of your own.

1. Fork the repository and clone it to your local host.
2. Since the textbook includes Python code, you will need to set up a virtual environment for this book. The [reticulate](https://github.com/rstudio/reticulate) R package is used to activate the virtual environment. By default, quarto projects look for an environment in the same directory. However, I keep all my virtual environments in a centralised directory. I keep track of this with a venv_paths.csv. It contains a map from host (I use multiple computers) to directory with the virtual environment. At the beginning of each qmd file, I identify the appropriate path and activate the environment.
3. The book is rendered using [Quarto](https://quarto.org/docs/books/).
4. Once you are happy with your updated version, use a command like `quarto publish gh-pages`. That should do the rest!


- tested on python 3.14 on windows?
