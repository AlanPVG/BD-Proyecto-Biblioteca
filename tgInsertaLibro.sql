--Trigger que verifica que el material a introducir en la tabla libro sea un libro

CREATE OR REPLACE TRIGGER tgInsertaLibro
BEFORE INSERT ON tipoMaterial
FOR EACH ROW

DECLARE

      vTipoMat tipoMaterial.tipoMaterial%TYPE;

BEGIN

      SELECT tipoMaterial
      INTO vTipoMat
      FROM tipoMaterial
      WHERE idMaterial=:NEW.idMaterial;
      
      IF :NEW.tipoMat = 'libro' THEN
          INSERT INTO libro
          VALUES (:NEW.idMaterial,&numAdqui,&isbn,&edicion);
END tgInsertaLibro;
/
SHOW ERRORS
          
          
--          RAISE_APPLICATION_ERROR(-20021,'El material que se desea registrar como libro no es un libroc
