library(shiny) 
library(scales)
library(rsconnect)
library(googlesheets4)

shinyServer(
        function(input, output) {
                utah <- readRDS("./data/utah.rds")
                utah <- data.frame(utah)
                roi <- reactive({utah[utah$program == input$program & utah$name == input$name,]})
                output$name <- renderText({input$name})
                output$program <- renderText({input$program})
                output$earnings <- renderText({roi()$earnings})
                output$debt <- renderText({roi()$debt})
                return_on_investment <- reactive({ roi()$earnings / roi()$debt })
                output$return <- renderText({return_on_investment()})
} )