
library(readr)
BDP <- read_csv("nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni evrov", "3"), na = ":",
                locale = locale(encoding = "Windows-1250"))

BDP["1"] <- NULL
BDP["2"] <- NULL
BDP["3"] <- NULL

View(BDP)

data <- read_csv("educ_uoe_enra01_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "3", "4", "Stopnja izobrazbe", "Stevilo", "5"), na = ":",
                 locale = locale(encoding = "Windows-1250"))

data["1"] <- NULL
data["2"] <- NULL
data["3"] <- NULL
data["4"] <- NULL
data["5"] <- NULL
View(data)
