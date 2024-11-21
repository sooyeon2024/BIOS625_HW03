## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# install.packages("BIOS625.HW03")
library(BIOS625.HW03)

## ----echo = TRUE--------------------------------------------------------------
# parameters
formula <- Ozone ~ Temp + Wind
data <- airquality
level <- 0.95

# linear regression model
model <- linR(formula, data, level)

