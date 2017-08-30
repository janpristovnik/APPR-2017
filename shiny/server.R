library(shiny)
library(ggplot2)
library(dplyr)
slovar <- c("Belgium" = "Belgija",
            "Bulgaria" = "Bolgarija",
            "Denmark" = "Danska",
            "Iceland" = "Islandija",
            "Romania" = "Romunija",
            "Slovakia" = "Slovaška")
stopnje <- c("Bachelor's or equivalent level" = "Diplomski študij",
             "Master's or equivalent level" = "Magistrski študij",
             "Doctoral or equivalent level" = "Doktorski študij")
stopnje <- factor(stopnje, levels = stopnje, ordered = TRUE)

shinyServer(function(input,output) {
  
  output$lin <- renderPlot({
    
    data <- zdruzeno_tretji_graf %>% filter(Drzava %in% input$drzava, Leto == input$leto)
                  
                  
                   
                  
    
    
   ggplot(data, aes(x = slovar[Drzava], y = Stevilo_koncanih/Stevilo_preb, fill = stopnje[Stopnja_izobrazbe]))+ 
      geom_col(position = "dodge") + xlab("Država") + guides(fill = guide_legend("Stopnja izobrazbe"))
   
  })
})



