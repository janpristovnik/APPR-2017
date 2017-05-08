library(ggplot2)
library(dplyr)

graf_bdp <- ggplot(BDP) + aes(x = Drzava, y = Milijoni_evrov) + geom_point()
print(graf_bdp)
