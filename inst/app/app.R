ui <- shiny::fluidPage(
  shiny::titlePanel("Seed Number Cloudberries"),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::fileInput("file", "Upload Excel file", accept = ".xlsx"),
      shiny::selectInput("habitat", "Choose habitat",
                         choices = c("All", "Peatland", "Heathland")),
      shiny::uiOutput("site_ui"),
      shiny::selectInput("plot_type", "Choose plot",
                         choices = c("Boxplot", "Barplot"))
    ),
    shiny::mainPanel(
      shiny::plotOutput("plot"),
      shiny::verbatimTextOutput("summary")
    )
  )
)
server <- function(input, output, session) {
  dataset <- shiny::reactive({
    if (is.null(input$file)) {
      data <-read_multe_data()
    } else {
      data <- readxl::read_excel(input$file$datapath)
      names(data) <- c("site", "seeds")
    }
    data$habitat <- ifelse(grepl("^P", data$site), "Peatland", "Heathland")
    data$site_id <- gsub("[A-Z]", "", data$site)
    data
  })
  output$site_ui <- shiny::renderUI({
    shiny::selectInput(
      "site",
      "Choose site",
      choices = c("All", unique(dataset()$site_id))
    )
  })
  filtered_data <- shiny::reactive({
    data <- dataset()
    if (input$habitat != "All") {
      data <- subset(data, habitat == input$habitat)
    }
    if (!is.null(input$site) && input$site != "All") {
      data <- subset(data, site_id == input$site)
    }
    data
  })

  output$plot <- shiny::renderPlot({
    data <- filtered_data()
    if (input$plot_type == "Boxplot") {
      ggplot2::ggplot(data, ggplot2::aes(x = habitat, y = seeds)) +
        ggplot2::geom_boxplot() +
        ggplot2::facet_wrap(~site_id) +
        ggplot2::theme_minimal()
    } else {
      summary_data <- stats::aggregate(seeds ~ habitat + site_id,
                                       data = data,
                                       FUN = mean)
      ggplot2::ggplot(summary_data,
                      ggplot2::aes(x = site_id, y = seeds, fill = habitat)) +
        ggplot2::geom_col(position = "dodge") +
        ggplot2::theme_minimal()
    }
  })
  output$summary <- shiny::renderPrint({
    data <- filtered_data()
    cat("Mean seed number:", mean(data$seeds, na.rm = TRUE), "\n")
    cat("Observations:", nrow(data))
  })
}
shiny::shinyApp(ui, server)

