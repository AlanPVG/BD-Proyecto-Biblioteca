--Trigger que genera multas en caso de ser necesario, al realizar la devolucion de un material en prestamo

CREATE OR REPLACE TRIGGER tgMulta
AFTER DELETE ON prestamo
FOR EACH ROW

DECLARE

      vFechaPrest prestamo.fechaPrestamo%TYPE;
      vFechaDev devuelveEjem.fechaDevolucion%TYPE;
      vMonto NUMBER;
      vDiasAtraso NUMBER;
BEGIN
      
      	SELECT fechaDevolucion
      	INTO vFechaDev
      	FROM devuelveEjem
      	WHERE idLector = vIdLect
      	AND idMaterial = vIdMat
      	AND numEjemplar = vNumEjemp;

	SELECT (:OLD.fechaPrestamo - vFechaDev)
	INTO vDiasAtraso
	FROM DUAL;
	
      vMonto := (:OLD.fechaPrestamo - vFechaDev)*10;
      
      UPDATE ejemplar
      SET estatus = 'disponible'
      WHERE idMaterial = :OLD.idMaterial
      AND numEjemplar = :OLD.numEjemplar;

            INSERT INTO multa (idMulta, idMaterial, numEjemplar, diasAtraso, monto, liquidado)
            VALUES (id_Multa.nextval, :OLD.idMaterial, :OLD.numEjemplar, vDiasAtraso, vMonto,'no');

END tgMulta;
/
SHOW ERRORS
      
