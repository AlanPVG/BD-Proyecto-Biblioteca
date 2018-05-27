--Trigger que verifica que el material a introducir en la tabla libro sea un libro

CREATE OR REPLACE TRIGGER tgInsertaLibro
BEFORE INSERT ON libro
FOR EACH ROW

DECLARE

      vTipoMat tipoMaterial.tipoMaterial%TYPE;

BEGIN

      SELECT tipoMaterial
      INTO vTipoMat
      FROM tipoMaterial
      WHERE idMaterial=:NEW.idMaterial;
      
      IF vTipoMat != 'libro' THEN
          RAISE_APPLICATION_ERROR(-20021,'El material que se desea registrar como libro no es un libroc
