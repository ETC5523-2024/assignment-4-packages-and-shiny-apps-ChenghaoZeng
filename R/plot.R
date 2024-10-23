#' Plot Consumer Spending Trend with Flexible Y-axis
#'
#' This function plots the selected Y-axis variable over time.
#'
#' @param data A data frame containing the historical spending data.
#' @param y_var A string representing the column to be plotted on the Y-axis.
#' @return A ggplot object
#' @export
plot_flexible_trend <- function(data, y_var) {
  library(ggplot2)

  # Ensure the Y variable is in the dataset
  if (!(y_var %in% names(data))) {
    stop("The specified Y variable is not in the data.")
  }

  ggplot(data, aes_string(x = "Year", y = y_var)) +
    geom_line(color = "blue", size = 1) +
    geom_point(size = 3, color = "red") +
    geom_smooth(method = "lm", color = "black", linetype = "dashed") +
    labs(title = paste("Trend of", y_var, "Over Time"),
         x = "Year",
         y = y_var) +
    theme_minimal()
}
