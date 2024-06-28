library(shiny)
library(ggplot2)

load(url("https://raw.githubusercontent.com/Nowosad/imiona/main/babynamespl.RData"))

# library(dplyr)
# load("namer/babynamespl.rda")

# babynamespl = structure(list(Rok = c(2000, 2000, 2000, 2000, 2000, 2000, 2000,
# 2000, 2000, 2000), Imię = c("JAKUB", "MATEUSZ", "KACPER", "MICHAŁ",
# "PATRYK", "DAWID", "KAMIL", "PIOTR", "SZYMON", "PAWEŁ"), Liczba = c(14497,
# 11454, 8898, 8498, 7743, 7063, 6842, 5608, 5486, 5109), Płeć = c("M",
# "M", "M", "M", "M", "M", "M", "M", "M", "M")), row.names = c(NA,
# -10L), spec = structure(list(cols = list(Rok = structure(list(), class = c("collector_double",
# "collector")), Imię = structure(list(), class = c("collector_character",
# "collector")), Liczba = structure(list(), class = c("collector_double",
# "collector")), Płeć = structure(list(), class = c("collector_character",
# "collector"))), default = structure(list(), class = c("collector_guess",
# "collector")), delim = ","), class = "col_spec"), class = c("spec_tbl_df",
# "tbl_df", "tbl", "data.frame"))

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



           # https://github.com/Nowosad/imiona/raw/main/babynamespl.rda"))
  # # babynamespl = read.csv("https://github.com/Nowosad/imiona/raw/main/babynames.csv")
  #
  # babynamespl = babynamespl[1:100,]

    output$distPlot <- renderPlot({
        ggplot(subset(babynamespl, Imię %in% input$imie),
               aes(Rok, Liczba, color = Imię, group = Imię)) +
            geom_line() +
            geom_point()
    })
}

# Run the application
shinyApp(ui = ui, server = server)
