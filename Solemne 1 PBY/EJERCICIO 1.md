## Ejercicio 1
Creación de tabla para la parte A
```sql
CREATE TABLE RESPALDO1
(
    VENDEDOR VARCHAR2(30),
    TOTAL    REAL,
    COMISION REAL
);
```
Bloque PL/SQL
```sql
DECLARE
    V_MEDICAMENTO        MEDICAMENTOS.NOMBRE_MED%TYPE;
    V_CANTIDAD           INT := 0;
    V_ANIO_PROCESAMIENTO INT := 0;
BEGIN
    -- PARTE A
    INSERT INTO RESPALDO1(SELECT UPPER(NOM_VEN),
                                 SUM(MONTO_TOTAL),
                                 SUM(MONTO_TOTAL * .05)
                          FROM VENDEDORES
                                   JOIN BOLETAS B ON VENDEDORES.COD_VEN = B.VENDEDORES_COD_VEN
                          WHERE MONTO_TOTAL > 35000
                          GROUP BY NOM_VEN);

    -- PARTE B
    SELECT NOMBRE_MED, COUNT(MEDICAMENTOS_ID_MED) AS CANTIDAD
    INTO V_MEDICAMENTO, V_CANTIDAD
    FROM MEDICAMENTOS
             JOIN BOLETAS B2 ON MEDICAMENTOS.ID_MED = B2.MEDICAMENTOS_ID_MED
    HAVING COUNT(MEDICAMENTOS_ID_MED) = (SELECT MAX(CANTIDAD)
                                         FROM (SELECT COUNT(MEDICAMENTOS_ID_MED) AS CANTIDAD
                                               FROM BOLETAS
                                               GROUP BY MEDICAMENTOS_ID_MED))
    GROUP BY NOMBRE_MED
    ORDER BY CANTIDAD DESC;
    DBMS_OUTPUT.PUT_LINE('Medicamento más vendido: ' || UPPER(V_MEDICAMENTO));
    DBMS_OUTPUT.PUT_LINE('Cantidad de ventas: ' || V_CANTIDAD);
    DBMS_OUTPUT.PUT_LINE('Año de procesamiento: ' || EXTRACT(YEAR FROM SYSDATE)); -- TODO: revisar
END;
```
Comprobar parte A
```sql
SELECT VENDEDOR,
       TO_CHAR(TOTAL, 'L99,999.00', 'NLS_CURRENCY = ''$''')    AS TOTAL,
       TO_CHAR(COMISION, 'L99,999.00', 'NLS_CURRENCY = ''$''') AS COMISION
FROM RESPALDO1;

DELETE FROM RESPALDO1;
```