# Gerando gráfico de Mês por Temperatura
# Calcula Maximas, Minimas, Medias, Medianas e Modas
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")
database$temperatura <- as.numeric(sub(",",".",database$temperatura))

##########################################################
levsMes <- unique(database$mes)
cat("\n----------------------------------------------\n")
dadosPluviometrico <- data.frame(
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
    menor = min(mes$pluviometrico),
    maior = max(mes$pluviometrico),
    media = mean(mes$pluviometrico),
    mediana = median(mes$pluviometrico),
    moda = getmode(mes$pluviometrico),
    mes = i
  )

  dadosPluviometrico <- rbind(dadosPluviometrico, tmp)
}
cat("\n----------------------------------------------\n")
mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
png(sprintf("pluviometriaPorMes.png"))
plot(c(1,12), c(min(database$pluviometrico),max(database$pluviometrico) + 50), 
type="o",
col="white", 
main="Pluviometria vs Mês",
xlab="Mês",
ylab="Pluviometria(mm)")
lines(dadosPluviometrico$mes, dadosPluviometrico$maior, type = "o", col = "red")
lines(dadosPluviometrico$mes, dadosPluviometrico$menor, type = "o", col = "blue")
lines(dadosPluviometrico$mes, dadosPluviometrico$media, type = "o", col = "green")
lines(dadosPluviometrico$mes, dadosPluviometrico$mediana, type = "o", col = "black")
lines(dadosPluviometrico$mes, dadosPluviometrico$moda, type = "o", col = "pink")
legend("topright",
 inset=.05,
 cex = 0.5,
 title="Legenda",
 c("Maior","Menor","Media","Mediana","Moda"),
 horiz=TRUE,
 lty=c(1,1),
 lwd=c(2,2),
 col=c("red","blue","green","black","pink"),
 bg="grey96")
#grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
grid(col="red")
dev.off()
cat("\n----------------------------------------------\n")

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



##########################################################
cat("\n----------------------------------------------\n")
dadosEvapo <- data.frame(
  def = c(),
  etp = c(),
  etr = c()
)
for (i in levsMes) {
  mes <- subset(database, mes == i)

  tmp <- data.frame(
    def = mean(mes$defHidrica),
    etp = mean(mes$evaPotencial),
    etr = mean(mes$evaReal),
    mes = i
  )

  dadosEvapo <- rbind(dadosEvapo, tmp)
}
cat("\n----------------------------------------------\n")
png(sprintf("EtpEtrDefPorMes.png"))
plot(c(1,12), c(min(database$pluviometrico),max(database$evaPotencial)), 
type="o",
col="white", 
main="Transpiração vs Mês",
xlab="Mês",
ylab="Transpiração(mm)")
lines(dadosEvapo$mes, dadosEvapo$def, type = "o", col = "red")
lines(dadosEvapo$mes, dadosEvapo$etp, type = "o", col = "blue")
lines(dadosEvapo$mes, dadosEvapo$etr, type = "o", col = "green")
legend("topright",
 inset=.05,
 cex = 0.5,
 title="Legenda",
 c("Deficiencia Hidrica","EvapoTranspiração Potencial","EvapoTranspiração Real"),
 horiz=TRUE,
 lty=c(1,1),
 lwd=c(2,2),
 col=c("red","blue","green","black","pink"),
 bg="grey96")
#grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
grid(col="red")
dev.off()
cat("\n----------------------------------------------\n")