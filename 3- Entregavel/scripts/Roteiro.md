### Roteiro de Execução  

***Este Roteiro foi feito para rodar em Linux***

1. Criando e iniciando o banco  
* Dentro da pasta dos Scripts para Postgres  
  * Criando usuario: `sudo -u postgres createuser bd`  
  * Acessando terminal do postgres: `sudo su postgres`  
  * Criando Banco: `createdb embrapa;`  
  * Acessando Banco: `psql embrapa`  
  
* Dentro da pasta do VoltDB  
  * Iniciando o VoltDB: `sh scripts/volt/startVolt.sh`  
  * Terminal: `bin/sqlcmd`  
  
  Postgres: Dentro do psql digite `\timing on`, para o contador de tempo ser iniciado  
2. Criando Tabelas:  
  Postgres: `\i CREATETABLE.sql`  
  Volt: `file ./scripts/volt/CREATETABLE.sql;`  
  Para medir o tempo do VOLT na criação de tabela use: `time echo 'file ./scripts/volt/CREATETABLE.sql;' | bin/sqlcmd`  
  Para medir o tempo do POSTGRES na criação de tabela use: `time echo '\i CREATETABLE.sql;' | psql embrapa`  
  
2.5. Particionamento:  `file ./scripts/volt/PARTITION.sql;`  
  
3. Carregando base CSV:  
  Postgres: Com `\dt` é possivel ver todas as tabelas do banco  
  Postgres: `\i IMPORTCSV.sql`  
  Volt: Com `SHOW tables` é possivel ver todas as tabelas do banco  
  Volt: `sh scripts/volt/CSVLOADER.sh`  
  
4. Inserindo novos dados:  
  Postgres: `\i INSERT.sql`  
  Volt: `file ./scripts/volt/INSERT.sql;`  
  
5. Busca nas Tabelas:  
  Postgres: `\i SELECT.sql`  
  Volt: `file ./scripts/volt/SELECT.sql;`  
  
6. Atualizando os Dados:  
  Postgres: `\i UPDATE.sql`  
  Volt: `file ./scripts/volt/UPDATE.sql;`  
  
7. (Re)Busca nas Tabelas:  
  Postgres: `\i SELECT.sql`  
  Volt: `file ./scripts/volt/SELECT.sql;`  
  
8. Deletando Dados:  
  Postgres: `\i DELETE.sql`  
  Volt: `file ./scripts/volt/DELETE.sql;`  
  
9. (Re)Busca nas Tabelas:  
  Postgres: `\i SELECT.sql`  
  Volt: `file ./scripts/volt/SELECT.sql;`  
  
10. Joins:  
* Postgres  
  * Join: `\i JOIN.sql`  
  * Killer Join: `\i KILLERJOIN.sql`  
* Volt  
  * Join: `file ./scripts/volt/JOIN.sql`  
  * Killer Join: `file ./scripts/volt/KILLERJOIN.sql`  
  
11. Deletando Tabelas:   
  Postgres: `\i DROPTABLE.sql`  
  Volt: `file ./scripts/volt/DROPTABLE.sql;`  
  Para medir o tempo do VOLT do deletar tabela use: `time echo 'file ./scripts/volt/DROPTABLE.sql;' | bin/sqlcmd`   
  Para medir o tempo do POSTGRES do deletar tabela use: `time echo '\i DROPTABLE.sql;' | psql embrapa`   
  
12. Deletando o banco:  
  Postgres: `dropbd embrapa`  
  Volt: `bin/voltdb init --force`  
  
Postgres: Com `\dt` é possivel ver todas as tabelas do banco  
Volt: Com `SHOW tables` é possivel ver todas as tabelas do banco  
