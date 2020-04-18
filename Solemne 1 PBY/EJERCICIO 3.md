# Ejercicio 3

**Bloque pl/sql**
```sql
DECLARE
    V_ID_FAR     INT;
    V_FARMACIA   VARCHAR2(50);
    V_SUCURSAL   VARCHAR2(50);
    V_GERENTE    VARCHAR2(50);
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
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    DBMS_OUTPUT.PUT_LINE('Codigo Sucursal: ' || V_COD_SUC);
    DBMS_OUTPUT.PUT_LINE('Farmacia: ' || V_FARMACIA);
    DBMS_OUTPUT.PUT_LINE('Sucursal: ' || V_SUCURSAL);
    DBMS_OUTPUT.PUT_LINE('Vendedores: ' || V_VENDEDORES);
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    FOR INICIO IN (
        SELECT ID_FAR, NOM_FAR, GERENTE, NOM_SUC
        INTO V_ID_FAR, V_FARMACIA,V_GERENTE,V_SUCURSAL
        FROM SUCURSAL
                 RIGHT JOIN FARMACIA F ON SUCURSAL.FARMACIA_ID_FAR = F.ID_FAR)
        LOOP
            IF INICIO.NOM_FAR IS NULL THEN
                DBMS_OUTPUT.PUT_LINE('------------------------------');
                DBMS_OUTPUT.PUT_LINE('Farmacia sin nombre, id: ' || INICIO.ID_FAR);
                DBMS_OUTPUT.PUT_LINE('Sucursal: ' || UPPER(NVL(INICIO.NOM_SUC, 'Sin sucursal')));
                DBMS_OUTPUT.PUT_LINE('Gerente: ' || UPPER(INICIO.GERENTE));
                DBMS_OUTPUT.PUT_LINE('------------------------------');
            ELSE
                DBMS_OUTPUT.PUT_LINE('------------------------------');
                DBMS_OUTPUT.PUT_LINE('Farmacia: ' || UPPER(INICIO.NOM_FAR));
                DBMS_OUTPUT.PUT_LINE('Sucursal: ' || UPPER(NVL(INICIO.NOM_SUC, 'Sin sucursal')));
                DBMS_OUTPUT.PUT_LINE('------------------------------');
            END IF;
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
