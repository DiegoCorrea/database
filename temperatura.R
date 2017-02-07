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
mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
png(sprintf("temperaturaPorMes.png"))
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
legend("bottomright",
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
print(min(database$temperatura))
print("--Maior")
print(max(database$temperatura))
print("--Media")
print(mean(database$temperatura))
print("--Mediana")
print(median(database$temperatura))
print("--Moda")
print(getmode(database$temperatura))