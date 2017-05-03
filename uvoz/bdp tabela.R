BDP <- read_csv("nama_10_gdp_1_Data.csv", col_names = c("Leto", "Drzava", "1", "2", "Milijoni evrov", "3"), na = ":",
                 locale = locale(encoding = "Windows-1250"))

BDP["1"] <- NULL
BDP["2"] <- NULL
BDP["3"] <- NULL
