--CREAR, ELIMINAR PRODUCTOS BOLSA-----------------------------------------------------------------------------
--RO03-RF04
create or replace PROCEDURE crear_bolsa(
    P_oid_producto   IN  bolsa.oid_producto%TYPE,
    P_oid_pedido_usuario   IN  bolsa.oid_pedido_usuario%TYPE,
    P_cantidad   IN  bolsa.cantidad%TYPE
)   AS 
        anterior INTEGER;
    BEGIN
        SELECT COUNT(*) INTO anterior FROM bolsa WHERE oid_producto = P_oid_producto AND oid_pedido_usuario = P_oid_pedido_usuario;
        IF anterior >=1 THEN
            UPDATE bolsa SET CANTIDAD = CANTIDAD + P_cantidad WHERE oid_producto = P_oid_producto AND oid_pedido_usuario = P_oid_pedido_usuario;
        ELSE
             INSERT INTO bolsa (oid_pedido_usuario, oid_producto, cantidad)
                    VALUES    (P_oid_pedido_usuario, P_oid_producto, P_cantidad);
        END IF;
    END;

/
--RO03-RF04
CREATE OR REPLACE PROCEDURE eliminar_bolsa(
    P_oid_bolsa        IN  bolsa.oid_bolsa%TYPE
)   AS 
    BEGIN
        DELETE bolsa WHERE oid_bolsa = P_oid_bolsa;
    END;
/
--RO03-RF04
CREATE OR REPLACE PROCEDURE cambiar_cantidad_bolsa(
    P_oid_bolsa        IN  bolsa.oid_bolsa%TYPE,
    P_cantidad     IN bolsa.cantidad%TYPE
)   AS 
    BEGIN
        UPDATE bolsa SET cantidad = P_cantidad WHERE oid_bolsa = P_oid_bolsa;
    END;
/
show error
-----------CREAR, ELIMINAR FACTURAS USUARIO PONERLO EN ENVIADO---------------------------------------------------------------------
--RO03-RF06
CREATE OR REPLACE PROCEDURE crear_factura_usuario(
    P_oid_pedido_usuario  IN factura_usuario.oid_pedido_usuario%TYPE,
    P_fecha_venta         IN factura_usuario.fecha_venta%TYPE,
    P_oid_almacen         IN factura_usuario.oid_almacen%TYPE
)   AS
    BEGIN
        INSERT INTO factura_usuario( oid_pedido_usuario, fecha_venta, oid_almacen, enviado)
            VALUES (P_oid_pedido_usuario, P_fecha_venta, P_oid_almacen, 0);
    END;
/
--RO03-RF06
CREATE OR REPLACE PROCEDURE eliminar_factura_usuario(
    P_oid_factura_usuario       IN  factura_usuario.oid_factura_usuario%TYPE
)   AS 
    BEGIN
        DELETE FROM factura_usuario WHERE oid_factura_usuario = P_oid_factura_usuario;
    END;
/
show error
--RO03-RF06
CREATE OR REPLACE PROCEDURE set_enviado(
    P_oid_factura_usuario  IN factura_usuario.oid_factura_usuario%TYPE,
    P_enviado   IN factura_usuario.enviado%TYPE
)AS 
    BEGIN
        UPDATE factura_usuario SET enviado = P_enviado WHERE oid_factura_usuario = P_oid_factura_usuario;
    END;
/
--CREAR, ELIMINAR PEDIDOS DE USUARIO Y PONERLO EN PREPARADO--------------------------------------------------------------------------
--RO03-RF09
CREATE OR REPLACE PROCEDURE crear_pedido_usuario(
    P_dni_usuario               IN  pedido_usuario.dni_usuario%TYPE,
    P_fecha_solicitud           IN  pedido_usuario.fecha_solicitud%TYPE,
    P_contrareembolso_tarjeta   IN  pedido_usuario.contrareembolso_tarjeta%TYPE,
    P_tarjeta                   IN  pedido_usuario.tarjeta%TYPE
    
)   AS 
    BEGIN
        INSERT INTO pedido_usuario(dni_usuario, fecha_solicitud, contrareembolso_tarjeta, tarjeta, preparado)
                VALUES    (P_dni_usuario, P_fecha_solicitud, P_contrareembolso_tarjeta, P_tarjeta, 0);
    END;
/
--RO03-RF09
CREATE OR REPLACE PROCEDURE eliminar_pedido_usuario(
    P_oid_pedido_usuario        IN  pedido_usuario.oid_pedido_usuario%TYPE
)   AS 
    BEGIN
        DELETE bolsa WHERE oid_pedido_usuario = P_oid_pedido_usuario; 
        DELETE pedido_usuario WHERE oid_pedido_usuario = P_oid_pedido_usuario;
    END;
/
--RO03-RF09
CREATE OR REPLACE PROCEDURE set_preparado(
    P_oid_pedido_usuario  IN pedido_usuario.oid_pedido_usuario%TYPE,
    P_preparado IN pedido_usuario.preparado%TYPE
)AS 
    BEGIN
        UPDATE pedido_usuario SET preparado = P_preparado WHERE oid_pedido_usuario = P_oid_pedido_usuario;
    END;
/
--RO03-RF10
CREATE OR REPLACE FUNCTION precioDeLaBolsa(oid_pedido_usuario IN pedido_usuario.oid_pedido_usuario%TYPE)
    RETURN NUMBER
    IS
        cuenta NUMBER;
BEGIN
    SELECT sum(precio_venta) INTO cuenta FROM bolsa bol LEFT OUTER JOIN producto prod ON bol.OID_PRODUCTO = prod.OID_PRODUCTO WHERE bol.OID_PEDIDO_USUARIO = OID_PEDIDO_USUARIO;
    RETURN cuenta;
END;
/

