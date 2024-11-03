library(autoharp)

qmd_nb <- function(infile, outfile) {
  py_chunks <- extract_chunks(infile, "python")
  writeLines(unlist(py_chunks), outfile)
}


## Extract R codes
r_codes <- c("01-intro_to_R.qmd",
             "03-summarising_data.qmd", "04-categorical_data_analysis.qmd",
             "05-robust_statistics.qmd", "07-2_sample_tests.qmd",
             "08-anova.qmd", "09-regression.qmd", "10-simulation.qmd")
infiles <- file.path("..", r_codes)
sapply(infiles, knitr::purl)

## Extract python codes
py_codes <- c("02-intro_to_python.qmd",
             "03-summarising_data.qmd", "04-categorical_data_analysis.qmd",
             "05-robust_statistics.qmd", "07-2_sample_tests.qmd",
             "08-anova.qmd", "09-regression.qmd", "10-simulation.qmd")
infiles <- file.path("..", py_codes)
root_names <- sapply(py_codes, remove_extension)
outfiles <- paste0(unname(root_names), ".py")
out <- mapply(qmd_nb, infiles, outfiles)

# qmd_nb("intro_to_python_slides2.qmd", "test.qmd")
# quarto convert test.qmd
