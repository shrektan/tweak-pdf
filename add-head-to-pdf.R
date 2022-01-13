input_folder <- "input"
output_folder <- "output"
pdfs <- list.files(input_folder)

# must remove the spaces in files as it cause LaTeX errors
lapply(pdfs, \(x) {
  sanity <- \(x) {
    gsub(" ", "", x, fixed = TRUE)
  }
  file.rename(file.path(input_folder, x), file.path(input_folder, sanity(x)))
}) |> invisible()

pdfs <- list.files(input_folder)
titles <- gsub(".pdf", "", pdfs, fixed = TRUE) |> trimws()

for (i in seq_along(pdfs)) {
  title <- titles[i]
  message(title)
  file <- file.path(input_folder, pdfs[i])
  output <- file.path(output_folder, paste0(title, ".pdf"))
  knit_rnw("add-head-to-pdf.Rnw", output)
}
