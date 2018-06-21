--R03-RN01-Limite ventas online
--LIMITA EL MAXIMO DE PEDIDOS DIARIOS REALIZADOS POR UN USUARIO A 3
/*
CREATE OR REPLACE TRIGGER maximo_pedidos_diarios
BEFORE INSERT ON pedido_usuario
FOR EACH ROW
    DECLARE
        num_ped number;
        dni_usr pedido_usuario.dni_usuario%TYPE;
BEGIN
    SELECT count(oid_pedido_usuario) INTO num_ped FROM pedido_usuario WHERE fecha_solicitud > sysdate-1 AND dni_usuario = :NEW.dni_usuario;
    IF num_ped >= 3 
    THEN RAISE_APPLICATION_ERROR(-56322,'El numero maximo de pedidos es 3');
    END IF;
END;
/
*/
/*
--R03-RN03-Sin stock
--NO SE PUEDE AÑADIR PRODUCTOS BOLSA SI NO HAY STOCK
CREATE OR REPLACE TRIGGER restric_sin_stock
BEFORE INSERT OR UPDATE ON bolsa
FOR EACH ROW 
    DECLARE
        stock1             seccion.stock_actual%TYPE;
BEGIN
        SELECT stock_actual INTO stock1 FROM seccion WHERE oid_producto = :NEW.oid_producto;
        IF :NEW.cantidad > stock1
        THEN RAISE_APPLICATION_ERROR(-56922, 'No queda stock de ese producto');
        END IF;
        
END;
/
*/

--CODIGO OBSOLETO, IMPLEMENTADO EN EL PROCEDURE CREAR_BOLSA
--R03-RN05-Solapamiento bolsa
--Solapamiento bolsa: No se puede crear un producto bolsa si ya existia otro no el mismo producto
/*
CREATE OR REPLACE TRIGGER solapamiento_bolsa
BEFORE INSERT ON bolsa
FOR EACH ROW
    DECLARE
    producto_ant INTEGER;
BEGIN
    SELECT count(oid_bolsa) INTO producto_ant FROM bolsa WHERE oid_producto = :NEW.oid_producto AND oid_pedido_usuario = :NEW.oid_pedido_usuario;
    IF producto_ant<>0 THEN RAISE_APPLICATION_ERROR(-56984, 'Ya existe ese producto en la bolsa'); 
    END IF;
END;
/
*/
--R03-RN06-Fechas incompatibles
--LA FECHA DE FACTURA USUARIO NO PUEDE SER ANTERIOR A LA FECHA DE PEDIDO USUARIO
CREATE OR REPLACE TRIGGER fechas_incompatibles
BEFORE INSERT ON factura_usuario
FOR EACH ROW
    DECLARE
    T_fecha_solicitud pedido_usuario.fecha_solicitud%TYPE;
BEGIN
    SELECT fecha_solicitud INTO T_fecha_solicitud FROM pedido_usuario WHERE oid_pedido_usuario = :NEW.oid_pedido_usuario;
    IF T_fecha_solicitud > :NEW.fecha_venta THEN RAISE_APPLICATION_ERROR(-62035, 'La fecha de factura no puede ser anterior a la de pedido'); 
    END iF;
END;
/

--R03-RN07-Productos almacen
--Trigger para modificar automaticamente el stock de los productos de las ventas a los usuarios
CREATE OR REPLACE TRIGGER resta_producto_almacen
BEFORE INSERT ON factura_usuario
FOR EACH ROW
    DECLARE
    c_cantidad_producto bolsa.oid_bolsa%TYPE;
    c_producto bolsa.oid_producto%TYPE;
BEGIN 
    SELECT cantidad INTO c_cantidad_producto FROM bolsa WHERE oid_pedido_usuario= :NEW.oid_pedido_usuario;
    SELECT oid_producto INTO c_producto FROM bolsa WHERE oid_pedido_usuario= :NEW.oid_pedido_usuario;
    UPDATE seccion
    SET stock_actual=stock_actual-c_cantidad_producto
    WHERE seccion.oid_producto=c_producto;
END;
/
    