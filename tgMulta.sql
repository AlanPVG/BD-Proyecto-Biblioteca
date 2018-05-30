--Trigger que genera multas en caso de ser necesario, al realizar la devolucion de un material en prestamo

CREATE OR REPLACE TRIGGER tgMulta
AFTER DELETE ON prestamo
FOR EACH ROW

DECLARE

      vFechaDev devuelveEjem.fechaDevolucion%TYPE;
      vMonto NUMBER;
      vDiasAtraso NUMBER;
BEGIN
      
      	SELECT fechaDevolucion
      	INTO vFechaDev
      	FROM devuelveEjem
      	WHERE idLector = :OLD.idLector
      	AND idMaterial = :OLD.idMaterial
      	AND numEjemplar = :OLD.numEjemplar;

      
 	UPDATE ejemplar
   	SET estatus = 'disponible'
    	WHERE idMaterial = :OLD.idMaterial
      	AND numEjemplar = :OLD.numEjemplar;

	IF :OLD.fechaVencimiento < vFechaDev THEN
	
		vDiasAtraso:=CEIL((vFechaDev - :OLD.fechaVencimiento));
	
      		vMonto := vDiasAtraso*10;
		
      	    	INSERT INTO multa (idMulta, idLector, idMaterial, numEjemplar, diasAtraso, fechaMult, monto, liquidado)
            	VALUES (id_Multa.nextval, :OLD.idLector, :OLD.idMaterial, :OLD.numEjemplar, vDiasAtraso, vFechaDev, vMonto,'no');
		
		UPDATE lector
		SET adeudo = vMonto
		WHERE idLector = :OLD.idLector;
		
	END IF;
	COMMIT;
END tgMulta;
/
SHOW ERRORS
      
