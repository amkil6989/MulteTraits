#' Run the MulteTraits Shiny app
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "MulteTraits")
  shiny::runApp(app_dir)
}
