library(shiny)
library(ggplot2)
library(dplyr)
load("babynamespl.rda")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel(""),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectizeInput(inputId = "imie",
                           label = "Imię",
                           choices = babynamespl$Imię,
                           selected = "JAKUB",
                           multiple = TRUE,
                           options = NULL)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        ggplot(filter(babynamespl, Imię %in% input$imie),
               aes(Rok, Liczba, color = Imię)) +
            geom_line() +
            geom_point()
    })
}

# Run the application
shinyApp(ui = ui, server = server)
