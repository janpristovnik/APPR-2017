library(shiny)
drzave <- unique(zdruzeno_tretji_graf$Drzava)
shinyUI( fluidPage(
  
    titlePanel("Število končanih visokošolskih izobrazb za izbrane države v izbranih letih")
  ,
  
  
  selectInput( inputId = "drzava",
               label = "Država",
               choices = setNames(drzave, slovar[drzave]),
               selected = c("Bulgaria", "Romania", "Slovakia", "Denmark", "Belgium", "Iceland"), # privzete izbire
               multiple = TRUE
  ),
  selectInput(inputId = "leto",
              label = "Leto",
              choices = unique(zdruzeno_tretji_graf$Leto),
              
              multiple = FALSE
  ),
  
  
  
  plotOutput("lin")
))