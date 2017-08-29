library(shiny)
library(ggplot2)
library(dplyr)
shinyServer(function(input,output) {
  
  output$lin <- renderPlot({
    
    data <- zdruzeno_tretji_graf %>% filter(Drzava %in% input$drzava, Leto == input$leto)
                  
                  
                   
                  
    
    
   ggplot(data, aes(x = Drzava, y = Stevilo_koncanih/Stevilo_preb, fill = Stopnja_izobrazbe))+ 
      geom_col(position = "dodge")
   
  })
})



