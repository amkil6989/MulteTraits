#' Runs the interactive MulteTraits Shiny app
#' @return App where you can explore and compare number of seeds in cloudberries
#' @examples
#' \dontrun{
#' run_app()
#' }
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "MulteTraits")
  shiny::runApp(app_dir)
}
