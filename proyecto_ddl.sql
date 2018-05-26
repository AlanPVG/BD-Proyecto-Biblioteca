CREATE TABLE tipoLector(
	tipoLect VARCHAR2(15) PRIMARY KEY,
	CONSTRAINT CK_tipoLect CHECK (tipoLect IN ('estudiante','profesor','investigador')),
	limiteMaterial NUMBER(2) NOT NULL,
	refrendos NUMBER(2) NOT NULL,
	diasPrestamo NUMBER(2) NOT NULL
);

--===============================================================
--===============================================================

CREATE TABLE lector(
	idLector NUMBER(3) PRIMARY KEY,
	nomLect VARCHAR2(15) NOT NULL,
	apPatLect VARCHAR2(15) NOT NULL,
	apMatLect VARCHAR2(15),
	calle VARCHAR(20) NOT NULL,
	calleNum NUMBER(4) NOT NULL,
	colonia VARCHAR2(15) NOT NULL,
	deleg VARCHAR2(15) NOT NULL,
	codPost NUMBER(5) NOT NULL,
	telefono NUMBER(10) NOT NULL,
	adeudo NUMBER,
	fechaAlta DATE DEFAULT SYSDATE,
	fechaVigencia DATE DEFAULT add_months(SYSDATE,12)-1,
	tipoLect VARCHAR2(15) NOT NULL,
	CONSTRAINT FK_tipoLect FOREIGN KEY (tipoLect)
	REFERENCES tipoLector
);


--===============================================================
--===============================================================

CREATE TABLE material(
	idMaterial NUMBER(4) PRIMARY KEY,
	titulo VARCHAR2(20) NOT NULL,
	tema VARCHAR2(20) NOT NULL,
	coleccion VARCHAR2(20) NOT NULL,
	clasificacion VARCHAR2(20) NOT NULL
);

--===============================================================
--===============================================================

CREATE TABLE tipoMaterial(
	idMaterial NUMBER(4) PRIMARY KEY,
	tipoMaterial VARCHAR2(10) NOT NULL,
	CONSTRAINT FK_idMaterial FOREIGN KEY (idMaterial)
	REFERENCES material ON DELETE CASCADE,
	CONSTRAINT CK_tipoMaterial CHECK (tipoMaterial IN ('libro','tesis'))
);

--===============================================================
--===============================================================

CREATE TABLE autor(
	claveAutor NUMBER(3) PRIMARY KEY,
	nomAutor VARCHAR2(15) NOT NULL,
	apPatAutor VARCHAR2(15) NOT NULL,
	apMatAutor VARCHAR2(15),
	nacionalidad VARCHAR2(40) NOT NULL
);

--===============================================================
--===============================================================

CREATE TABLE directorTesis(
	idDirector NUMBER(3) PRIMARY KEY,
	nomDirect VARCHAR2(15) NOT NULL,
	apPatDirect VARCHAR2(15) NOT NULL,
	apMatDirect VARCHAR2(15),
	gradoAcad VARCHAR2(10) NOT NULL
);

--===============================================================
--===============================================================
	
CREATE TABLE libroAutor(
	idMaterial NUMBER(4) NOT NULL,
	claveAutor NUMBER(3) NOT NULL,
	CONSTRAINT FK_idMaterial1 FOREIGN KEY (idMaterial)
	REFERENCES material,
	CONSTRAINT FK_claveAutor FOREIGN KEY (claveAutor)
	REFERENCES autor,
	CONSTRAINT PK_libroAutor PRIMARY KEY (idMaterial, claveAutor)
);

--===============================================================
--===============================================================

CREATE TABLE libro(
	idMaterial NUMBER(4) PRIMARY KEY,
	numAdqui NUMBER(4) UNIQUE,
	isbn NUMBER(13) NOT NULL,
	edicion NUMBER(2) NOT NULL,
	CONSTRAINT FK_idMaterial2 FOREIGN KEY (idMaterial)
	REFERENCES material ON DELETE CASCADE
);

--===============================================================
--===============================================================

CREATE TABLE tesis(
	idMaterial NUMBER(4) PRIMARY KEY,
	idTesis NUMBER(3) UNIQUE,
	anioPublic NUMBER(4),
	carrera VARCHAR2(30) NOT NULL,
	idDirector NUMBER(3) NOT NULL,
	CONSTRAINT FK_idMaterial3 FOREIGN KEY (idMaterial)
	REFERENCES material ON DELETE CASCADE,
	CONSTRAINT FK_idDirector FOREIGN KEY (idDirector)
	REFERENCES directorTesis
);

--===============================================================
--===============================================================

CREATE TABLE ejemplar(
	idMaterial NUMBER(4) NOT NULL,
	numEjemplar NUMBER(2) UNIQUE,
	estatus VARCHAR2(10) NOT NULL,
	CONSTRAINT CK_estatus CHECK (estatus IN('disponible','prestamo','no sale','mantenimiento')),
	CONSTRAINT FK_idMaterial4 FOREIGN KEY (idMaterial)
	REFERENCES material ON DELETE CASCADE,
	CONSTRAINT PK_ejemplar PRIMARY KEY(idMaterial, numEjemplar)
);

--===============================================================
--===============================================================

CREATE TABLE prestamo(
	idLector NUMBER(3) NOT NULL,
	idMaterial NUMBER(4) NOT NULL,
	numEjemplar NUMBER(2) NOT NULL,
	fechaPrestamo DATE DEFAULT SYSDATE,
	fechaVencimiento DATE,	
	numRefrendos NUMBER(1) NOT NULL,
	CONSTRAINT FK_idLector FOREIGN KEY (idLector)
	REFERENCES lector ON DELETE CASCADE,
	CONSTRAINT FK_MatEjem FOREIGN KEY (idMaterial, numEjemplar)
	REFERENCES ejemplar,
	CONSTRAINT PK_prestamo PRIMARY KEY (idLector, idMaterial, numEjemplar)
);

--===============================================================
--===============================================================

CREATE TABLE multa(
	idMulta NUMBER(2) PRIMARY KEY,
	diasAtraso NUMBER(3) NOT NULL,
	monto NUMBER(6,2) NOT NULL,
	liquidado CHAR(2) NOT NULL,
	idMaterial NUMBER(4) NOT NULL,
	numEjemplar NUMBER(2) NOT NULL,
	CONSTRAINT FK_MatEjem1 FOREIGN KEY (idMaterial, numEjemplar)
	REFERENCES ejemplar,
	CONSTRAINT CK_liquidado CHECK (liquidado IN('si','no'))
);

--===============================================================
--===============================================================

CREATE TABLE adquiereMulta(
	idLector NUMBER(3) NOT NULL,
	idMulta NUMBER(2) NOT NULL,
	fechaMult DATE NOT NULL,
	CONSTRAINT FK_idLector1 FOREIGN KEY (idLector)
	REFERENCES lector,
	CONSTRAINT FK_idMulta FOREIGN KEY (idMulta)
	REFERENCES multa,
	CONSTRAINT PK_adquiereMult PRIMARY KEY (idLector, idMulta)
);

--===============================================================
--===============================================================

CREATE TABLE devuelveEjem(
	idLector NUMBER(3) NOT NULL,
	idMaterial NUMBER(4) NOT NULL,
	numEjemplar NUMBER(2) NOT NULL,
	fechaDevolucion DATE NOT NULL,
	CONSTRAINT FK_idLector2 FOREIGN KEY (idLector)
	REFERENCES lector,
	CONSTRAINT FK_MatEjem2 FOREIGN KEY (idMaterial, numEjemplar)
	REFERENCES ejemplar,
	CONSTRAINT PK_devEjem PRIMARY KEY (idLector, idMaterial, numEjemplar)
);


--===============================================================
--===============================================================

--
--SECUENCIAS
--
----------------------------------

CREATE SEQUENCE id_Lector
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE id_Material
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE clv_Autor
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE id_Director
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE id_Multa
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE num_Ejemplar
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;