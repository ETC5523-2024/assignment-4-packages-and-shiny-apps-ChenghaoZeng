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
  library(ggplot2)
  library(tidyr)

  # Ensure all Y variables are in the dataset
  if (!all(y_vars %in% names(data))) {
    stop("One or more specified Y variables are not in the data.")
  }

  # Reshape data to a long format for ggplot
  long_data <- data %>%
    pivot_longer(cols = all_of(y_vars), names_to = "Category", values_to = "Value")

  # Plot with ggplot
  ggplot(long_data, aes(x = Year, y = Value, color = Category, group = Category)) +
    geom_line(size = 1) +
    geom_point(size = 2) +
    labs(title = "Trends of Selected Variables Over Time",
         x = "Year",
         y = "Value",
         color = "Category") +
    theme_minimal() +
    theme(legend.position = "right") # Position legend next to the plot
}

