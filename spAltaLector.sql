--Procedimiento de alta en la relacion LECTOR

CREATE OR REPLACE PROCEDURE spAltaLector(
	
	vIdLector IN lector.idLector%TYPE,
	vNomLect IN lector.nomLect%TYPE,
	vApPatLect IN lector.apPatLect%TYPE,
	vApMatLect IN lector.apMatLect%TYPE,
	vCalle IN lector.calle%TYPE,
	vCalleNum IN lector.calleNum%TYPE,
	vColonia IN lector.colonia%TYPE,
	vDeleg IN lector.deleg%TYPE,
	vCodPost IN lector.codPost%TYPE,
	vTelefono IN lector.telefono%TYPE,
	vTipoLect IN lector.tipoLect%TYPE
)

AS
BEGIN
	INSERT INTO lector(idLector, nomLect, apPatLect, apMatLect, calle, calleNum, colonia, deleg,codPost,telefono,tipoLect)
	VALUES(vIdLector,vNomLect,vApPatLect,vApMatLect,vCalle,	vCalleNum,vColonia,vDeleg,vCodPost,vTelefono,vTipoLect);

END spAltaLector;
/
SHOW ERRORS

