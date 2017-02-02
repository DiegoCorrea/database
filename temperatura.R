getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")
database$temperatura <- as.numeric(sub(",",".",database$temperatura))

levsCidade <- unique( unlist( lapply( database$cidade , levels ) ) )

cat("\n----------------------------------------------\n")
for (i in levsCidade) {
  cat("\nCidade: ", i,"\n")
  cid <- subset(database, cidade == i)

  png(sprintf("images/cidade/temperatura/%s.png",i))
  plot(cid$temperatura, 
  type="o",
  col="blue", 
  main=sprintf("%s\n Mês vs Temperatura\n", i),
  lwd=3,
  xlab="Mês",
  ylab="Temperatura")
  #grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
  grid(col="red")

  texto <- sprintf("Média: %f", mean(cid$temperatura))
  mtext(texto, side=1, valign="center", cex=0.8, halign= "left", mar=c(0,0,0,0), col="black", line=1)  

  dev.off()

  cat("\nMenor, Maior e Média por Cidade\n")
  cat("\n+Temperatura: \n")
  print("---Menor")
  print(min(cid$temperatura))
  print("---Maior")
  print(max(cid$temperatura))
  print("---Media")
  print(mean(cid$temperatura))
  print("--Mediana")
  print(median(cid$temperatura))
  print("--Moda")
  print(getmode(cid$temperatura))
}

##########################################################
levsMes <- unique( unlist( lapply( database$mes , levels ) ) )
cat("\n----------------------------------------------\n")
cat("\nMenor, Maior e Média por Mês\n")
dadosTemperatura <- data.frame(
  menor = c(),
  maior = c(),
  media = c(),
  mediana = c(),
  moda = c()
)
for (i in levsMes) {

  cat("\nMês: ", i,"\n")
  mes <- subset(database, mes == i)

  cat("\n+Temperatura: \n")
  print("---Menor") 
  tmp.menor <- min(mes$temperatura)
  dadosTemperatura$menor <- c(dadosTemperatura$menor, tmp.menor)
  print(tmp.menor)

  print("---Media") 
  tmp.media <- mean(mes$temperatura)
  print(tmp.media)

  print("---Maior")
  tmp.maior <- max(mes$temperatura)
  print(tmp.maior)

  print("--Mediana")
  tmp.mediana <- median(mes$temperatura)
  print(tmp.mediana)

  print("--Moda")
  tmp.moda <- getmode(mes$temperatura)
  print(tmp.moda)

  #dadosTemperatura$menor <- rbind(men)
  #dadosTemperatura$maior <- rbind(mai)
  #dadosTemperatura$mediana <- rbind(medi)
  #dadosTemperatura$moda <- rbind(moda)
  #dadosTemperatura$media <- rbind(med)
}

cat("\n----------------------------------------------\n")
print("Dados Calculados a partir de todas as entradas")
print("=Temperatura")
print("--Menor")
print(min(database$temperatura))
print("--Maior")
print(max(database$temperatura))
print("--Media")
print(mean(database$temperatura))
print("--Mediana")
print(median(database$temperatura))
print("--Moda")
print(getmode(database$temperatura))