--Disparador que valida la CS#4: El número de préstamos concedidos no debe ser mayor al número de préstamos permitidos de acuerdo al tipo de lector.
--y la CS#5: La fecha de vencimiento depende del tipo de lector y de la fecha de préstamo.

CREATE OR REPLACE TRIGGER tgInsertaPrestamo
BEFORE INSERT ON prestamo
FOR EACH ROW

DECLARE

VEjemplaresPrestados NUMBER(2);
vTipo lector.tipoLect%TYPE;
vLimite tipoLector.limiteMaterial%TYPE;
vIdLect prestamo.idLector%TYPE;
vIdMat prestamo.idMaterial%TYPE;


BEGIN
	SELECT tipoLect
	INTO vTipo
	FROM lector
	WHERE idLector=:NEW.idLector;

	SELECT limiteMaterial
	INTO vLimite
	FROM tipoLector
	WHERE tipoLect=vTipo;	


	SELECT COUNT(*)
	INTO vEjemplaresPrestados
	FROM prestamo
	WHERE idLector=:NEW.idLector;		

	IF vTipo='estudiante' OR vTipo='profesor' OR vTipo='investigador' THEN
		IF vEjemplaresPrestados = vLimite THEN
			RAISE_APPLICATION_ERROR(-20005,'Solo se permiten '||vLimite||' prestamos como maximo para cada '||vTipo||'. El '||vTipo||' ya cuenta con el numero maximo de prestamos.');	
		END IF;
	END IF;
	

END tgInsertaPrestamo;
/
SHOW ERRORS

