# Abrindo o arquivo, setando os nomes das colunas
database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")

cat("\n----------------------------------------------\n")
print("Dados Calculados a partir de todas as entradas")
print("=Temperatura\n")
print("--Menor")
print(min(as.numeric(sub(",",".",database$temperatura))))
print("--Media")
print(mean(as.numeric(sub(",",".",database$temperatura))))
print("--Maior")
print(max(as.numeric(sub(",",".",database$temperatura))))

# http://arademaker.github.io/CA-2012-1/2012-03-06/revisao-R.html
vetor <- vector()
vetor2 <- vector()

#####################################################################
#Carregando todos os nomes de cidades diferentes e colocando em 1 vetor
levsCidade <- unique( unlist( lapply( database$cidade , levels ) ) )
cat("\n----------------------------------------------\n")
cat("\nMenor, Maior e Média por Cidade\n")
for (i in levsCidade) {
  cat("\nCidade: ", i,"\n")
  cid <- subset(database, cidade == i)

  cat("\n+Temperatura: \n")
  print("---Menor")
  print(min(as.numeric(sub(",",".",cid$temperatura))))
  print("---Media")
  mediaTemp <- mean(as.numeric(sub(",",".",cid$temperatura)))
  print(mediaTemp)
  print("---Maior")
  maxTemp <- max(as.numeric(sub(",",".",cid$temperatura)))
  print(maxTemp)

  mediaPluv <- mean(as.numeric(cid$pluviometrico))
  print("Media mediaPluv")
  print(mediaPluv)

  vetor[i] <- mediaTemp
  cat("======>> mediaTemp do vetor = ", vetor[i])
  vetor2[i] <- mediaPluv
  cat("======>> mediaPluv do vetor2 = ", vetor2[i])
}

# Inicio da imagem png
png(sprintf("images/dispersaoTempVSChuvas.png"))
  plot(vetor, vetor2,
  main=sprintf(":: Dispersão de Temperatura e Índice Pluviométrico ::"),
  lwd=3,
  xlab="Temperatura",
  ylab="Índice Pluviométrico")
  #grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
  grid(col="red")

  abline(lm(vetor2~vetor)) # reta de regressão linear no gráfico de dispersão

  texto <- sprintf("Legenda")
  mtext(texto, side=1, valign="center", cex=0.8, halign= "left", mar=c(0,0,0,0), col="black", line=1)  

dev.off()
# Fim da imagem png

##########################################################
levsMes <- unique( unlist( lapply( database$mes , levels ) ) )
cat("\n----------------------------------------------\n")
cat("\nMenor, Maior e Média por Mês\n")
for (i in levsMes) {
  cat("\nMês: ", i,"\n")
  mes <- subset(database, mes == i)

  cat("\n+Temperatura: \n")
  print("---Menor") 
  print(min(as.numeric(sub(",",".",mes$temperatura))))
  print("---Media") 
  print(mean(as.numeric(sub(",",".",mes$temperatura))))
  print("---Maior")
  print(max(as.numeric(sub(",",".",mes$temperatura))))
}

# tam <- length(vetor2)
# cat("Tamanho do vetor = ", tam)

#png(file = "cidade.png")
#plot(cid$mes, cid$temperatura, type="o", col="blue", 
#  main="Cidade: \n",
#  lwd=3,
#  xlab="Mês",
#  ylab="Temperatura")

# grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
#grid(col="red")
#dev.off()
