--Procedimiento para asignar libros a un autor de los registrados en la base de datos.

CREATE OR REPLACE PROCEDURE spLibroAutor(
    vIdMat IN libroAutor.idMaterial%TYPE,
    vClvAutor IN libroAutor.claveAutor%TYPE
)

AS
BEGIN

    INSERT INTO libroAutor(idMaterial,claveAutor)
    VALUES (vIdMat,vClvAutor);

END spLibroAutor;
/
SHOW ERRORS
