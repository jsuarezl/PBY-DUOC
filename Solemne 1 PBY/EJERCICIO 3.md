# Ejercicio 3

**Bloque pl/sql**
```sql
DECLARE
    V_SUCURSAL   VARCHAR2(50);
    V_FARMACIA   VARCHAR2(50);
    V_VENDEDORES NUMBER;
    V_COD_SUC    NUMBER := 3; -- Modificar a 100
BEGIN
    SELECT FRM.NOM_FAR FARMACIA, SUC.NOM_SUC SUCURSAL, COUNT(VND.COD_VEN) VENDEDORES
    INTO V_FARMACIA, V_SUCURSAL, V_VENDEDORES
    FROM SUCURSAL SUC
             JOIN VENDEDORES VND ON SUC.COD_SUC = VND.SUCURSAL_COD_SUC
             JOIN FARMACIA FRM ON SUC.FARMACIA_ID_FAR = FRM.ID_FAR
    WHERE COD_SUC = V_COD_SUC /* Eliminar where */
    GROUP BY FRM.NOM_FAR, SUC.NOM_SUC;
    FOR INICIO IN (
        SELECT FRM.NOM_FAR FARMACIA, SUC.NOM_SUC SUCURSAL, COUNT(VND.COD_VEN) VENDEDORES
        INTO V_FARMACIA, V_SUCURSAL, V_VENDEDORES
        FROM SUCURSAL SUC
                 JOIN VENDEDORES VND ON SUC.COD_SUC = VND.SUCURSAL_COD_SUC
                 JOIN FARMACIA FRM ON SUC.FARMACIA_ID_FAR = FRM.ID_FAR
        GROUP BY FRM.NOM_FAR, SUC.NOM_SUC)
        LOOP
            DBMS_OUTPUT.PUT_LINE('------------------------------');
            DBMS_OUTPUT.PUT_LINE('Farmacia: ' || UPPER(INICIO.FARMACIA));
            DBMS_OUTPUT.PUT_LINE('Sucursal: ' || INICIO.SUCURSAL);
            DBMS_OUTPUT.PUT_LINE('------------------------------');
        END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron los datos consultados');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('La consulta select devuelve más de 1 línea');
END;
```
## Fallos
Las formas de hacerlo fallar son las siguientes:
* Modificar la variable `V_COD_SUC` a 100
* Eliminar el WHERE en el primer SELECT