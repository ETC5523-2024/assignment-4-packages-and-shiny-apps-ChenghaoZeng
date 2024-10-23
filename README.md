
# valentineTool

<!-- badges: start -->
<!-- badges: end -->

The goal of `valentineTool` is to provide an analysis tool for
Valentine’s Day consumer trends. This package helps users visualize
consumer spending over the years for different categories such as candy,
flowers, jewelry, and more. The functions in this package are
particularly useful for analysts, researchers, and businesses looking to
understand changing consumer behavior during Valentine’s Day.

## Installation

You can install the development version of valentineTool from
[GitHub](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-ChenghaoZeng)
with:

``` r
# Install remotes if not already installed
install.packages("remotes")

# Install the package from GitHub
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-ChenghaoZeng")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(valentineTool)
library(ggplot2)

# Create the line plot for PercentCelebrating
ggplot(historical_spending, aes(x = Year, y = PercentCelebrating)) +
  geom_line(color = "blue") +                  
  labs(title = "Percent Celebrating Valentine's Day Over Time",
       x = "Year",
       y = "Percent Celebrating") +
  theme_minimal() 
```

<img src="man/figures/README-example-1.png" width="100%" />
