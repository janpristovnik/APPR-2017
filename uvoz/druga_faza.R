
library(readr)
BDP <- read_csv("podatki/nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni_evrov", "3"),skip=1, na = ":",
                locale = locale(encoding = "Windows-1250"))

BDP["1"] <- NULL
BDP["2"] <- NULL
BDP["3"] <- NULL



Tip_izobrazevanja <- read_csv("podatki/educ_uoe_enra01_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "3", "4", "Stopnja_izobrazbe", "Stevilo_koncanih", "5"),skip=1, na = ":",
                 locale = locale(encoding = "Windows-1250"))

Tip_izobrazevanja["1"] <- NULL
Tip_izobrazevanja["2"] <- NULL
Tip_izobrazevanja["3"] <- NULL
Tip_izobrazevanja["4"] <- NULL
Tip_izobrazevanja["5"] <- NULL

Tip_izobrazevanja$Stevilo_koncanih <- gsub(",", "", Tip_izobrazevanja$Stevilo_koncanih)
Tip_izobrazevanja$Stevilo_koncanih <- parse_number(Tip_izobrazevanja$Stevilo_koncanih)


stevilo_prebivalcev <- read_csv("podatki/demo_gind_1_Data.csv", col_names = c("Leto", "Drzava", "1", "Stevilo_preb", "2"), skip = 1)
stevilo_prebivalcev["1"] <- NULL
stevilo_prebivalcev["2"] <- NULL

stevilo_prebivalcev$Stevilo_preb <- gsub(",", "", stevilo_prebivalcev$Stevilo_preb)
stevilo_prebivalcev$Stevilo_preb <- parse_number(stevilo_prebivalcev$Stevilo_preb)

library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(XML)
library(reshape2)
library(reshape)
delez.za.izobrazevanje <- readHTMLTable("podatki/gov_10a_exp.html", which = 1)
colnames(delez.za.izobrazevanje) <- c("Drzava", 2013:2015)

delez.za.izobrazevanje.tidy <- melt(delez.za.izobrazevanje, id.vars="Drzava", measure.vars = names(delez.za.izobrazevanje)[-1], variable.name = "leto", value.name = "delez BDPja namenjen za izobrazevanje",na.rm = TRUE)

colnames(delez.za.izobrazevanje.tidy)<- c("Drzava", "Leto", "delez_BDP_za_izobrazbo")

#tretja_faza_vizualizacija

izbrane_drzave_izo <- Tip_izobrazevanja %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany (until 1990 former territory of the FRG)" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_stevilo <- stevilo_prebivalcev %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany (until 1990 former territory of the FRG)" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )

izbrane_drzave_izo_vsota <- izbrane_drzave_izo %>% group_by(Leto, Drzava) %>% summarise(Stevilo_koncanih = sum(Stevilo_koncanih))
zdruzeno <- left_join(izbrane_drzave_izo_vsota, izbrane_drzave_stevilo)

library(ggplot2)
library(dplyr)
prvi_graf <- ggplot(zdruzeno) + aes(x = Drzava, y = Stevilo_koncanih/Stevilo_preb) + geom_point() + xlab("Drzave") + ylab("Stevilo koncanih izobrazb na prebivalca")




 