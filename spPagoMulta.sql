--Procedimiento para realizar pago de una multa

CREATE OR REPLACE PROCEDURE spPagoMulta(
      vIdMulta IN multa.idMulta%TYPE,
      vPago IN NUMBER
)

AS
      vMonto multa.monto%TYPE;
      vCambio NUMBER;
      vIdLect lector.idLector%TYPE;
BEGIN

    SELECT monto
    INTO vMonto
    FROM multa
    WHERE idMulta=vIdMulta;
    
    SELECT l.idLector
    INTO vIdLect
    FROM lector l
    JOIN multa m
    ON l.idLector = m.idLector
    WHERE idMulta = vIdMulta;
    
    IF vPago < vMonto THEN
            UPDATE multa
            SET monto = vMonto - vPago
            WHERE idMulta = vIdMulta;
            
            UPDATE lector
            SET adeudo = vMonto - vPago
            WHERE idLector=vIdLect;
            
    ELSIF vPago = vMonto THEN
            UPDATE multa
            SET monto = vMonto - vPago, liquidado = 'si'
            WHERE idMulta = vIdMulta;
            
            UPDATE lector
            SET adeudo = 0
            WHERE idLector=vIdLect;
            
    ELSIF vPago > vMonto THEN
           UPDATE multa
           SET monto = 0, liquidado = 'si'
           WHERE idMulta = vIdMulta;
           
           UPDATE lector
           SET adeudo = 0
           WHERE idLector=vIdLect;
           
           vCambio := vPago-vMonto;
           DBMS_OUTPUT.PUT_LINE('Cambio = '||vCambio);
    END IF;
    
    COMMIT;
END spPagoMulta;
/
SHOW ERRORS
