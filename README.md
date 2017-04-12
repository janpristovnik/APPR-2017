# Analiza podatkov s programom R, 2016/17

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

Za temo sem si izbral visokošolstvo med izbranimi državami. Analiziral bom koliko ljudi v posamezni državi v posameznih letih konča diplomski, podiplomski/magistrjski študij in pa doktorat. Za posamezno državo bom pogledal njihov BDP v posameznih letih, število prebivalcev v posameznih državah in pa kolikšen delež premoženja država namenja šolstvu. Sproti bom poiskusil najti še dodatne faktorje, ki bi jih lahko vključil v analizo, s tem mislim faktorje, ki bi lahko vplivali na večje/manjše število ljudi z visokošolsko izobrazbo. 

Tabela 1

* prvi stolpec država
* drugi stolpec leto
* tretji stolpec število ljudi, ki so v tem letu končali diplomski študij
* tretji stolpec število ljudi, ki so v tem letu končali podiplomski študij/magisterij
* tretji stolpec število ljudi, ki so v tem letu končali doktorat

Tabela 2

* prvi stolpec država
* drugi stolpec leto
* BDP države v izbranem letu

Tabela 3 

* prvi stolpec država
* drugi stolpec leto 
* število prebivalcev v tem letu 

Tabela 4

* prvi stolpec država
* drugi stolpec leto
* delež premoženja, ki ga država namenja šolstvu

Viri so iz Eurostata, Wikipedije in worldbanka. 


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
