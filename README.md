# BD-Proyecto-Biblioteca
Proyecto de bases de datos para una biblioteca.

Se recomienda dedicar un esquema únicamente para este proyecto, por lo que la creación de un usuario con el cual crear las relaciones y realizar procedimientos de modificación de datos resulta lo más adecuado.

Instrucciones para la creación de usuario (NOTA: Antes se debe iniciar sesión en SQLPLUS con sys como DBA)


CREATE USER <user_name> IDENTIFIED BY <password>
QUOTA UNLIMITED ON USERS;


Se debe otorgar al usuario los privilegios necesarios


GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE TO <user_name>  


En dado caso de que se desee o necesite eliminar todas las tablas creadas, se puede emplear la siguiente instrucción para copiar el conjunto de comandos resultantes y pegarlos en la consola de SQLPLUS para que se ejecute:


SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;


Antes de ejecutar cualquier procedimiento, (y después de haber ejecutado el script 'proyecto_ddl'), se requiere haber ejecutado el script 'cargaTipoLect'


