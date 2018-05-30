--Procedimiento para dar de alta un ejemplar


CREATE OR REPLACE PROCEDURE spAltaEjemplar(
	vIdMat ejemplar.idMaterial%TYPE,
	vNumEjemp ejemplar.numEjemplar%TYPE,
	vEstatus ejemplar.estatus%TYPE
)


AS
BEGIN
	INSERT INTO ejemplar
	VALUES (vIdMat,vNumEjemp,vEstatus);
	
	COMMIT;	

END spAltaEjemplar;
/
SHOW ERRORS
