-- Procedimiento para catalogar como tésis a un material

CREATE OR REPLACE PROCEDURE spAltaTesis(
      vIdMat IN tesis.idMaterial%TYPE,
      vAnioPublic IN tesis.anioPublic%TYPE,
      vCarrera IN tesis.carrera%TYPE,
      vIdDirector IN tesis.idDirector%TYPE
)

AS
BEGIN

      INSERT INTO tesis(idMaterial,idTesis,anioPublic, carrera, idDirector)
      VALUES (vIdMat, id_Tesis.nextval,vAnioPublic, vCarrera, vIdDirector);
END spAltaTesis;
/

SHOW ERRORS
