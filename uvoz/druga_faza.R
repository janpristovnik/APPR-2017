
library(readr)
library(dplyr)
library(tibble)
BDP <- read_csv("podatki/nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni_evrov", "3"),skip=1, na = ":",
                locale = locale(encoding = "Windows-1250")) %>% select(Leto, Drzava, Milijoni_evrov)





Tip_izobrazevanja <- read_csv("podatki/educ_uoe_enra01_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "3", "4", "Stopnja_izobrazbe", "Stevilo_koncanih", "5"),skip=1, na = ":",
                              locale = locale(grouping_mark = ",")) %>% select(Leto, Drzava, Stopnja_izobrazbe, Stevilo_koncanih)


Tip_izobrazevanja[13:15,2] <- "Germany"
Tip_izobrazevanja[118:120, 2] <- "Germany"
Tip_izobrazevanja[223:225, 2] <- "Germany"

Tip_izobrazevanja$Stevilo_koncanih <- gsub(",", "", Tip_izobrazevanja$Stevilo_koncanih)
Tip_izobrazevanja$Stevilo_koncanih <- parse_number(Tip_izobrazevanja$Stevilo_koncanih)


stevilo_prebivalcev <- read_csv("podatki/demo_gind_1_Data.csv", na = ":",
                                col_names = c("Leto", "Drzava", "1", "Stevilo_preb", "2"),
                                skip = 1, locale = locale(grouping_mark = ",")) %>%
  select(Leto, Drzava, Stevilo_preb)

stevilo_prebivalcev[5,2] <- "Germany"
stevilo_prebivalcev[57,2] <- "Germany"
stevilo_prebivalcev[109,2] <- "Germany"


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
delez.za.izobrazevanje.tidy$Leto <- parse_number(delez.za.izobrazevanje.tidy$Leto)
delez.za.izobrazevanje.tidy$delez_BDP_za_izobrazbo <- parse_number(delez.za.izobrazevanje.tidy$delez_BDP_za_izobrazbo)

delez.za.izobrazevanje.tidy$Drzava <- gsub("^Germany.*$", "Germany", delez.za.izobrazevanje.tidy$Drzava)



#tretja_faza_vizualizacija

izbrane_drzave_izo <- Tip_izobrazevanja %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_stevilo <- stevilo_prebivalcev %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_delez_BDP <- delez.za.izobrazevanje.tidy %>% filter(Drzava=="Italy" | Drzava =="Spain" | Drzava == "Germany" | Drzava == "Malta" | Drzava =="Slovenia" | Drzava == "Croatia"| Drzava == "Sweden" )
izbrane_drzave_izo_vsota <- izbrane_drzave_izo %>% group_by(Leto, Drzava) %>% summarise(Stevilo_koncanih = sum(Stevilo_koncanih))
zdruzeno <- left_join(izbrane_drzave_izo_vsota, izbrane_drzave_stevilo)

library(ggplot2)
library(dplyr)
prvi_graf <- ggplot(zdruzeno, aes(x = Drzava, y = Stevilo_koncanih/Stevilo_preb,
                                  fill = factor(Leto))) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Drzave") + ylab("Stevilo koncanih izobrazb na prebivalca") +
  guides(fill = guide_legend("Leto"))



drugi_graf <- ggplot(izbrane_drzave_delez_BDP, aes(x = Drzava, y = delez_BDP_za_izobrazbo, fill = factor(Leto))) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Drzave") + ylab("delez BDPja namenjen izobrazbi") +
  guides(fill = guide_legend("Leto"))
 