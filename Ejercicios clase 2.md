# Clase 2 Programación de bases de datos

## Ejercicio 1:
Ejecutar una división y mostrar el resultado

```sql
declare
    entrada1 int := 17;
    entrada2 int := 3;
begin
    DBMS_OUTPUT.PUT_LINE('El resultado de dividir: ' || entrada1 || ' con ' || entrada2 || ' es: ' ||
                         ROUND(entrada1 / entrada2, 3));
end;
```

## Ejercicio 2:
Buscar empleado por su id y mostrar su id, nombre y departamento

```sql
CREATE TABLE RESPALDO2
(
    EMPLEADO_ID  INT,
    NOMBRE       VARCHAR(100),
    DEPARTAMENTO VARCHAR(100)
);

DECLARE
    ENTRADA      INT := 777;
    -- Cuando el tipo de dato es desconocido, se puede copiar desde una columna en una tabla ya existente, esto se realiza referenciando la tabla y la columna seguido del argumento '%TYPE'
    EMPLEADO_ID  EMPLOYEES.EMPLOYEE_ID %TYPE;
    NOMBRE       EMPLOYEES.FIRST_NAME %TYPE;
    DEPARTAMENTO DEPARTMENTS.DEPARTMENT_NAME %TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME
    INTO EMPLEADO_ID,NOMBRE,DEPARTAMENTO
    FROM EMPLOYEES
             JOIN DEPARTMENTS D ON EMPLOYEES.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = ENTRADA;
    INSERT INTO RESPALDO2 VALUES (EMPLEADO_ID, NOMBRE, DEPARTAMENTO);
    DBMS_OUTPUT.PUT_LINE('Vamos más que tiki taka');
    DBMS_OUTPUT.PUT_LINE(
                'El empleado con id ' || EMPLEADO_ID || ' se llama ' || NOMBRE || ' y trabaja en el departamento: ' ||
                DEPARTAMENTO);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe ningún empleado con id ' || ENTRADA);

END;

SELECT *
FROM RESPALDO2;
```

## Ejercicio 3:
Agregar una base de datos de respaldo al ejercicio 1 

```sql
create table respaldo(campo1 date, campo2 real);


declare
    entrada1 int := 17;
    entrada2 int := 3;
    valor3 real;
begin
    valor3 := round(entrada1/entrada2,3);
    insert into respaldo values (sysdate, valor3);
    DBMS_OUTPUT.PUT_LINE('Vamos tiki taka');
    DBMS_OUTPUT.PUT_LINE('El resultado de la división es: ' || valor3);
end;


select * from respaldo;
```

## Ejercicio 4:
Manejar errores dentro de un bloque anónimo
```sql
DECLARE
    ENTRADA  INT := 40;
    ENTRADA2 INT := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(ROUND(ENTRADA / ENTRADA2));
-- En este ejercicio se agrega la palabra reservada EXCEPTION, seguido de unos argumentos que permiten capturar un error y ejecutar una acción.
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('No se puede dividir por 0');

END;
```