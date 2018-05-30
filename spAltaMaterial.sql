--Procedimiento de alta en la relacion MATERIAL

CREATE OR REPLACE PROCEDURE spAltaMaterial(

	vTipoMat IN tipoMaterial.tipoMaterial%TYPE,
	vTitulo IN material.titulo%TYPE,
	vTema IN material.tema%TYPE,
	vColeccion IN material.coleccion%TYPE,
	vClasificacion IN material.clasificacion%TYPE
)

AS
	vIdMaterial NUMBER(4) := id_Material.nextval;
BEGIN
	INSERT INTO material
	VALUES(vIdMaterial,vTitulo,vTema,vColeccion,vClasificacion);

	INSERT INTO tipoMaterial
	VALUES(vIdMaterial,vTipoMat);

	COMMIT;

END spAltaMaterial;
/
SHOW ERRORS
