--Procedimiento para la realización de un prestamo

CREATE OR REPLACE PROCEDURE spPrestamo(
	vIdLect prestamo.idLector%TYPE,
	vIdMat prestamo.idMaterial%TYPE,
	vNumEjemp prestamo.numEjemplar%TYPE,
	vFechaPrest DATE
)
AS 
	vNumPrest NUMBER(2);
	vTipo tipoLector.tipoLect%TYPE;
	vRef tipoLector.refrendos%TYPE;
	vFVencimiento DATE;
	vDiasPrestamo tipoLector.diasPrestamo%TYPE;
	VNumRef NUMBER;
	vEstatus ejemplar.estatus%TYPE;
	vFVenc DATE;
	vAdeudo lector.adeudo%TYPE;
BEGIN

	SELECT tipoLect
	INTO vTipo
	FROM lector
	WHERE idLector=vIdLect;

	SELECT refrendos
	INTO vRef
	FROM tipoLector
	WHERE tipoLect=vTipo;

	SELECT diasPrestamo
	INTO vDiasPrestamo
	FROM tipoLector
	WHERE tipoLect=vTipo;

	SELECT(vFechaPrest+vDiasPrestamo)
	INTO vFVencimiento
	FROM DUAL;
	
	SELECT COUNT(*)
	INTO vNumPrest
	FROM prestamo
	WHERE idLector=vIdLect
	AND idMaterial=vIdMat
	AND numEjemplar=vNumEjemp;

	SELECT estatus
	INTO vEstatus
	FROM ejemplar
	WHERE idMaterial=vIdMat
	AND numEjemplar=vNumEjemp;
	
	SELECT adeudo
	INTO vAdeudo
	FROM lector
	WHERE idLector=vIdLect;


	IF vAdeudo > 0 THEN
		RAISE_APPLICATION_ERROR(-20026,'El lector con identificador '||vIdLect||' no puede sacar materiales debido a que cuenta con multas sin pagar');
	
	ELSE
		IF vNumPrest=0 AND vEstatus = 'disponible' THEN
			INSERT INTO prestamo
			VALUES(vIdLect,vIdMat,vNumEjemp,vFechaPrest,vFVencimiento,vNumPrest);
			
			UPDATE ejemplar
			SET estatus='prestamo'
			WHERE idMaterial=vIdMat
			AND numEjemplar=vNumEjemp;

		ELSIF vNumPrest=0 AND vEstatus != 'disponible' THEN
			RAISE_APPLICATION_ERROR(-20020,'Ejemplar no disponible para prestamo. Estatus: '||vEstatus);

		ELSIF vNumPrest != 0 THEN
			SELECT numrefrendos
			INTO VNumRef
			FROM prestamo
			WHERE idLector=vIdLect
			AND idMaterial=vIdMat
			AND numEjemplar=vNumEjemp;
		
			SELECT fechaVencimiento
			INTO vFVenc
			FROM prestamo
			WHERE idLector=vIdLect
			AND idMaterial=vIdMat
			AND numEjemplar=vNumEjemp;
		
			IF vFVenc = vFechaPrest THEN
				IF vNumRef < vRef  THEN
					UPDATE prestamo
					SET fechaPrestamo=vFechaPrest, fechaVencimiento=vFVencimiento, numRefrendos=numRefrendos+1
					WHERE idLector=vIdLect
					AND idMaterial=vIdMat
					AND numEjemplar=vNumEjemp;
				ELSE
					RAISE_APPLICATION_ERROR(-20010,'Solo se permiten '||vRef||' refrendos por ejemplar como maximo para cada '||vTipo||'. El '||vTipo||' ya cuenta con el numero maximo de refrendos para el ejemplar con ID '||vNumEjemp||' del material con ID '||vIdMat);	
				END IF;
			
			ELSIF vFVenc > vFechaPrest THEN
				RAISE_APPLICATION_ERROR(-20025,'No se pueden realizar refrendos antes de la fecha de vencimiento del prestamo en curso. Se podra refrendar el material hasta '||vFVenc);	
			END IF;
		END IF;
	END IF;
		COMMIT;

END spPrestamo;
/
SHOW ERRORS
	
