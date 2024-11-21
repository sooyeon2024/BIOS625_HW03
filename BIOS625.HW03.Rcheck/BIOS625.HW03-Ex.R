pkgname <- "BIOS625.HW03"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('BIOS625.HW03')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("linR")
### * linR

flush(stderr()); flush(stdout())

### Name: linR
### Title: Linear Regression
### Aliases: linR

### ** Examples

data(airquality)
linR(Ozone ~ Temp + Wind, data = airquality, level = 0.95)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
