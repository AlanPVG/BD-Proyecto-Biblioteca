--===============================================================
--===============================================================

--
--ELIMINACION Y CREACION DE USUARIO
--
----------------------------------
CLEAR SCREEN;

CONNECT system/oracle;


DROP USER proyecto CASCADE;

CREATE USER proyecto IDENTIFIED BY proyecto QUOTA UNLIMITED ON USERS;
GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE VIEW, CREATE ANY INDEX TO proyecto;

CONNECT proyecto/proyecto;
--===============================================================
--===============================================================


--TABLAS Y SECUENCIAS
@@PROYECTO_DDL.SQL


--PROCEDIMIENTOS
@@spAltaLector.sql
@@spAltaAutor.sql
@@spAltaMaterial.sql
@@spAltaLibro.sql


@@spAltaDirTesis.sql
@@spAltaEjemplar.sql


@@spAltaTesis.sql
@@spDevolucion.sql
@@spMaterialAutor.sql
@@spPagoMulta.sql
@@spPrestamo.sql

--TRIGGERS
@@tgInsertaLibro.sql
@@tgInsertaTesis.sql
@@tgInsertaPrestamo.sql
@@tgMulta.sql

--Carga de datos
@@cargaTipoLector.sql
@@cargaDatosLectores.sql
@@cargaDatosAutores.sql
@@cargaDatosMaterial.sql
@@cargaDatosMaterialAutor.sql
@@cargaDatosLibros.sql