#' Filter Spending Data by Year Range (This is the function for for extra mark :))
#'
#' @param data Data frame containing spending data.
#' @param start_year The starting year for filtering.
#' @param end_year The ending year for filtering.
#' @return A filtered data frame containing data between start_year and end_year.
#' @export
filter_by_year <- function(data, start_year, end_year) {
  data %>%
    dplyr::filter(Year >= start_year & Year <= end_year)
}
