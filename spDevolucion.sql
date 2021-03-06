--Procedimiento para la devolucion de un material en prestamo

CREATE OR REPLACE PROCEDURE spDevolucion(
      vIdMat IN prestamo.IdMaterial%TYPE,
      vNumEjemp IN prestamo.numEjemplar%TYPE,
      vFechaDev IN DATE     
)

AS
      vIdLect prestamo.idLector%TYPE;
BEGIN

      SELECT idLector
      INTO vIdLect
      FROM prestamo
      WHERE idMaterial = vIdMat
      AND numEjemplar = vNumEjemp;
      
      INSERT INTO devuelveEjem(idLector,idMaterial,numEjemplar,fechaDevolucion)
      VALUES(vIdLect, vIdMat, vNumEjemp, vFechaDev);
          
      DELETE FROM prestamo
      WHERE idMaterial = vIdMat
      AND numEjemplar = vNumEjemp;

      COMMIT;
      
END spDevolucion;
/
SHOW ERRORS
          
          
          
      
