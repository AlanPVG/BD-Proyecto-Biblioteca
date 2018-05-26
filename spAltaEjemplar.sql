--Procedimiento para dar de alta un ejemplar


CREATE OR REPLACE PROCEDURE spAltaEjemplar(
	vIdMat ejemplar.idMaterial%TYPE,
	vEstatus ejemplar.estatus%TYPE
)


AS
BEGIN
	INSERT INTO ejemplar
	VALUES (vIdMat,num_Ejemplar.nextval,vEstatus);
	
	COMMIT;	

END spAltaEjemplar;
/
SHOW ERRORS
