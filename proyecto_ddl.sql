CREATE TABLE tipoLector(
	tipoLect VARCHAR2(15) PRIMARY KEY,
	limiteMaterial NUMBER(2) NOT NULL,
	refrendos NUMBER(1) NOT NULL,
	diasPrestamo NUMBER(2) NOT NULL
);

--===============================================================
--===============================================================

CREATE TABLE lector(
	idLector NUMBER(3) PRIMARY KEY,
	nomLect VARCHAR2(20) NOT NULL,
	apPatLect VARCHAR2(20) NOT NULL,
	apMatLect VARCHAR2(20),
	calle VARCHAR2(20) NOT NULL,
	numero NUMBER(4) NOT NULL,
	colonia VARCHAR2(30) NOT NULL,
	deleg VARCHAR2(20) NOT NULL,
	codPost NUMBER(5) NOT NULL,
	telefono NUMBER(10) NOT NULL,
	adeudo NUMBER(6) DEFAULT 0 NOT NULL,
	fechaAlta DATE DEFAULT SYSDATE NOT NULL,
	fechaVigencia DATE DEFAULT add_months(SYSDATE,12)-1 NOT NULL,
	tipoLect VARCHAR2(15) NOT NULL,
	CONSTRAINT FK_tipoLect FOREIGN KEY (tipoLect)
	REFERENCES tipoLector
);

--===============================================================
--===============================================================

CREATE TABLE material(
	idMaterial NUMBER(4) PRIMARY KEY,
	titulo VARCHAR2(40) NOT NULL,
	tema VARCHAR2(30) NOT NULL,
	coleccion VARCHAR2(20) NOT NULL,
	clasificacion VARCHAR2(20) NOT NULL
);

--===============================================================
--===============================================================

CREATE TABLE tipoMaterial(
	idMaterial NUMBER(4) PRIMARY KEY,
	tipoMaterial VARCHAR2(10) NOT NULL,
	CONSTRAINT FK_idMaterial FOREIGN KEY (idMaterial)
	REFERENCES material ON DELETE CASCADE
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
	
CREATE TABLE materialAutor(
	idMaterial NUMBER(4) NOT NULL,
	claveAutor NUMBER(3) NOT NULL,
	CONSTRAINT FK_idMaterial1 FOREIGN KEY (idMaterial)
	REFERENCES material,
	CONSTRAINT FK_claveAutor FOREIGN KEY (claveAutor)
	REFERENCES autor,
	CONSTRAINT PK_materialAutor PRIMARY KEY (idMaterial, claveAutor)
);

--===============================================================
--===============================================================

CREATE TABLE libro(
	idMaterial NUMBER(4) PRIMARY KEY,
	numAdqui NUMBER(4) NOT NULL,
	isbn NUMBER(13) NOT NULL,
	edicion NUMBER(2) NOT NULL,
	CONSTRAINT FK_idMaterial2 FOREIGN KEY (idMaterial)
	REFERENCES tipoMaterial ON DELETE CASCADE,
	CONSTRAINT AK_numAdqui UNIQUE(numAdqui),
	CONSTRAINT AK_isbn UNIQUE(isbn)
);

--===============================================================
--===============================================================

CREATE TABLE tesis(
	idMaterial NUMBER(4) PRIMARY KEY,
	idTesis NUMBER(3) NOT NULL,
	anioPublic NUMBER(4) NOT NULL,
	carrera VARCHAR2(30) NOT NULL,
	idDirector NUMBER(3) NOT NULL,
	CONSTRAINT FK_idMaterial3 FOREIGN KEY (idMaterial)
	REFERENCES tipoMaterial ON DELETE CASCADE,
	CONSTRAINT FK_idDirector FOREIGN KEY (idDirector)
	REFERENCES directorTesis,
	CONSTRAINT AK_idTesis UNIQUE(idTesis)
);

--===============================================================
--===============================================================

CREATE TABLE ejemplar(
	idMaterial NUMBER(4) NOT NULL,
	numEjemplar NUMBER(2) NOT NULL,
	estatus VARCHAR2(10) NOT NULL,
	CONSTRAINT CK_estatus CHECK (estatus IN('disponible','prestamo','no sale','mantenimiento')),
	CONSTRAINT FK_idMaterial4 FOREIGN KEY (idMaterial)
	REFERENCES material ON DELETE CASCADE,
	CONSTRAINT PK_ejemplar PRIMARY KEY(idMaterial, numEjemplar),
	CONSTRAINT AK_numEjemplar UNIQUE(numEjemplar)
);

--===============================================================
--===============================================================

CREATE TABLE prestamo(
	idLector NUMBER(3) NOT NULL,
	idMaterial NUMBER(4) NOT NULL,
	numEjemplar NUMBER(2) NOT NULL,
	fechaPrestamo DATE DEFAULT SYSDATE NOT NULL,
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
	monto NUMBER(5) NOT NULL,
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
	fechaMult DATE DEFAULT SYSDATE NOT NULL,
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
	fechaDevolucion DATE DEFAULT SYSDATE NOT NULL,
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

CREATE SEQUENCE num_Adqui
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE id_tesis
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

 