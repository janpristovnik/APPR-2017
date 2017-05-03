
library(readr)
BDP <- read_csv("podatki/nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni_evrov", "3"),skip=1, na = ":",
                locale = locale(encoding = "Windows-1250"))

BDP["1"] <- NULL
BDP["2"] <- NULL
BDP["3"] <- NULL

View(BDP)

Tip_izobrazevanja <- read_csv("podatki/educ_uoe_enra01_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "3", "4", "Stopnja_izobrazbe", "Stevilo", "5"),skip=1, na = ":",
                 locale = locale(encoding = "Windows-1250"))

Tip_izobrazevanja["1"] <- NULL
Tip_izobrazevanja["2"] <- NULL
Tip_izobrazevanja["3"] <- NULL
Tip_izobrazevanja["4"] <- NULL
Tip_izobrazevanja["5"] <- NULL
View(Tip_izobrazevanja)

stevilo_prebivalcev <- read_csv("podatki/demo_gind_1_Data.csv", col_names = c("Leto", "Drzava", "1", "Stevilo", "2"), skip = 1)
stevilo_prebivalcev["1"] <- NULL
stevilo_prebivalcev["2"] <- NULL
View(stevilo_prebivalcev)

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

View(delez.za.izobrazevanje.tidy)


 