input_folder <- "input"
output_folder <- "output"
pdfs <- list.files(input_folder, pattern = "[.]pdf$")

# must remove the spaces in files as it cause LaTeX errors
lapply(pdfs, \(x) {
  sanity <- \(x) {
    gsub(" ", "", x, fixed = TRUE)
  }
  file.rename(file.path(input_folder, x), file.path(input_folder, sanity(x)))
}) |> invisible()

# file.rename(
#   file.path(input_folder, pdfs),
#   file.path(
#     input_folder,
#     gsub("((?<=附件)\\d{1}：)|((?<=第)\\d{1}(?=号))", "0\\1\\2", pdfs, perl = TRUE)
#   )
# )

pdfs <- list.files(input_folder, pattern = "[.]pdf$")
titles <- gsub(".pdf", "", pdfs, fixed = TRUE) |> trimws()

for (i in seq_along(pdfs)) {
  title <- titles[i]
  sprintf("[%s]: %s", Sys.time(), title) |> message()
  file <- file.path(input_folder, pdfs[i])
  output <- file.path(output_folder, paste0(title, ".pdf"))
  knit_rnw("add-head-to-pdf.Rnw", output)
}
