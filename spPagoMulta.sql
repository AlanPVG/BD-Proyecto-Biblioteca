--Procedimiento para realizar pago de una multa

CREATE OR REPLACE PROCEDURE spPagoMulta(
      vIdMulta IN multa.idMulta%TYPE,
      vPago IN NUMBER
)

AS
      vMonto multa.monto%TYPE;
      vCambio NUMBER;
BEGIN

    SELECT monto
    INTO vMonto
    FROM multa
    WHERE idMulta=vIdMulta;
    
    IF vPago < vMonto THEN
            UPDATE multa
            SET monto = vMonto - vPago
            WHERE idMulta = vIdMulta;
            
    ELSIF vPago = vMonto THEN
            UPDATE multa
            SET monto = vMonto - vPago, liquidado ='si'
            WHERE idMulta = vIdMulta;
            
    ELSIF vPago > vMonto THEN
           UPDATE multa
           SET monto = 0
           WHERE idMulta = vIdMulta;
           
           vCambio := vPago-vMonto;
           DBMS_OUTPUT.PUT_LINE('Cambio = '||vCambio);
    END IF;
    
    COMMIT;
END spPagoMulta;
/
SHOW ERRORS
