--Procedimiento para asignar materiales a un autor de los registrados en la base de datos.

CREATE OR REPLACE PROCEDURE spMaterialAutor(
    vIdMat IN materialAutor.idMaterial%TYPE,
    vClvAutor IN materialAutor.claveAutor%TYPE
)

AS
BEGIN

    INSERT INTO materialAutor(idMaterial,claveAutor)
    VALUES (vIdMat,vClvAutor);
    
    COMMIT;

END spMaterialAutor;
/
SHOW ERRORS
