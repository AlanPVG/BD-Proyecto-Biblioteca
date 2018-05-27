--Procedimiento para dar de alta un libro

CREATE OR REPLACE PROCEDURE spAltaLibro(
      vIdMaterial IN libro.idMaterial%TYPE,
      vNumAdqui IN libro.numAdqui%TYPE,
      vISBN IN libro.isbn%TYPE,
      vEdicion IN libro.edicion%TYPE
)

AS
BEGIN

      INSERT INTO libro
      VALUES (vIdMaterial, vNumAdqui, vISBN, vEdicion);

END spAltaLibro;
/
SHOW ERRORS
