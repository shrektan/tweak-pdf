input_folder <- "input"
output_folder <- "output"
pdfs <- list.files(input_folder, pattern = "[.]pdf$", full.names = TRUE)
# file.rename(
#   file.path(pdfs),
#   file.path(
#     gsub("((?<=附件)\\d{1}：)|((?<=第)\\d{1}(?=号))", "0\\1\\2", pdfs, perl = TRUE)
#   )
# )
output <- file.path(output_folder, paste0("output", ".pdf"))

temp_pdfs <- sprintf("%03d.pdf", seq_along(pdfs))
temp_pdfs <- file.path(tempdir(), temp_pdfs)
file.copy(pdfs, temp_pdfs)

cmd <- r"(
gs -sDEVICE=pdfwrite \
-dNOPAUSE -dBATCH -dSAFER \
-sOutputFile=%s \
%s
)"
cmd2 <- sprintf(cmd, output, paste(temp_pdfs, collapse = " "))
system(cmd2)
