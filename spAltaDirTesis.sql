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
<<<<<<< HEAD
     VALUES(id_Director.nextval-1, vNomDir, vApPatDir, vApMatDir, vGradoAcad);
=======
     VALUES(id_Director.nextval, vNomDir, vApPatDir, vApMatDir, vGradoAcad);
     COMMIT;
>>>>>>> 9856d590fcc95d8905903afb0d8af23f16417e1a
     
END spAltaDirTesis;
/
SHOW ERRORS
