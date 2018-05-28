--Trigger que genera multas en caso de ser necesario, al realizar la devolucion de un material en prestamo
CREATE OR REPLACE FUNCTION ftDiasAtraso(
	vIdLect IN prestamo.idLector%TYPE,
	vIdMat IN prestamo.idMaterial%TYPE,
	vNumEjemp IN prestamo.numEjemplar%TYPE)

RETURN NUMBER
IS
	
	vFechaPrest prestamo.fechaPrestamo%TYPE;
      	vFechaDev devuelveEjem.fechaDevolucion%TYPE;
	vDiasAtraso NUMBER;
BEGIN
      	SELECT fechaPrestamo
      	INTO vFechaPrest
      	FROM prestamo
      	WHERE idLector = vIdLect
      	AND idMaterial = vIdMat
      	AND numEjemplar = vNumEjemp;
      
      	SELECT fechaDevolucion
      	INTO vFechaDev
      	FROM devuelveEjem
      	WHERE idLector = vIdLect
      	AND idMaterial = vIdMat
      	AND numEjemplar = vNumEjemp;

	SELECT (vFechaPrest - vFechaDev)
	INTO vDiasAtraso
	FROM DUAL;
	
	RETURN(vDiasAtraso);
END ftDiasAtraso;
/
SHOW ERRORS




CREATE OR REPLACE TRIGGER tgMulta
BEFORE DELETE ON prestamo
FOR EACH ROW

DECLARE

      vFechaPrest prestamo.fechaPrestamo%TYPE;
      vFechaDev devuelveEjem.fechaDevolucion%TYPE;
      vMonto NUMBER;
      vDiasAtraso NUMBER;
BEGIN
      vDiasAtraso:=ftDiasAtraso(:OLD.idLector,:OLD.idMaterial,:OLD.numEjemplar);
      vMonto := vDiasAtraso*10;
      
      UPDATE ejemplar
      SET estatus = 'disponible'
      WHERE idMaterial = :OLD.idMaterial
      AND numEjemplar = :OLD.numEjemplar;

            INSERT INTO multa (idMulta, idMaterial, numEjemplar, diasAtraso, monto, liquidado)
            VALUES (id_Multa.nextval, :OLD.idMaterial, :OLD.numEjemplar, vDiasAtraso, vMonto,'no');

END tgMulta;
/
SHOW ERRORS
      
