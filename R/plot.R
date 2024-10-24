#' Plot Multiple Consumer Spending Trends with Custom Colors
#'
#' This function plots the selected Y-axis variables over time, each with a different color.
#'
#' @param data A data frame containing the historical spending data.
#' @param y_vars A vector of strings representing the columns to be plotted on the Y-axis.
#' @return A ggplot object
#' @export
#' @examples
#' # Load the valentineTool package
#' library(valentineTool)
#'
#' # Load example dataset provided in the package
#' data("historical_spending")
#'
#' # Plot trends for Candy, Flowers, and Jewelry over time
#' plot_trends_custom(historical_spending, c("Candy", "Flowers", "Jewelry"))
plot_trends_custom <- function(data, y_vars) {
  # Ensure all Y variables are in the dataset
  if (!all(y_vars %in% names(data))) {
    stop("One or more specified Y variables are not in the data.")
  }

  # Reshape data to a long format for ggplot
  long_data <- tidyr::pivot_longer(data, cols = dplyr::all_of(y_vars), names_to = "Category", values_to = "Value")

  # Plot with ggplot2
  ggplot2::ggplot(long_data, ggplot2::aes(x = Year, y = Value, color = Category, group = Category)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::geom_point(size = 2) +
    ggplot2::labs(title = "Trends of Selected Variables Over Time",
                  x = "Year",
                  y = "Value",
                  color = "Category") +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "right")
}
