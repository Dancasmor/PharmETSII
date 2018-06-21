
/*
TRIGGERS
*/

-- RO01-RN01-Stock límite

-- Crear un trigger que evite crear el pedido 
/*
CREATE OR REPLACE TRIGGER stock_limite
    BEFORE INSERT OR UPDATE ON linea
    FOR EACH ROW 
    DECLARE
         P_seccion seccion.oid_seccion%TYPE;
         P_almacen almacen.oid_almacen%TYPE;
BEGIN
        IF(:NEW.oid_lote IS NULL) THEN
            SELECT oid_almacen INTO P_almacen FROM almacen WHERE almacen_general = 1;
            SELECT oid_seccion INTO P_seccion FROM seccion  s LEFT OUTER JOIN producto p ON p.oid_producto = s.OID_PRODUCTO
            WHERE oid_almacen = P_almacen AND p.NOMBRE = nombre_producto(:NEW.oid_producto);
            if(:NEW.cantidad < 20 OR :NEW.cantidad > dif_stock(P_seccion)) THEN
                RAISE_APPLICATION_ERROR(-20010, 'No puedes pedir menos de 20 unidades ni pasarte del stock límite');
            END IF;
        end if;
     EXCEPTION
            WHEN NO_DATA_FOUND THEN  RAISE_APPLICATION_ERROR(-20010, 'No DATA FOUND encontrada');   
END;
/
*/
--RO01-RN02-Stock seguridad
-- Cuando se llega al stock de seguridad del producto, se indica información acerca del producto, stock restante, etc...
CREATE OR REPLACE TRIGGER stock_seguridad
    AFTER UPDATE ON seccion
    FOR EACH ROW 
DECLARE 
BEGIN
    if(:NEW.stock_seguridad >= :NEW.stock_actual) THEN
         DBMS_OUTPUT.PUT_LINE('En la seccion: ' || :NEW.oid_seccion || ' que contiene el producto: ' || :NEW.oid_producto
            || ' ha quedado a ' || :NEW.stock_actual || ' cuyo stock máximo es de ' || :NEW.stock_limite);
    end if;
END;
/

-- RO01-RN03-Salida productos

CREATE OR REPLACE TRIGGER envio
    BEFORE INSERT ON factura
    FOR EACH ROW 
    DECLARE 
    CURSOR c IS SELECT cantidad, oid_linea FROM linea WHERE oid_pedido = :NEW.oid_pedido;
BEGIN
    FOR fila IN c LOOP
        EXIT WHEN c%NOTFOUND;
        REST_CANTIDAD(SECCION_PRODUCTO(PRODUCTO_LINEA(fila.oid_linea)), fila.cantidad);
    END LOOP;
END;
/

--RO01-RN04-Envío pedidos

CREATE OR REPLACE TRIGGER enviar_pedidos
    BEFORE INSERT OR UPDATE ON factura
    FOR EACH ROW 
    DECLARE 
        
BEGIN
    IF esta_enviado(:NEW.oid_pedido) <> 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No puede enviarse un pedido ya enviado');
    END IF;
END;
/

--RO01-RN05-Stock

CREATE OR REPLACE TRIGGER stock
    BEFORE UPDATE ON seccion
    FOR EACH ROW 
    DECLARE 
BEGIN
    IF (:NEW.stock_limite <= :NEW.stock_seguridad OR :NEW.stock_actual < 0 OR :NEW.stock_seguridad < 0 OR :NEW.stock_limite < 0) THEN
        :NEW.stock_actual := 0;
    END IF;
END;
/

--RO01-RN06-Almacén
CREATE OR REPLACE TRIGGER almacen
    BEFORE INSERT OR UPDATE ON almacen
    FOR EACH ROW 
    DECLARE 
BEGIN
    IF (:NEW.ALMACEN_GENERAL = 0 AND :NEW.OID_FARMACIA IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No puede crearse un almacén no general y no asociado a la farmacia');
    END IF;
END;
/

--RO01-RN07-Enviar pedido
CREATE OR REPLACE TRIGGER realizar_envio
    AFTER INSERT OR UPDATE ON factura
    FOR EACH ROW 
    DECLARE 
BEGIN
    enviar_pedido(:NEW.oid_pedido);
END;
/

--Trigger adicional 1 --> evitar crear oedido para proveedor con oid null
CREATE OR REPLACE TRIGGER pedido_proveedor
    BEFORE INSERT OR UPDATE ON pedido
    FOR EACH ROW 
    DECLARE 
BEGIN
   IF (:NEW.esproveedor = 1 AND :NEW.OID_proveedor IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20022, 'No puede crearse un pedido para proveedor sin proveedor');
    END IF;
    IF (:NEW.esproveedor = 0 AND :NEW.OID_almacen2 IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20023, 'No puede crearse un pedido para almacen sin almacen');
    END IF;
END;
/

--Trigger adicional 2 --> concordar linea con pedido
CREATE OR REPLACE TRIGGER pedido_acorde_linea
    BEFORE INSERT OR UPDATE ON linea
    FOR EACH ROW 
    DECLARE 
    w_pedido PEDIDO.ESPROVEEDOR%TYPE;
BEGIN
    SELECT esproveedor INTO w_pedido FROM pedido WHERE oid_pedido = :NEW.oid_pedido;
   IF (w_pedido = 1 AND :NEW.OID_lote IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20024, 'No puede crearse un pedido a proveedor y la linea no ser de lote');
    END IF;
    IF (w_pedido = 0 AND :NEW.OID_producto IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20025, 'No puede crearse un pedido a almacen y la linea no referenciar a ningún producto');
    END IF;
END;
/

--Trigger adicional 3 --> evitar crear envio de proveedor sin proveedor
CREATE OR REPLACE TRIGGER envio_proveedor
    BEFORE INSERT OR UPDATE ON envio
    FOR EACH ROW 
    DECLARE 
BEGIN
   IF (:NEW.esproveedor = 1 AND :NEW.OID_proveedor IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20022, 'No puede crearse un envio de proveedor sin proveedor');
    END IF;
    IF (:NEW.esproveedor = 0 AND :NEW.OID_almacen IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20023, 'No puede crearse un envio para almacen sin almacen');
    END IF;
END;
/

--Trigger adicional 4 --> evitar fecha envio anterior a hoy
CREATE OR REPLACE TRIGGER envio_fecha
    BEFORE INSERT OR UPDATE ON envio
    FOR EACH ROW 
    DECLARE 
BEGIN
   IF (:NEW.fecha_envio < sysdate) THEN
        RAISE_APPLICATION_ERROR(-20022, 'La fecha de envio no puede anterior a hoy');
    END IF;
END;
/