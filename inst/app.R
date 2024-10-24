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
  titlePanel("Explore Valentine's Day Consumer Spending Trends"),

  # Sidebar layout with input and output definitions
  sidebarLayout(

    # Sidebar with a multi-select dropdown for spending categories
    sidebarPanel(
      selectInput(
        inputId = "selected_vars",
        label = "Select Spending Categories to Plot:",
        choices = colnames(historical_spending)[3:10],  # Columns from Candy to GiftCards
        selected = c("Candy", "Flowers"),
        multiple = TRUE
      ),
      helpText("Select one or more spending categories to visualize their trends over the years.")
    ),

    # Main panel for displaying outputs
    mainPanel(
      plotOutput("spendingPlot"),
      br(),
      wellPanel(
        h4("Field Descriptions"),
        p("This dataset contains spending information for various Valentine's Day gift categories from 2010 to 2022."),
        p(strong("Year:"), " The year of recorded spending."),
        p(strong("Candy, Flowers, Jewelry, etc.:"), " The spending amount in USD for each specific category.")
      ),
      wellPanel(
        h4("How to Interpret the Outputs"),
        p("The plot shows the spending trends over the years for the selected categories."),
        p("Each line represents one category. By selecting multiple categories, you can compare their spending trends over time."),
        p("This helps you understand which categories gained or lost popularity.")
      )
    )
  ),

  # Custom CSS for styling
  tags$head(
    tags$style(HTML("
      body {
        background-color: #f7f7f7;
      }
      .well {
        background-color: #e6e6e6;
        border: 1px solid #ccc;
      }
      .shiny-input-container {
        margin-bottom: 20px;
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
      geom_line(size = 1) +
      geom_point(size = 2) +
      labs(title = "Spending Trends for Selected Categories Over Time",
           x = "Year",
           y = "Spending in USD",
           color = "Category") +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
