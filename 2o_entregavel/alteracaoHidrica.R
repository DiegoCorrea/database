getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
database <- read.csv(file="embrapaClean.csv", header=TRUE, sep=",", encoding= "UFT8")

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

  mes = c(),

  etr = c(),
  p = c(),
  exc = c()
)
for (i in levsMes) {
  mes <- subset(database, mes == i)

  tmp <- data.frame(
    menor = min(mes$altHidrico),
    maior = max(mes$altHidrico),
    media = mean(mes$altHidrico),
    mediana = median(mes$altHidrico),
    moda = getmode(mes$altHidrico),

    mes = i,

    etr = mean(mes$evaReal),
    p = mean(mes$pluviometrico),
    exc = mean(mes$excedHidrico)
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
ylab="Alteração Hidrica (mm)")
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


print("Dados Calculados a partir de todas as entradas")
print("=Alteração Hidrica")
print("--Menor")
print(min(database$altHidrico))
print("--Maior")
print(max(database$altHidrico))
print("--Media")
print(mean(database$altHidrico))
print("--Mediana")
print(median(database$altHidrico))
print("--Moda")
print(getmode(database$altHidrico))

cat("\n----------------------------------------------\n")
png(sprintf("Alt_P_Etr_Exc_por_Mes.png"),
  width     = 2.0,
  height    = 2.0,
  units     = "in",
  res       = 600,
  pointsize = 4)
plot(c(1,12), c(min(database$altHidrico),max(database$evaPotencial)), 
type="o",
col="white", 
main="Alteração Hídrica\nALT = P - ETR - EXC",
xlab="Mês",
ylab="Milímetro")
lines(dadosALT$mes, dadosALT$p, type = "o", col = "yellow", lwd = 0.5)
lines(dadosALT$mes, dadosALT$exc, type = "o", col = "blue", lwd = 0.5)
lines(dadosALT$mes, dadosALT$etr, type = "o", col = "green", lwd = 0.5)
lines(dadosALT$mes, dadosALT$media, type = "o", col = "black", lwd = 0.5)
legend("topright",
 inset=.05,
 cex = 0.5,
 title="Legenda",
 c("pluviometrico","Excedente Hidrico"),
 horiz=TRUE,
 lty=c(1,1),
 lwd=c(2,2),
 col=c("yellow","blue"),
 bg="grey96")
legend("bottomright",
 inset=.05,
 cex = 0.5,
 title="Legenda",
 c("EvapoTranspiração Real","Alteração Hidrica"),
 horiz=TRUE,
 lty=c(1,1),
 lwd=c(2,2),
 col=c("green","black"),
 bg="grey96")
#grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
grid(col="red", lwd = 0.5)
dev.off()
cat("\n----------------------------------------------\n")