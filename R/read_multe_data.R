#' Read cloudberry data
#' Reads the built-in cloudberry dataset from the package.
#' @return A data frame with columns 'site' and 'seeds'
#' @examples
#' read_multe_data()
#' @export
read_multe_data <- function() {
  path <- system.file(
    "extdata",
    "multedata.xlsx",
    package = "MulteTraits"
  )
  dataset <- readxl::read_excel(path)
names(dataset) <- c("site", "seeds")
if (!is.numeric(dataset$seeds)) {
  stop("Column 'seeds' must be numeric")}

if (any(dataset$seeds < 0, na.rm = TRUE)) {
  stop("Seeds must be positive values")}
dataset
}


