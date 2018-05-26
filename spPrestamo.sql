--Procedimiento para la realización de un prestamo

CREATE OR REPLACE PROCEDURE spPrestamo(
	vIdLect prestamo.idLector%TYPE,
	vIdMat prestamo.idMaterial%TYPE,
	vNumEjemp prestamo.numEjemplar%TYPE
)
AS 
	vNumPrest NUMBER(2);
	vTipo tipoLector.tipoLect%TYPE;
	vRef tipoLector.refrendos%TYPE;
	vFVencimiento DATE;
	vDiasPrestamo tipoLector.diasPrestamo%TYPE;
	VNumRef NUMBER;
	vEstatus ejemplar.estatus%TYPE;
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

	SELECT(SYSDATE+vDiasPrestamo)
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

	IF vNumPrest=0 AND vEstatus = 'disponible' THEN
		INSERT INTO prestamo
		VALUES(vIdLect,vIdMat,vNumEjemp,SYSDATE,vFVencimiento,vNumPrest);
		
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
		
		IF vNumRef < vRef THEN
			UPDATE prestamo
			SET fechaPrestamo=SYSDATE, fechaVencimiento=vFVencimiento, numRefrendos=numRefrendos+1
			WHERE idLector=vIdLect
			AND idMaterial=vIdMat
			AND numEjemplar=vNumEjemp;
		ELSE
			RAISE_APPLICATION_ERROR(-20010,'Solo se permiten '||vRef||' refrendos por ejemplar como maximo para cada '||vTipo||'. El '||vTipo||' ya cuenta con el numero maximo de refrendos para el ejemplar con ID '||vNumEjemp||' del material con ID '||vIdMat);	
		END IF;
	END IF;

	COMMIT;

END spPrestamo;
/
SHOW ERRORS
	
