#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# app.R


library(shiny)
library(valentineTool)
library(ggplot2)

# Load the dataset from the package
data("historical_spending")

# Define UI
ui <- fluidPage(

  # Application title
  titlePanel(tags$h1("Explore Valentine's Day Consumer Spending Trends", style = "color: #00000 !important; text-align: center; font-weight: bold;")),

  # Sidebar layout with input and output definitions
  sidebarLayout(

    # Sidebar with a multi-select dropdown for spending categories
    sidebarPanel(
      selectInput(
        inputId = "selected_vars",
        label = tags$span("Select Spending Categories to Plot:", style = "font-weight: bold; color: #1d3557;"),
        choices = colnames(historical_spending)[3:10],  # Columns from Candy to GiftCards
        selected = c("Candy", "Flowers"),
        multiple = TRUE
      ),
      helpText("Select one or more spending categories to visualize their trends over the years.", style = "font-style: italic; color: #457b9d;"),
      style = "background-color: #f1faee; padding: 20px; border-radius: 10px; box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);"
    ),

    # Main panel for displaying outputs
    mainPanel(
      plotOutput("spendingPlot"),
      br(),
      wellPanel(
        h4("Field Descriptions", style = "color: #1d3557;"),
        p("This dataset contains spending information for various Valentine's Day gift categories from 2010 to 2022.", style = "color: #1d3557;"),
        p(strong("Year:"), " The year of recorded spending.", style = "color: #1d3557;"),
        p(strong("Candy, Flowers, Jewelry, etc.:"), " The spending amount in USD for each specific category.", style = "color: #1d3557;"),
        style = "background-color: #f1faee !important; padding: 15px !important; border-radius: 10px !important; box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1) !important;"
      ),
      wellPanel(
        h4("How to Interpret the Outputs", style = "color: #1d3557;"),
        p("The plot shows the spending trends over the years for the selected categories.", style = "color: #1d3557;"),
        p("Each line represents one category. By selecting multiple categories, you can compare their spending trends over time.", style = "color: #1d3557;"),
        p("This helps you understand which categories gained or lost popularity.", style = "color: #1d3557;"),
        style = "background-color: #f1faee !important; padding: 15px !important; border-radius: 10px !important; box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1) !important;"
      )
    )
  ),

  # Custom CSS for styling
  tags$head(
    tags$style(HTML("
      body {
        background-color: #f0f8ff !important;
        font-family: 'Arial', sans-serif !important;
      }
      .well {
        background-color: #f1faee !important;
        border: 1px solid #a8dadc !important;
        box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1) !important;
        border-radius: 10px !important;
      }
      .shiny-input-container {
        margin-bottom: 20px !important;
      }
      .btn {
        background-color: #e63946 !important;
        color: white !important;
        border-radius: 8px !important;
        border: none !important;
        padding: 10px 15px !important;
      }
      .btn:hover {
        background-color: #d62828 !important;
        box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2) !important;
      }
      .shiny-bound-output {
        margin-top: 20px !important;
      }
    "))
  )
)

# Define server logic
server <- function(input, output) {

  output$spendingPlot <- renderPlot({
    # Check if any variables are selected
    req(input$selected_vars)

    # Reshape the data to a long format for plotting
    long_data <- historical_spending %>%
      tidyr::pivot_longer(cols = all_of(input$selected_vars), names_to = "Category", values_to = "Value")

    # Plot using ggplot2
    ggplot(long_data, aes(x = Year, y = Value, color = Category, group = Category)) +
      geom_line(size = 1.5) +
      geom_point(size = 3) +
      labs(title = "Spending Trends for Selected Categories Over Time",
           x = "Year",
           y = "Spending in USD",
           color = "Category") +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 20, face = "bold", color = "#1d3557"),
        axis.title = element_text(size = 14, face = "bold", color = "#1d3557"),
        axis.text = element_text(size = 12, color = "#457b9d"),
        legend.position = "bottom",
        legend.title = element_text(size = 14, face = "bold"),
        legend.text = element_text(size = 12)
      )
  })
}

# Run the application
shinyApp(ui = ui, server = server)

