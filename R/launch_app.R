#' Launch the Valentine's Day Consumer Trends Shiny App
#'
#' This function launches the Shiny app included in the valentineTool package.
#'
#' @export
launch_valentine_app <- function() {
  # Locate the Shiny app directory within the installed package
  appDir <- system.file(package = "valentineTool")

  # Check if the app directory is correctly found
  if (appDir == "") {
    stop("Could not find Shiny app directory. Try re-installing `valentineTool`.", call. = FALSE)
  }

  # Launch the Shiny app
  shiny::runApp(file.path(appDir, "app.R"), display.mode = "normal")
}
