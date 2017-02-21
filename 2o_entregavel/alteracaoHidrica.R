getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")

database['altHidrico'] <- c(database$pluviometrico - database$evaReal - database$excedHidrico)

##########################################################
levsMes <- unique(database$mes)
cat("\n----------------------------------------------\n")
dadosALT <- data.frame(
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
    menor = min(mes$altHidrico),
    maior = max(mes$altHidrico),
    media = mean(mes$altHidrico),
    mediana = median(mes$altHidrico),
    moda = getmode(mes$altHidrico),
    mes = i
  )

  dadosALT <- rbind(dadosALT, tmp)
}
cat("\n----------------------------------------------\n")
mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
png(
  sprintf("ALTPorMes.png"),
  width     = 2.0,
  height    = 2.0,
  units     = "in",
  res       = 600,
  pointsize = 4)

plot(c(1,12), c(min(dadosALT$menor),max(dadosALT$maior + 30)), 
type="o",
col="white",
main="Alteração Hídrica vs Mês",
xlab="Mês",
ylab="altHidrico(mm)")
lines(dadosALT$mes, dadosALT$maior, type = "o", col = "red", lwd = 0.5)
lines(dadosALT$mes, dadosALT$menor, type = "o", col = "blue", lwd = 0.5)
lines(dadosALT$mes, dadosALT$media, type = "o", col = "green", lwd = 0.5)
lines(dadosALT$mes, dadosALT$mediana, type = "o", col = "black", lwd = 0.5)
lines(dadosALT$mes, dadosALT$moda, type = "o", col = "pink", lwd = 0.5)
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
grid(col="red", lwd = 0.5)
dev.off()