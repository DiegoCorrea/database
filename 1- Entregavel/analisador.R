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
  print(mean(as.numeric(sub(",",".",cid$temperatura))))
  print("---Maior")
  print(max(as.numeric(sub(",",".",cid$temperatura))))

  png(sprintf("images/cidade/temperatura/%s.png",i))
  plot(as.numeric(sub(",",".",cid$temperatura)), 
  type="o",
  col="blue", 
  main=sprintf("%s\n Mês vs Temperatura\n", i),
  lwd=3,
  xlab="Mês",
  ylab="Temperatura")
  #grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
  grid(col="red")

  texto <- sprintf("Menor Temperatura: %f\nMedia: %f\nMaior: %f",min(as.numeric(sub(",",".",cid$temperatura))),mean(as.numeric(sub(",",".",cid$temperatura))),max(as.numeric(sub(",",".",cid$temperatura))))
  mtext(texto, side=1, valign="center", cex=0.8, halign= "left", mar=c(0,0,0,0), col="black", line=1)  

  dev.off()
}

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

#png(file = "cidade.png")
#plot(cid$mes, cid$temperatura, type="o", col="blue", 
#  main="Cidade: \n",
#  lwd=3,
#  xlab="Mês",
#  ylab="Temperatura")

# grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
#grid(col="red")
#dev.off()
