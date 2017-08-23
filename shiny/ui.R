library(shiny)

shinyUI( fluidPage(
  sidebarLayout(
    sidebarPanel("Število končanih visokošolskih izobrazb za izbrane države v izbranih letih"),
    mainPanel()
  ),
  
  selectInput( inputId = "Drzava",
               label = "Država",
               choices = unique(zdruzeno_tretji_graf$Drzava),
               selected = FALSE,
               multiple = TRUE
  ),
  selectInput(inputId = "Leto",
              label = "Leto",
              choices = unique(zdruzeno_tretji_graf$Leto),
              selected = FALSE,
              multiple = FALSE
  ),
  
  
  
  
  plotOutput("lin")
))