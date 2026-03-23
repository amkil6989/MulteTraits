
# MulteTraits

MulteTraits is made to explore and compare number of seeds in cloudberries 
in peatlands and heathlands, which is the topic of my master.
It allows users to load exceldata, filter by habitat and site, 
and visualize results with the use of a Shiny app.

## Installation

You can install the development version of MulteTraits from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("amkil6989/MulteTraits")
```

## Example

Load the package:

``` r
library(MulteTraits)
```

Run the Shiny app:

``` r
run_app()
```

This launches an interactive app where you can:
Upload your own Excel file
Filter data by habitat and site
Visualize results using boxplots or barplots

The app automatically loads the built-in example dataset if no file is uploaded. 
You need to upload your own Excel file if you want to use your own data.

Data format

Your own data, should contain:
site: site identifier ("P1", "H1", "P2"...)
seeds: numeric seed count 
