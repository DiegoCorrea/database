# Abrindo o arquivo, setando os nomes das colunas
data <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";",col.names= c("mes","temperatura","P","ETP","ARM","ETR","DEF","EXC","cidade"), encoding= "UFT8")

cat("\n----------------------------------------------\n")
print("Dados Calculados a partir de todas as entradas")
print("=Temperatura\n")
print("--Menor")
print(min(as.numeric(sub(",",".",data$temperatura))))
print("--Media")
print(mean(as.numeric(sub(",",".",data$temperatura))))
print("--Maior")
print(max(as.numeric(sub(",",".",data$temperatura))))

#####################################################################
#Carregando todos os nomes de cidades diferentes e colocando em 1 vetor
levsCidade <- unique( unlist( lapply( data$cidade , levels ) ) )
cat("\n----------------------------------------------\n")
cat("\nMenor, Maior e Média por Cidade\n")
for (i in levsCidade) {
  cat("\nCidade: ", i,"\n")
  cid <- subset(data, cidade == i)

  cat("\n+Temperatura: \n")
  print("---Menor")
  print(min(as.numeric(sub(",",".",cid$temperatura))))
  print("---Media")
  print(mean(as.numeric(sub(",",".",cid$temperatura))))
  print("---Maior")
  print(max(as.numeric(sub(",",".",cid$temperatura))))

  cat("\n+P: \n")
  print("---Menor") 
  print(min(cid$P))
  print("---Media") 
  print(mean(cid$P))
  print("---Maior")
  print(max(cid$P))

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
levsMes <- unique( unlist( lapply( data$mes , levels ) ) )
cat("\n----------------------------------------------\n")
cat("\nMenor, Maior e Média por Mês\n")
for (i in levsMes) {
  cat("\nMês: ", i,"\n")
  mes <- subset(data, mes == i)

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