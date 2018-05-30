--Procedimiento para realizar pago de una multa

CREATE OR REPLACE PROCEDURE spPagoMulta(
      vIdMulta IN multa.idMulta%TYPE,
      vPago IN NUMBER
)

AS
      vMonto multa.monto%TYPE;

BEGIN

    SELECT monto
    INTO vMonto
    FROM multa
    WHERE idMulta=vIdMulta;
    
    UPDATE multa
    SET monto = vMonto - vPago
    WHERE idMulta = vIdMulta;
    
END spPagoMulta;
/
SHOW ERRORS
