#graficos do Arm
#arm= representa o armazenamento de ?gua no solo

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}


database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")
database$temperatura <- as.numeric(sub(",",".",database$temperatura))

levsMes <- unique(database$mes)

dadosARM <- data.frame(
 
  mes = c(),
  media= c(),
  pluvi= c()
)


for (i in levsMes) {
  mes <- subset(database, mes == i)
  
  tmp <- data.frame(
       mes = i,
       media = mean(mes$armazenHidrico),
       pluv = mean(mes$pluviometrico)
  )
  dadosARM <- rbind(dadosARM, tmp)
}

minimo <- min(dadosARM$media)
if(minimo > min(dadosARM$pluv)){
  minimo <- min(dadosARM$pluv)
}

maximo <- max(dadosARM$media)
if(maximo < max(dadosARM$pluv)){
  maximo <- max(dadosARM$pluv)
}

mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
png(sprintf("ARM_PorMes.png"))
plot(c(1,12),c(minimo, maximo),
     type="o",
     col="white", 
     main="Armazenamento de água no solo por Mês",
     xlab="Mês",
     ylab="Volume de Água (mm)")
lines(dadosARM$mes, dadosARM$media, type = "o", col = "red")
lines(dadosARM$mes, dadosARM$pluv, type = "o", col = "blue")
legend("topright",
       inset=.05,
       cex = 0.6,
       title="Legenda",
       c("Armazenamento Hídrico","Índice Pluviométrico"),
       horiz=TRUE,
       lty=c(1,1),
       lwd=c(2,2),
       col=c("red","blue"),
       bg="grey96")
grid(col="red")
dev.off()
    
     