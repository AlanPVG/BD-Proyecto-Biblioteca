--Procedimiento de alta en la relacion LECTOR

CREATE OR REPLACE PROCEDURE spAltaLector(
	
	vNomLect IN lector.nomLect%TYPE,
	vApPatLect IN lector.apPatLect%TYPE,
	vApMatLect IN lector.apMatLect%TYPE,
	vCalle IN lector.calle%TYPE,
	vNumero IN lector.numero%TYPE,
	vColonia IN lector.colonia%TYPE,
	vDeleg IN lector.deleg%TYPE,
	vCodPost IN lector.codPost%TYPE,
	vTelefono IN lector.telefono%TYPE,
	vTipoLect IN lector.tipoLect%TYPE
)

AS
BEGIN
	INSERT INTO lector(idLector, nomLect, apPatLect, apMatLect, calle, numero, colonia, deleg,codPost,telefono,tipoLect)
	VALUES(id_Lector.nextval,vNomLect,vApPatLect,vApMatLect,vCalle,	vNumero,vColonia,vDeleg,vCodPost,vTelefono,vTipoLect);

END spAltaLector;
/
SHOW ERRORS

