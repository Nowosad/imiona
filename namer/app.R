library(shiny)
library(ggplot2)

load(url("https://raw.githubusercontent.com/Nowosad/imiona/main/babynamespl.RData"))

ui = fluidPage(
  titlePanel("Imiona"),

  sidebarLayout(
    sidebarPanel(
    selectizeInput(
      inputId = "imie",
      label = "Imię",
      choices = babynamespl$Imię,
      selected = c("EWA", "DAWID"),
      multiple = TRUE,
      options = NULL
    )
  ),
  mainPanel(plotOutput("distPlot"))
  )
)

server = function(input, output) {
  output$distPlot = renderPlot({
    ggplot(subset(babynamespl, Imię %in% input$imie),
           aes(Rok, Liczba, color = Imię, group = Imię)) +
      geom_line() +
      geom_point()
  })
}

shinyApp(ui = ui, server = server)
