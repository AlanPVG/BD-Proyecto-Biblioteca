 --Procedimiento para dar de alta director de tésis
 
 CREATE OR REPLACE PROCEDURE spAltaDirTesis(
     vNomDir IN directorTesis.nomDirect%TYPE,
     vApPatDir IN directorTesis.apPatDirect%TYPE,
     vApMatDir IN directorTesis.apMatDirect%TYPE,
     vGradoAcad IN directorTesis.gradoAcad%TYPE
 )
 
 AS
 BEGIN
     
      INSERT INTO directorTesis
      VALUES(id_Director.nextval-1, vNomDir, vApPatDir, vApMatDir, vGradoAcad);
      COMMIT;
      
 END spAltaDirTesis;
 /