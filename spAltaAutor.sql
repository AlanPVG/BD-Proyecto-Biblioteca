--Procedimiento para dar de alta un autor


CREATE OR REPLACE PROCEDURE spAltaAutor(
	vNomAutor IN autor.nomAutor%TYPE,
	vApPatAutor IN autor.apPatAutor%TYPE,
	vApMatAutor IN autor.apMatAutor%TYPE,
	vNacionalidad IN autor.nacionalidad%TYPE
)
AS
BEGIN
	INSERT INTO autor(claveAutor,nomAutor,apPatAutor,apMatAutor,nacionalidad)
	VALUES (clv_Autor.nextval,vNomAutor,vApPatAutor,vApMatAutor,vNacionalidad);
	
	COMMIT;

END spAltaAutor;
/
SHOW ERRORS
