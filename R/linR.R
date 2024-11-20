#' Linear Regression
#'
#' This function performs linear regression.
#'
#' @param formula A formula of interest
#' @param data An input data
#' @param level Confidence level for the confidence intervals (default = .95)
#'
#' @return A list containing regression results:
#'   - `coefficients`: Estimated regression coefficients.
#'   - `std_error`: Standard errors of the coefficients.
#'   - `t_values`: t-statistics of the coefficients.
#'   - `p_values`: p-values for the t-tests.
#'   - `R_squared`: R-squared value.
#'   - `adj_R_squared`: Adjusted R-squared value.
#'   - `F_statistic`: F-statistic for the overall model.
#'   - `F_p_value`: p-value for the F-statistic.
#'   - `fitted_values`: Predicted values.
#'   - `residuals`: Residuals.
#'   - `degrees_of_freedom`: Degrees of freedom for the model.
#'   - `CI_table`: Confidence intervals for the coefficients.
#'
#' @importFrom stats model.frame model.matrix na.omit pf pt qt setNames
#' @examples
#' data(airquality)
#' linR(Ozone ~ Temp + Wind, data = airquality, level = 0.95)
#'
#' @export
linR <- function(formula, data, level = 0.95) {
  if (!inherits(formula, "formula")) stop("Invalid Formula.")
  data <- model.frame(formula, data, na.action = na.omit)
  # design matrix and response variable
  X <- model.matrix(formula, data)
  y <- eval(formula[[2]], data)
  if(is.null(y)) stop("'y' must be a response variable in the data.")

  n <- nrow(X)
  p <- ncol(X)
  if(n <= p) stop("Ensure n > p.")

  # coefficients
  beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y
  y_hat <- X %*% beta_hat
  residuals <- y - y_hat

  # sum of squares
  SSR <- sum((y_hat - mean(y))^2)
  SSE <- sum(residuals^2)
  SST <- SSR + SSE

  # mean squares
  MSR <- SSR / (p - 1)
  MSE <- SSE / (n - p)

  # R-squared and adjusted R-squared
  r_sq <- SSR / SST
  adj_rsq <- 1 - (1 - r_sq) * ((n - 1) / (n - p))

  # variance of residuals and std errors
  res_var <- MSE
  coef_var <- diag(res_var * solve(t(X) %*% X))
  std_error <- sqrt(coef_var)

  # t-statistics and p-values
  t_stat <- beta_hat / std_error
  p_values <- 2 * pt(-abs(t_stat), df = n - p)

  # F-statistic
  F_stat <- MSR / MSE
  F_p_values <- pf(F_stat, df1 = p - 1, df2 = n - p, lower.tail = FALSE)

  # Confidence Intervals
  alpha <- 1 - level
  t_critical <- qt(1 - alpha / 2, df = n - p)
  CI_lower <- beta_hat - t_critical * std_error
  CI_upper <- beta_hat + t_critical * std_error

  CI_table <- data.frame(
    Estimate = as.vector(beta_hat),
    'CI Lower' = CI_lower,
    'CI Upper' = CI_upper
  )
  rownames(CI_table) <- colnames(X)

  return(list(
    coefficients = setNames(beta_hat, colnames(X)),
    std_error = setNames(std_error, colnames(X)),
    t_values = setNames(t_stat, colnames(X)),
    p_values = setNames(p_values, colnames(X)),
    R_squared = r_sq,
    adj_R_squared = adj_rsq,
    F_statistic = F_stat,
    F_p_value = F_p_values,
    fitted_values = y_hat,
    residuals = residuals,
    degrees_of_freedom = c(df1 = p - 1, df2 = n - p),
    CI_table = CI_table
  ))
}
