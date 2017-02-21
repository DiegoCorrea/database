#install.packages("caret")
#install.packages("ml")
library(calibrate)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# Abrindo o arquivo, setando os nomes das colunas
database <- read.csv(file="embrapaClean.csv", header=TRUE, sep=",", encoding= "UFT8")


dados <- data.frame(database$temperatura, database$pluviometrico, database$evaPotencial, database$armazenHidrico, database$evaReal, database$defHidrica, database$excedHidrico)

 # ensure the results are repeatable 
 set.seed (7) 
 # load the library 
 library (mlbench) 
 library (caret) 
 # load the data 
 data (dados) 
 # calculate correlation matrix 
 correlationMatrix   <-   cor (dados [ , 1:7 ])
 # summarize the correlation matrix 
 print (correlationMatrix) 
 # find attributes that are highly corrected (ideally >0.75) 
 highlyCorrelated   <-   findCorrelation (correlationMatrix ,   cutoff = 0.5)
 # print indexes of highly correlated attributes 
 print (highlyCorrelated)