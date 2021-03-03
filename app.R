#This file creates an app that compares states' cumulative COVID cases over time.

#load libraries
library(shiny)
library(tidyverse)
library(brio)

#load data
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")


ui <- fluidPage(
  selectInput("state", 
              "Select state(s):", 
              choices = covid19$state,
              multiple = TRUE),
  submitButton(text = "Create my plot!"),
  plotOutput(outputId = "timeplot")
)

server <- function(input, output) {
  output$timeplot <- renderPlot({
    covid19 %>% 
      filter(state == input$state) %>% 
      ggplot() +
      geom_line(aes(x = date, y = cases, color = state)) +
      scale_y_log10() +
      labs(title = "Cumulative COVID-19 Case Counts",
           x = "",
          y= "Log Case Count")+
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)