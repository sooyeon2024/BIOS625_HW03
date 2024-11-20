# linR: Linear Regression 

<!-- badges: start -->
[![R-CMD-check](https://github.com/sooyeon2024/BIOS625_HW03/actions/workflows/r.yml/badge.svg)](https://github.com/sooyeon2024/BIOS625_HW03/actions/workflows/r.yml)
[![Codecov test coverage](https://codecov.io/gh/sooyeon2024/BIOS625_HW03/graph/badge.svg)](https://app.codecov.io/gh/sooyeon2024/BIOS625_HW03)
<!-- badges: end -->

## About

**'linR'** is an R package that performs linear regression analysis, providing estimates of the relationship bewteen a dependent variable and one or more independent variables. Necessary statistical outputs such as coefficients, confidence intervals, test statistic, etc. are calculated. 

## Installation

You can install the **'linR'** package from GitHub:

```r
# Install devtools package
install.packages("devtools")

# Install linR from GitHub
devtools::install_github("sooyeon2024/BIOS625_HW03")
```

## Examples

Here is a brief "how to" guide with examples. 

Firstly, you want to determine data and parameters of interest:
```r
data <- airquality
formula <- Ozone ~ Temp + Wind
level <- 0.95
```

And then, try fitting the model using linR
```r
linR_model <- linR(formula, data, level = 0.95)
print(linR_model)
```

Do the following to get your Confidence Interval promptly:
```r
linR_model$CI_table
```

## Help

Here is a help page of **linR** function:

```r
?linR
```

## Contacts

- **Email:** sooyeono@umich.edu
