# setwd("combine-pdf")

folder <- "solvency-files"
pdfs <- list.files(folder)
lapply(pdfs, \(x) {
  sanity <- \(x) {
    gsub(" ", "", x, fixed = TRUE)
  }
  file.rename(file.path(folder, x), file.path(folder, sanity(x)))
}) |> invisible()
pdfs <- list.files(folder)
titles <- gsub(".pdf", "", pdfs, fixed = TRUE) |> trimws()

for (i in seq_along(pdfs)) {
  title <- titles[i]
  message(title)
  file <- file.path(folder, pdfs[i])
  output <- file.path("output", paste0(title, ".pdf"))
  GCAMCPUB::f_rnw2pdf("solvency-files.Rnw", output = output)
}
title <- titles[i]
file <- file.path(folder, pdfs[i])
GCAMCPUB::f_rnw2pdf("solvency-files.Rnw", output = "test.pdf", if_show = T)
