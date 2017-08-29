library(shiny)

shinyUI( fluidPage(
  
    titlePanel("Število končanih visokošolskih izobrazb za izbrane države v izbranih letih")
  ,
  
  
  selectInput( inputId = "drzava",
               label = "Država",
               choices = unique(zdruzeno_tretji_graf$Drzava),
               
               multiple = TRUE
  ),
  selectInput(inputId = "leto",
              label = "Leto",
              choices = unique(zdruzeno_tretji_graf$Leto),
              
              multiple = FALSE
  ),
  
  
  
  plotOutput("lin")
))