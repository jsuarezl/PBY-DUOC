-- Listar todos los paises de Americas

SELECT COUNTRY_NAME FROM HR.COUNTRIES WHERE REGION_ID = (SELECT REGION_ID FROM HR.REGIONS WHERE REGION_NAME = 'Americas');

-- Crear un listado que contenga el nombre del departamento y el total de los empleados
SELECT department_name, count(employee_id) FROM HR.DEPARTMENTS JOIN HR.EMPLOYEES on departments.department_id = employees.department_id GROUP BY department_name ORDER BY department_name ASC;

-- Usando anonymous blocks
-- Se altera el formato de fecha de la sesión para usar un formato conocido
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
-- Se definen variables con su nombre y tipo, este proceso es opcional
-- Para definir un valor por defecto a la variable se utiliza :=
-- También es posible hacerlo utilizando 'DEFAULT <value>'
DECLARE
SALIDA VARCHAR(80);
    ENTRADA INT := 100;
    fecha date := '2000-11-17';
    edad real;
-- Se comienza la ejecución del bloque anónimo, dentro de este se puede ejecutar cualquier Query
BEGIN
SELECT FIRST_NAME INTO SALIDA FROM EMPLOYEES WHERE EMPLOYEE_ID = ENTRADA;
-- El comando DBMS_OUTPUT.PUT_LINE es un comando de pl/sql, su función es enviar un mensaje a la base de datos
DBMS_OUTPUT.PUT_LINE('el primer nombre del empleado ' || ENTRADA || ' es ' || SALIDA);
SELECT ROUND((sysdate-fecha)/365.25,2) into edad from dual;
DBMS_OUTPUT.PUT_LINE('la edad de jaime es ' || edad);
END;
DECLARE
entrada VARCHAR(80) := 'France';
    region VARCHAR(80);
BEGIN
SELECT REGION_NAME into region FROM REGIONS JOIN COUNTRIES USING(REGION_ID) WHERE COUNTRY_NAME = entrada;
DBMS_OUTPUT.PUT_LINE('el continente de ' || entrada || ' es ' || region);
END;
DECLARE
entrada VARCHAR(80) := 'France';
    region VARCHAR(80);
BEGIN
SELECT REGION_NAME into region FROM REGIONS JOIN COUNTRIES C2 on REGIONS.REGION_ID = C2.REGION_ID WHERE COUNTRY_NAME = entrada;
DBMS_OUTPUT.PUT_LINE('el continente de ' || entrada || ' es ' || region);
END;