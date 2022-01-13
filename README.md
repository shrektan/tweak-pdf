# R scripts to tweak pdf

This repo contains some R scripts that I use to tweak PDF files.

## Environment

* R
* R package: knitr and tinytex
* LaTeX compiler (MikTeX, TeX Live or TinyTeX. `tinytex::install_tinytex()` can install it for you, if needed)

## How

* Copy your PDF files into `input` folder
* Run the R script
* Find the output PDF files in `output` folder

## Script

* add-head-to-pdf.R: Add a customized header (the file name) to the PDF files
