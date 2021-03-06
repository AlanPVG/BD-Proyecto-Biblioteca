--Procedimiento para dar de alta un libro

CREATE OR REPLACE PROCEDURE spAltaLibro(
      vIdMaterial IN libro.idMaterial%TYPE,
      vISBN IN libro.isbn%TYPE,
      vEdicion IN libro.edicion%TYPE
)

AS
BEGIN

      INSERT INTO libro (idMaterial,numAdqui,isbn,edicion)
      VALUES (vIdMaterial, num_Adqui.nextval-1, vISBN, vEdicion);
      COMMIT;

END spAltaLibro;
/
SHOW ERRORS
