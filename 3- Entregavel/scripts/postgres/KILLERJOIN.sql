SELECT * FROM embrapacem inha INNER JOIN (SELECT *
   FROM embrapamil
   WHERE mes='Jan') mil USING(mes);