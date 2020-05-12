CREATE TABLE ALUMNO
(
    RUT    VARCHAR2(15) PRIMARY KEY,
    NOMBRE VARCHAR2(30),
    COMUNA VARCHAR2(30)
);

INSERT INTO ALUMNO
VALUES (1111, 'Enrique Muñoz R.', 'Maipú');
INSERT INTO ALUMNO
VALUES (1112, 'Guido', 'La Florida');
INSERT INTO ALUMNO
VALUES (1113, 'Garces', 'La Florida');
INSERT INTO ALUMNO
VALUES (1114, 'Lascaniwi', 'Stgo.Centro');

BEGIN
    FOR SECUENCIADOR IN (SELECT NOMBRE FROM ALUMNO ORDER BY RUT DESC )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre: ' || SECUENCIADOR.NOMBRE);
        END LOOP;
END;

DECLARE
    CURSOR MOSTRARNOMBRE IS SELECT NOMBRE, COMUNA
                            FROM ALUMNO; -- se declara el cursor
    SALIDA MOSTRARNOMBRE%ROWTYPE; -- %ROWTYPE usa el tipo de dato retornado por el cursor
BEGIN
    OPEN MOSTRARNOMBRE;
    FETCH MOSTRARNOMBRE INTO SALIDA; -- avanza a la primera posición del cursor
    WHILE MOSTRARNOMBRE%FOUND -- se revisa si existen datos en el cursor
        LOOP
            DBMS_OUTPUT.PUT_LINE(SALIDA.NOMBRE || ' ' || SALIDA.COMUNA);
            FETCH MOSTRARNOMBRE INTO SALIDA; -- avanza a la siguiente posición del cursor
        END LOOP;
    CLOSE MOSTRARNOMBRE;
END;
