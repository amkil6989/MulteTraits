read_multe_data <- function() {

  path <- system.file(
    "data",
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


