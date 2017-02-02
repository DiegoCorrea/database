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

  cat("\nMenor, Maior, Média, Mediana e Moda\n")
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
levsMes <- unique(database$mes)
cat("\n----------------------------------------------\n")
dadosTemperatura <- data.frame(
  menor = c(),
  maior = c(),
  media = c(),
  mediana = c(),
  moda = c(),
  mes = c()
)
for (i in levsMes) {
  mes <- subset(database, mes == i)

  tmp <- data.frame(
    menor = min(mes$temperatura),
    maior = max(mes$temperatura),
    media = mean(mes$temperatura),
    mediana = median(mes$temperatura),
    moda = getmode(mes$temperatura),
    mes = i
  )

  dadosTemperatura <- rbind(dadosTemperatura, tmp)
}
cat("\n----------------------------------------------\n")
print(dadosTemperatura)

png(sprintf("images/temperaturaPorMes.png"))
plot(c(1,12), c(15,30), 
type="o",
col="white", 
main="Temperatura vs Mês",
xlab="Mês",
ylab="Temperatura")
lines(dadosTemperatura$mes, dadosTemperatura$maior, type = "o", col = "red")
lines(dadosTemperatura$mes, dadosTemperatura$menor, type = "o", col = "blue")
lines(dadosTemperatura$mes, dadosTemperatura$media, type = "o", col = "green")
lines(dadosTemperatura$mes, dadosTemperatura$mediana, type = "o", col = "black")
lines(dadosTemperatura$mes, dadosTemperatura$moda, type = "o", col = "pink")
#grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
grid(col="red")
dev.off()
cat("\n----------------------------------------------\n")

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