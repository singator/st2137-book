library(autoharp)

qmd_nb <- function(infile, outfile) {
  py_chunks <- extract_chunks(infile, "python")
  writeLines(unlist(py_chunks), outfile)
}
# qmd_nb("intro_to_python_slides2.qmd", "test.qmd")
# quarto convert test.qmd
