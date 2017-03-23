SELECT * FROM embrapinha inha LEFT OUTER JOIN (SELECT cidade
   FROM embrapamil
   WHERE cidade='Salvador') mil USING(cidade);

SELECT mes,temperatura,tempmil FROM embrapacem inha INNER JOIN (SELECT mes,temperatura as tempmil
   FROM embrapamil
   WHERE mes='Jan' AND cidade='Salvador') mil USING(mes);