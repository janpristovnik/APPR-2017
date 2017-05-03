
library(readr)
BDP <- read_csv("podatki/nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni evrov", "3"),skip=1, na = ":",
                locale = locale(encoding = "Windows-1250"))

BDP["1"] <- NULL
BDP["2"] <- NULL
BDP["3"] <- NULL

View(BDP)

data <- read_csv("podatki/educ_uoe_enra01_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "3", "4", "Stopnja izobrazbe", "Stevilo", "5"),skip=1, na = ":",
                 locale = locale(encoding = "Windows-1250"))

data["1"] <- NULL
data["2"] <- NULL
data["3"] <- NULL
data["4"] <- NULL
data["5"] <- NULL
View(data)

stevilo_prebivalcev <- read_csv("podatki/demo_gind_1_Data.csv", col_names = c("Leto", "Drzava", "1", "Stevilo", "2"), skip = 1)
stevilo_prebivalcev["1"] <- NULL
stevilo_prebivalcev["2"] <- NULL
View(stevilo_prebivalcev)
 