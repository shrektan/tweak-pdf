knit_rnw <- function (input, output, quiet = TRUE, compiler = "xelatex", eval_in_temp = FALSE) {
  xfun::pkg_load("knitr")
  xfun::pkg_load("tinytex")
  stopifnot(length(input) == 1, tolower(tools::file_ext(input)) == "rnw")
  stopifnot(length(output) == 1, tolower(tools::file_ext(output)) == "pdf")
  output <- normalizePath(output, mustWork = FALSE, winslash = "/")
  if (file.exists(output)) {
    unlink(output)
  }
  if (file.exists(output)) {
    stop("output ", output, " is locked.", call. = FALSE)
  }
  output_dir <- dirname(output)
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
  }
  if (!dir.exists(output_dir)) {
    stop("output directory ", output_dir, " can't be created.", call. = FALSE)
  }
  input <- normalizePath(input, mustWork = FALSE, winslash = "/")
  if (eval_in_temp) {
    tmp_rnw <- tempfile(fileext = ".Rnw")
    file.copy(input, tmp_rnw, overwrite = TRUE)
    input <- tmp_rnw
  }
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  new_wd <- dirname(input)
  setwd(new_wd)
  pure_file_name <- tools::file_path_sans_ext(input)
  file_tex <- paste0(pure_file_name, ".tex")
  current_opts <- knitr::opts_chunk$get()
  knitr::opts_chunk$set(error = FALSE)
  on.exit(knitr::opts_chunk$restore(current_opts), add = TRUE)
  knitr::knit2pdf(input, quiet = quiet, compiler = compiler, envir = new.env(parent = parent.frame(1L)))
  unlink(x = file_tex, force = TRUE)
  setwd(old_wd)
  file.rename(from = paste0(pure_file_name, ".pdf"), to = output)
  if (eval_in_temp) {
    unlink(input)
    unlink(file.path(dirname(input), "figure"), recursive = TRUE)
  }
  invisible(output)
}
