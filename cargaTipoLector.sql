--Inserción de tipos de lector en la tabla tipoLector, con sus correspondientes limites de material, dias de
--prestamo autorizados y numero de refrendos autorizados.
---------------

INSERT INTO tipoLector(tipoLect,limiteMaterial,diasPrestamo,refrendos)
VALUES('estudiante',3,8,1);

INSERT INTO tipoLector(tipoLect,limiteMaterial,diasPrestamo,refrendos)
VALUES('profesor',5,15,2);

INSERT INTO tipoLector(tipoLect,limiteMaterial,diasPrestamo,refrendos)
VALUES('investigador',10,30,3);

COMMIT;
