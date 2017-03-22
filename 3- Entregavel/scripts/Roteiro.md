Dentro da pasta dos Scripts para Postgres  
  
1. Criar banco no Postgres  
  Criando usuario: `sudo -u postgres createuser bd`  
  Acessando terminal do postgres: `sudo su postgres`  
  Criando Banco: `createdb embrapa;`  
  Acessando Banco: `psql embrapa`  
  
OBS: Dentro do psql digite: `\timing on`, para o contador de tempo ser iniciado  
2. Criando Tabelas: `\i CREATETABLE.sql`  
  
OBS: Com `\dt` é possivel ver todas as tabelas do banco  
3. Carregando base CSV: `\i IMPORTCSV.sql`  
  
4. Inserindo novos dados: `\i INSERTS.sql`  
  
5. Busca nas Tabelas: ``  