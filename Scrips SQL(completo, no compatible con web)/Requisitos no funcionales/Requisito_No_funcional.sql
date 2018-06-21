/*
    Requisito no funcional --> RO01-RNF01-Pista modificaciones
*/

DROP TABLE log_productos;
CREATE TABLE log_productos AS SELECT * FROM producto;
TRUNCATE TABLE log_productos; 
ALTER TABLE log_productos 
ADD(
    fcambio     DATE        DEFAULT SYSDATE,
    usuario     CHAR(9)     DEFAULT user,
    cambio      CHAR(1)     CHECK(cambio IN ('U','D'))
    );
-- Crear un trigger after que deje como pistas los valores anteriores al cambio  
CREATE OR REPLACE TRIGGER log_productos
    AFTER DELETE OR UPDATE ON producto
    FOR EACH ROW 
    DECLARE w_cambio CHAR(1);
BEGIN
    IF deleting THEN w_cambio := 'D';
    ELSE w_cambio := 'U';
    END IF;
    INSERT INTO log_productos(OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA, cambio)
        VALUES (:OLD.OID_PRODUCTO, :OLD.NOMBRE, :OLD.URL_IMAGENES, :OLD.PRECIO_VENTA, :OLD.PUNTOS, :OLD.RECETA, w_cambio);
END;
/