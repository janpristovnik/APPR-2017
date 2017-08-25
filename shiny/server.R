library(shiny)
shinyServer(function(input,output) {
  output$lin <- renderPlot({
    data <- filter(zdruzeno_tretji_graf,
                   Drzava %in% input$Drzava,
                   Leto == input$Leto
                   
                   
                   
                   
    )
    
   ggplot(data, aes(x = Drzava, y = Stevilo_koncanih/Stevilo_preb, fill = Stopnja_izobrazbe))+ 
      geom_col(position = "dodge")
  })
}

)

