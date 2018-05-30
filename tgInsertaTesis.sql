--Trigger que verifica que el material a insertar en la relacion libro sea una tesis

CREATE OR REPLACE TRIGGER tgInsertaTesis
BEFORE INSERT ON tesis
FOR EACH ROW

DECLARE
vTipoMat tipoMaterial.tipoMaterial%TYPE;

BEGIN
      
      SELECT tipoMaterial
      INTO vTipoMat
      FROM tipoMaterial
      WHERE idMaterial=:NEW.idMaterial;

      IF vTipoMat != 'tesis' THEN
          RAISE_APPLICATION_ERROR(-20021,'El material que desea registrar no es una tesis');
      END IF;
END tgInsertaTesis;
/
SHOW ERRORS
