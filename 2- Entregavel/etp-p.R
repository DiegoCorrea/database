getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

database <- read.csv(file="embrapaClean.csv", header=TRUE, sep=",", encoding= "UFT8")

database['PETP'] <- c(database$pluviometrico - database$evaPotencial)

levsMes <- unique(database$mes)

dadosPETP <- data.frame(
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
    menor = min(mes$PETP),
    maior = max(mes$PETP),
    media = mean(mes$PETP),
    mediana = median(mes$PETP),
    moda = getmode(mes$PETP),
    mes = i
  )
  
  dadosPETP <- rbind(dadosPETP, tmp)
}



cat("\n----------------------------------------------\n")

mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
png(
  sprintf("PETP.png"),
    width     = 2.0,
    height    = 2.0,
    units     = "in",
    res       = 600,
    pointsize = 4)

plot(c(1,12), c(min(dadosPETP$menor),max(dadosPETP$maior + 30)), 
     type="o",
     col="white",
     main="P-ETP vs Mês",
     xlab="Mês",
     ylab="P-ETP")
lines(dadosPETP$mes, dadosPETP$maior, type = "o", col = "blue", lwd = 0.5)
lines(dadosPETP$mes, dadosPETP$menor, type = "o", col = "red", lwd = 0.5)


legend("topright",
       inset=.05,
       cex = 0.5,
       title="Legenda",
       c("Maior","Menor"),
       horiz=TRUE,
       lty=c(1,1),
       lwd=c(2,2),
       col=c("blue","red"),
       bg="grey96")
#grid cria quadrantes no gráfico, essas linhas da divisoria, terão a cor vermelha
grid(col="red", lwd = 0.5)
dev.off()
