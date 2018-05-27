--Trigger que verifica que el material a insertar en la relacion libro sea un libro

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
          RAISE_APPLICATION_ERROR(-20021,'El material que desea registrar no es un libro');
      END IF;
END tgInsertaLibro;
/
SHOW ERRORS
