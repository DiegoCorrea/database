getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}


database <- read.csv(file="embrapaFine.csv", header=TRUE, sep=";", col.names= c("mes","temperatura","pluviometrico","evaPotencial","armazenHidrico","evaReal","defHidrica","excedHidrico","cidade"), encoding= "UFT8")
database$temperatura <- as.numeric(sub(",",".",database$temperatura))

levsMes <- unique(database$mes)

dadosDEF <- data.frame(
  
  mes = c(),
  def= c(),
  ecx= c()
)

for (i in levsMes) {
  mes <- subset(database, mes == i)
  
  tmp <- data.frame(
    mes = i,
    def = mean(mes$defHidrica),
    exc = mean(mes$excedHidrico)
  )
  dadosDEF <- rbind(dadosDEF, tmp)
}
minimo<- min(dadosDEF$def)
if(minimo  > min(dadosDEF$exc)){
  minimo <-min(dadosDEF$exc)
  
}

maximo<- max(dadosDEF$def)
if(maximo < max(dadosDEF$exc)){
  maximo <-max(dadosDEF$exc)
  
}
cat("\n----------------------------------------------\n")

mainDir <- "."
subDir <- "images"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
png(sprintf("def1.png"))
plot(c(1,12),c(minimo,maximo),
     type="o",
     col="white",
     main="Deficiência x Excesso Hídrico",
     xlab="Mês",
     ylab="Volume (mm)" )
     
lines(dadosDEF$mes, dadosDEF$def, type = "o", col = "red")
lines(dadosDEF$mes, dadosDEF$exc, type = "o", col = "blue")
legend("topleft",
       inset=.05,
       cex = 0.6,
       title="Legenda",
       c("Deficiência Hídrica","Excesso Hídrica"),
       horiz=TRUE,
       lty=c(1,1),
       lwd=c(2,2),
       col=c("red","blue"),
       bg="grey96")
grid(col="red")
dev.off()

