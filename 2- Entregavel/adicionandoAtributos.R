database <- read.csv(file="embrapaClean.csv", header=TRUE, sep=",", encoding= "UFT8")

database['altHidrico'] <- c(database$pluviometrico - database$evaReal - database$excedHidrico)
database['PETP'] <- c(database$pluviometrico - database$evaPotencial)

write.csv(database, 
  "EmbrapaNovosAtributos.csv", 
  row.names=FALSE
  )