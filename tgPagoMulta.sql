
CREATE OR REPLACE TRIGGER tgPagoMulta
BEFORE UPDATE OF monto ON multa
FOR EACH ROW

DECLARE
      vCambio NUMBER;
  
BEGIN
      
      IF (:NEW.monto < 0) OR (:NEW.monto = 0) THEN
                 UPDATE multa
                 SET liquidado = 'si'
                 WHERE idMulta = :OLD.idMulta;
                 
                 vCambio : = 0 - :NEW.monto;
                 DBMS_OUTPUT.PUT_LINE('Cambio = '||vCambio);
      
      END IF;
END tgPagoMulta;
/
SHOW ERRORS
