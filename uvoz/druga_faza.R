library(tibble)
library(dplyr)
library(readr)
library(dplyr)
library(tibble)
library(ggplot2)
library(dplyr)
library(digest)
library(maptools)
library(sp)
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(XML)
library(reshape2)
BDP <- read_csv("podatki/nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni_evrov", "3"),skip=1, na = ":",
                locale = locale(encoding = "Windows-1250")) %>% select(Leto, Drzava, Milijoni_evrov)





Tip_izobrazevanja <- read_csv("podatki/educ_uoe_enra01_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "3", "4", "Stopnja_izobrazbe", "Stevilo_koncanih", "5"),skip=1, na = ":",
                              locale = locale(grouping_mark = ",")) %>% select(Leto, Drzava, Stopnja_izobrazbe, Stevilo_koncanih)

Tip_izobrazevanja$Drzava <- gsub("^Germany.*$", "Germany", Tip_izobrazevanja$Drzava)


Tip_izobrazevanja$Stevilo_koncanih <- gsub(",", "", Tip_izobrazevanja$Stevilo_koncanih)
Tip_izobrazevanja$Stevilo_koncanih <- parse_number(Tip_izobrazevanja$Stevilo_koncanih)


stevilo_prebivalcev <- read_csv("podatki/demo_gind_1_Data.csv", na = ":",
                                col_names = c("Leto", "Drzava", "1", "Stevilo_preb", "2"),
                                skip = 1, locale = locale(grouping_mark = ",")) %>%
  select(Leto, Drzava, Stevilo_preb)

stevilo_prebivalcev <- subset(stevilo_prebivalcev, Drzava!="Germany (including former GDR)")
stevilo_prebivalcev$Drzava <- gsub("^Germany.*$", "Germany", stevilo_prebivalcev$Drzava)






stevilo_prebivalcev$Stevilo_preb <- gsub(",", "", stevilo_prebivalcev$Stevilo_preb)
stevilo_prebivalcev$Stevilo_preb <- parse_number(stevilo_prebivalcev$Stevilo_preb)




evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(continent == "Europe" | sovereignt %in% c("Turkey", "Cyprus"),
                                  long > -30)

delez.za.izobrazevanje <- readHTMLTable("podatki/gov_10a_exp.html", which = 1)
colnames(delez.za.izobrazevanje) <- c("Drzava", 2013:2015)

delez.za.izobrazevanje.tidy <- melt(delez.za.izobrazevanje, id.vars="Drzava", measure.vars = names(delez.za.izobrazevanje)[-1], variable.name = "leto", value.name = "delez BDPja namenjen za izobrazevanje",na.rm = TRUE)

colnames(delez.za.izobrazevanje.tidy)<- c("Drzava", "Leto", "delez_BDP_za_izobrazbo")
delez.za.izobrazevanje.tidy$Leto <- parse_number(delez.za.izobrazevanje.tidy$Leto)
delez.za.izobrazevanje.tidy$delez_BDP_za_izobrazbo <- parse_number(delez.za.izobrazevanje.tidy$delez_BDP_za_izobrazbo)

delez.za.izobrazevanje.tidy$Drzava <- gsub("^Germany.*$", "Germany", delez.za.izobrazevanje.tidy$Drzava)
delez.za.izobrazevanje.tidy$Drzava <- gsub("Czech Republic", "Czech Rep.",
                                           delez.za.izobrazevanje.tidy$Drzava) %>%
  parse_factor(levels(evropa$name))


#tretja_faza_vizualizacija

izbrane_drzave_izo <- Tip_izobrazevanja %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_stevilo <- stevilo_prebivalcev %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_delez_BDP <- delez.za.izobrazevanje.tidy %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_izo_vsota <- izbrane_drzave_izo %>% group_by(Leto, Drzava) %>% summarise(Stevilo_koncanih = sum(Stevilo_koncanih))
zdruzeno <- left_join(izbrane_drzave_izo_vsota, izbrane_drzave_stevilo)

izbrane_drzave_za_tretji_graf <- delez.za.izobrazevanje.tidy %>% filter(Drzava == "Iceland" | Drzava == "Denmark" | Drzava == "Belgium" | Drzava == "Romania" | Drzava == "Bulgaria" | Drzava == "Slovakia")
izbrane_drzave_izo_tretji_graf <- Tip_izobrazevanja %>% filter( Drzava == "Iceland" | Drzava == "Denmark" | Drzava == "Belgium"| Drzava == "Romania" | Drzava == "Bulgaria" | Drzava == "Slovakia")
izbrane_drzave_stevilo_tretji_graf <- stevilo_prebivalcev %>% filter( Drzava == "Iceland" | Drzava == "Denmark" | Drzava == "Belgium" | Drzava == "Romania" | Drzava == "Bulgaria" | Drzava == "Slovakia")
zdruzeno_tretji_graf <- left_join(izbrane_drzave_izo_tretji_graf, izbrane_drzave_stevilo_tretji_graf)

prvi_graf <- ggplot(zdruzeno, aes(x = Drzava, y = Stevilo_koncanih/Stevilo_preb,
                                  fill = factor(Leto))) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Drzave") + ylab("Stevilo koncanih izobrazb na prebivalca") +
  guides(fill = guide_legend("Leto"))




drugi_graf <- ggplot(izbrane_drzave_delez_BDP, aes(x = Drzava, y = delez_BDP_za_izobrazbo, fill = factor(Leto))) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Drzave") + ylab("delez BDPja namenjen izobrazbi") +
  guides(fill = guide_legend("Leto"))

tretji_graf <- ggplot(zdruzeno_tretji_graf %>% filter(Leto == 2015),
                      aes(x = Drzava, y = Stevilo_koncanih/Stevilo_preb, fill = Stopnja_izobrazbe)) +
  geom_col(position = "dodge")
 


zdruzena_zemljevid <- left_join(evropa, delez.za.izobrazevanje.tidy, by = c("name" = "Drzava"))

zemljevid <- ggplot() + geom_polygon(data = zdruzena_zemljevid, aes(x = long, y = lat, group = group, fill = delez_BDP_za_izobrazbo)) +
  coord_map(xlim = c(-25, 40), ylim = c(32, 72))

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
  
  radioButtons(inputId = "vrsta",
               label = "Stopnja izobrazbe",
               choices = list("Diploma",
                              "Magisterij",
                              "Doktorat")),
               
               
 plotOutput("lin")
  ))

shinyServer(function(input,output) {
  output$lin <- renderPlot({
    data <- filter(zdruzeno_tretji_graf,
                   Drzava == input$Drzava,
                   Leto == input$Leto,
                   Vrsta == input$vrsta
                   
      
    )
  })
}
  
  )

  