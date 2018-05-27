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
      SELECT fechaPrestamo
      INTO vFechaPrest
      FROM prestamo
      WHERE idLector = :OLD.idLector
      AND idMaterial = :OLD.idMaterial
      AND numEjemplar = :OLD.numEjemplar;
      
      SELECT fechaDevolucion
      INTO vFechaDev
      FROM devuelveEjem
      WHERE idLector = :OLD.idLector
      AND idMaterial = :OLD.idMaterial
      AND numEjemplar = :OLD.numEjemplar;
      
      vMonto := 0;
      vDiasAtraso := 0;
      
      UPDATE ejemplar
      SET estatus = 'disponible'
      WHERE idMaterial = :OLD.idMaterial
      AND numEjemplar = :OLD.numEjemplar;
      
      IF vFechaDev > vFechaPrest THEN
            WHILE vFechaPrest < vFechaDev LOOP
                  vMonto:=vMonto+10;
                  vDiasAtraso := vDiasAtraso+1;
                  vFechaPrest := vFechaPrest+1;
            END LOOP;
            INSERT INTO multa (idMulta, idMaterial, numEjemplar, diasAtraso, monto, liquidado)
            VALUES (id_Multa.nextval, :OLD.idMaterial, :OLD.numEjemplar, vDiasAtraso, vMonto,'no');
      END IF;
END tgMulta;
/
SHOW ERRORS
      
