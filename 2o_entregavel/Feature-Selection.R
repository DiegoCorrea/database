#install.packages("Boruta")
library(Boruta)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# Abrindo o arquivo, setando os nomes das colunas
database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")
database$temperatura <- as.numeric(sub(",",".",database$temperatura))
database$pluviometrico <- as.numeric(sub(",",".",database$pluviometrico))

dados <- data.frame(database$temperatura, database$pluviometrico, database$evaPotencial, database$armazenHidrico, database$evaReal, database$defHidrica, database$excedHidrico)

#	Ref.: http://wiki.icmc.usp.br/images/a/ab/Prcomp.pdf

acpcor <- prcomp(dados, scale = TRUE) 
summary(acpcor)

sum(acpcor$sdev^2)

print("Variancia de temperatura")
acpcor$sdev[1]^2	# mostra a variancia do 1o atributo

print("Variancia de pluviometrico")
acpcor$sdev[2]^2

print("Variancia de evaPotencial")
acpcor$sdev[3]^2

print("Variancia de armazenHidrico")
acpcor$sdev[4]^2

print("Variancia de evaReal")
acpcor$sdev[5]^2

print("Variancia de defHidrica")
acpcor$sdev[6]^2

print("Variancia de excedHidrico")
acpcor$sdev[7]^2

print("== Media das variancias ==")
mean(acpcor$sdev[1]^2, acpcor$sdev[2]^2, acpcor$sdev[3]^2, acpcor$sdev[4]^2, acpcor$sdev[5]^2, acpcor$sdev[6]^2, acpcor$sdev[7]^2)


plot(1:ncol(dados), acpcor$sdev^2, type = "b", xlab = "Atributo", ylab = "Variância", pch = 20, cex.axis = 1.3, cex.lab = 1.3)

# Cria gráficos no pdf
screeplot(acpcor)
plot(acpcor)

#acpcor$rotation[, 1:7]

#print(acpcor$sdev[1:7] * t(acpcor$rotation[, 1:7]), digits = 3)

#print("-----------------------------------------------------------------")

#ajuste=lm(database$excedHidrico ~ database$temperatura)

#anova(ajuste)

##arq <- file("embrapaFine2o.csv", encoding = "UTF-8")

write.csv(data.frame(mes = database$mes,
					temperatura = database$temperatura,
					pluviometrico = database$pluviometrico,
					evaPotencial = database$evaPotencial,
					armazenHidrico = database$armazenHidrico,
					cidade = database$cidade), "embrapaFine2o.csv", row.names=FALSE)