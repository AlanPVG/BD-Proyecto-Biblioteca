CREATE OR REPLACE TRIGGER tgFechaRefrendo
BEFORE INSERT ON prestamo
FOR EACH ROW

DECLARE
      vNumPrest NUMBER(2);
      vTipo tipoLector.tipoLect%TYPE;
      vRef tipoLector.refrendos%TYPE;
      vFVencimiento DATE;
      
      
BEGIN
      SELECT COUNT(*)
	    INTO vNumPrest
	    FROM prestamo
	    WHERE idLector=:NEW.idLector
	    AND idMaterial=:NEW.idMaterial
	    AND numEjemplar=:NEW.numEjemplar;
     
     	SELECT tipoLect
	    INTO vTipo
	    FROM lector
	    WHERE idLector= :NEW.idLector;
     
     
	    SELECT refrendos
	    INTO vRef
	    FROM tipoLector
	    WHERE tipoLect=vTipo;
      
      SELECT diasPrestamo
	    INTO vDiasPrestamo
	    FROM tipoLector
	    WHERE tipoLect=vTipo;
   
      
      IF vNumPrest != 0 THEN
            IF :NEW.vFechaPrest < CEIL(vFechaPrest+vDiasPrestamo) THEN
                  RAISE_APPLICATION_ERROR(-20022,'No se puede refrendar antes de la fecha de vencimiento');
            END IF;
      END IF;
  END tgFechaRefrendo;
  /
  SHOW ERRORS
