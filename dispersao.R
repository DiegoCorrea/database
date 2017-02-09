#install.packages("calibrate")
library(calibrate)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# Abrindo o arquivo, setando os nomes das colunas
database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")
database$temperatura <- as.numeric(sub(",",".",database$temperatura))
database$pluviometrico <- as.numeric(sub(",",".",database$pluviometrico))

# http://arademaker.github.io/CA-2012-1/2012-03-06/revisao-R.html
vecMediaTemp <- vector()
vecMediaPluv <- vector()

#####################################################################
#Carregando todos os nomes de cidades diferentes e colocando em 1 vecMediaTemp
levsMes <- unique(database$mes)
cat("\n----------------------------------------------\n")
cat("\nMedia por Mes\n")
for (i in levsMes) {
  mes <- subset(database, mes == i)

  mediaTemp <- mean(mes$temperatura)

  mediaPluv <- mean(mes$pluviometrico)
  print("Media mediaPluv")
  print(mediaPluv)

  vecMediaTemp[i] <- mediaTemp
  cat("======>> mediaTemp do vecMediaTemp = ", vecMediaTemp[i])
  vecMediaPluv[i] <- mediaPluv
  cat("======>> mediaPluv do vecMediaPluv = ", vecMediaPluv[i])
}
mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
# Inicio da imagem png
png(sprintf("dispersaoTempVSChuvas.png"))
  plot(vecMediaTemp, vecMediaPluv,
  main=sprintf("Dispersão de Temperatura e Índice Pluviométrico"),
  lwd=3,
  xlab="Temperatura",
  ylab="Índice Pluviométrico")
  #grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
  grid(col="red")
  textxy(vecMediaTemp, vecMediaPluv,levsMes)
  abline(lm(vecMediaPluv~vecMediaTemp)) # reta de regressão linear no gráfico de dispersão

  texto <- sprintf("Legenda")
  mtext(texto, side=1, valign="center", cex=0.8, halign= "left", mar=c(0,0,0,0), col="black", line=1)  

dev.off()
# Fim da imagem png

##########################################################

data <- data.frame(database$temperatura, database$pluviometrico, database$evaPotencial, database$armazenHidrico, database$evaReal, database$defHidrica, database$excedHidrico)
png(sprintf("Boxplot.png"))
  boxplot(data, ylab = "", names = c("T", "P", "ETP", "ARM", "ETR", "DEF", "EXC"))
dev.off()
# Fim da imagem png

cat("\n----------------------------------------------\n")
print("Dados Calculados a partir de todas as entradas")
print("=Temperatura")
print("--Menor")
print(min(database$pluviometrico))
print("--Maior")
print(max(database$pluviometrico))
print("--Media")
print(mean(database$pluviometrico))
print("--Mediana")
print(median(database$pluviometrico))
print("--Moda")
print(getmode(database$pluviometrico))