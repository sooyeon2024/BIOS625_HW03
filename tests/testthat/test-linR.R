library(testthat)
data <- na.omit(airquality)
formula <- Ozone ~ Temp + Wind

# Models for comparison
linR_model <- linR(formula, data, level = 0.95)
lm_model <- lm(formula, data)
lm_model_summary <- summary(lm(formula, data))

test_that("linR works", {
  # Coefficients
  expect_equal(
    as.numeric(linR_model$coefficients),
    as.numeric(coef(lm_model))
  )
  # Fitted values
  expect_equal(
    as.numeric(linR_model$fitted_values),
    as.numeric(fitted.values(lm_model))
  )
  # Residuals
  expect_equal(
    as.numeric(linR_model$residuals),
    as.numeric(residuals(lm_model))
  )
  # R-squared
  expect_equal(
    linR_model$R_squared,
    lm_model_summary$r.squared
  )
  # Adjusted R-squared
  expect_equal(
    linR_model$adj_R_squared,
    lm_model_summary$adj.r.squared
  )
  # t-statistics
  expect_equal(
    as.numeric(linR_model$t_values),
    as.numeric(lm_model_summary$coefficients[, "t value"])
  )
  # p-values for t-tests
  expect_equal(
    as.numeric(linR_model$p_values),
    as.numeric(lm_model_summary$coefficients[, "Pr(>|t|)"])
  )
  # F-statistic
  expect_equal(
    linR_model$F_statistic,
    as.numeric(lm_model_summary$fstatistic[1])
  )
})

test_that("linR_CI works", {
  linR_CI_result <- linR_model$CI_table
  lm_CI_result <- confint(lm_model)

  # CI lower bound
  expect_equal(
    as.numeric(linR_CI_result$'CI.Lower'),
    as.numeric(lm_CI_result[, 1])
  )
  # CI upper bound
  expect_equal(
    as.numeric(linR_CI_result$'CI.Upper'),
    as.numeric(lm_CI_result[, 2])
  )
})

test_that("Insufficient observations", {
  data <- airquality[1:2, ]
  expect_error(linR(Ozone ~ Temp + Wind, data), "Ensure n > p.")
})
