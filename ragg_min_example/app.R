library(shiny)
library(ggplot2)
library(ragg)
library(dplyr)

ui <- fluidPage(
  
  # Application title
  titlePanel("Sample Emoji Plot"),

  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "types",
        label = "Types",
        choices = c("🐈", "🐕"),
        selected = c("🐈", "🐕")
      )
    ),
    mainPanel(
      plotOutput("emojiPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$emojiPlot <- renderPlot({
    df <- data.frame(
      time = c(1, 2, 3, 4, 5),
      value = c(10, 15, 5, 30, 35),
      type = c("🐈", 
               "🐕",
               "🐕",
               "🐈",
               "🐈")
    )
    
    df |> 
    dplyr::filter(type %in% input$types) |> 
    ggplot(aes(x = time, y = value)) + 
      geom_label(aes(label = type)) +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
