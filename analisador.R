#Abrindo o arquivo, setando os nomes das colunas
data <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";",col.names= c("mes","temperatura","P","ETP","ARM","ETR","DEF","EXC","cidade"))
#Carregando todos os nomes de cidades diferentes e colocando em 1 vetor
levsCidade <- unique( unlist( lapply( data$cidade , levels ) ) )


print("=Temperatura\n")
print("--Menor") 
print(min(as.numeric(sub(",",".",data$temperatura))))
print("--Media") 
print(mean(as.numeric(sub(",",".",data$temperatura))))
print("--Maior")
print(max(as.numeric(sub(",",".",data$temperatura))))


cat("\nMenor, Maior e Média por Cidade\n")
for (i in levsCidade) {
  cat("\nCidade: ", i,"\n")
  cid <- subset(data, cidade == i)

  print("=Temperatura: ")
  print("--Menor") 
  print(min(as.numeric(sub(",",".",cid$temperatura))))
  print("--Media") 
  print(mean(as.numeric(sub(",",".",cid$temperatura))))
  print("--Maior")
  print(max(as.numeric(sub(",",".",cid$temperatura))))
}

levsMes <- unique( unlist( lapply( data$mes , levels ) ) )

cat("\nMenor, Maior e Média por Mês\n")
for (i in levsMes) {
  cat("\nCidade: ", i,"\n")
  mes <- subset(data, mes == i)

  print("=Temperatura: ")
  print("--Menor") 
  print(min(as.numeric(sub(",",".",mes$temperatura))))
  print("--Media") 
  print(mean(as.numeric(sub(",",".",mes$temperatura))))
  print("--Maior")
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