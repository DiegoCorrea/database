1. Remover o "evaReal", "defHidrica", "excedHidrico" com base na saída do summary(acpcor) do Feature-Selection.R e na análise estatística dos scripts feitos
2. ETr é menor ou no máximo igual a ETp
3. DEF = ETP – ETR
4. ± ALT = P – ETR – EXC
5. EXC → representa o EXCedente hídrico, ou seja, a quantidade de água que sobra no período chuvoso e se
	perde do volume de controle por percolação (drenagem profunda) e/ou escorrimento superficial. Existem duas
	situações:
		1a) quando ARM < CAD ⇒ EXC = 0,
		2a) quando ARM = CAD ⇒ EXC = (P-ETP) - ALT.
	-->>> Acho que podemos eliminar as linhas onde o ARM é menor que 100 (ou tirar esses valores) pois nesses casos o EXC é sempre 0. Dessa forma poderíamos estar eliminando outliers

6. Através dos dados do novo arquivo embrapaFine2o.csv todos os outros eliminados podem ser criados
