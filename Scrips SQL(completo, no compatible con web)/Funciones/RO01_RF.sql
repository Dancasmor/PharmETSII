/*
REQUISITOS FUNCIONALES
*/

--RO01-RF01-Cantidad
--Procedure para aumentar cantidad
CREATE OR REPLACE PROCEDURE Sum_cantidad(
    P_seccion       IN      SECCION.OID_SECCION%TYPE,
    P_cantidad      IN      SECCION.STOCK_ACTUAL%TYPE
)AS 
BEGIN
    UPDATE seccion 
    SET stock_actual = stock_actual+P_cantidad
    WHERE (seccion.oid_seccion = P_seccion);
END;
/
--Procedure para restar cantidad
CREATE OR REPLACE PROCEDURE Rest_cantidad(
    P_seccion       IN      SECCION.OID_SECCION%TYPE,
    P_cantidad      IN      SECCION.STOCK_ACTUAL%TYPE
)AS 
BEGIN
    UPDATE seccion 
    SET stock_actual = stock_actual-P_cantidad
    WHERE (seccion.oid_seccion = P_seccion);
END;
/

--RO01-RF02-Proveedor
--Procedure para crear proveedor
create or replace PROCEDURE New_proveedor(
    P_lab           IN      proveedor.nombre_lab%TYPE,
    P_pre_sin       IN      PROVEEDOR.PRECIO_ENVIO_SIN_GASTOS%TYPE,
    P_contacto      IN      PROVEEDOR.OID_CONTACTO%TYPE,
    P_contra        IN      Proveedor.contraseña%TYPE
)AS 
BEGIN
    INSERT INTO proveedor (nombre_lab, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO, contraseña)
                VALUES    (P_lab, P_pre_sin, P_contacto, P_contra);
END;
/
--Procedure para eliminar proveedor
CREATE OR REPLACE PROCEDURE Delete_proveedor(
    P_oid   IN  PROVEEDOR.OID_PROVEEDOR%TYPE
)AS 
BEGIN
    DELETE FROM proveedor WHERE OID_PROVEEDOR = P_oid;
END;
/
--RO01-RF03-Almacén
--Procedure para crear almacen
CREATE OR REPLACE PROCEDURE New_almacen(
    P_general       IN      ALMACEN.ALMACEN_GENERAL%TYPE,
    P_empresa       IN      ALMACEN.oid_empresa%TYPE,
    P_farmacia      IN      ALMACEN.OID_FARMACIA%TYPE
)AS 
BEGIN
    INSERT INTO almacen (almacen_general, oid_empresa, OID_FARMACIA)
                VALUES    (P_general, P_empresa, P_farmacia);
END;
/

CREATE OR REPLACE PROCEDURE New_almacen_farmacia(
    P_farmacia      IN      ALMACEN.OID_FARMACIA%TYPE
)AS 
BEGIN
    INSERT INTO almacen (almacen_general, OID_FARMACIA)
                VALUES    (0, P_farmacia);
END;
/
--Procedure para eliminar almacen
CREATE OR REPLACE PROCEDURE Delete_almacen(
    P_oid   IN  almacen.OID_almacen%TYPE
)AS 
BEGIN
    DELETE FROM almacen WHERE OID_almacen = P_oid;
END;
/

--RO01-RF04-Secciones
--Procedure para crear secciones
CREATE OR REPLACE PROCEDURE New_seccion(
    P_almacen            IN      SECCION.OID_ALMACEN%TYPE,
    P_producto           IN      SECCION.OID_producto%TYPE
)AS 
BEGIN
    INSERT INTO seccion (oid_almacen, oid_producto)
                VALUES    (P_almacen, P_producto);
END;
/
--Procedure para eliminar secciones
CREATE OR REPLACE PROCEDURE Delete_seccion(
    P_oid   IN  seccion.OID_seccion%TYPE
)AS 
BEGIN
    DELETE FROM seccion WHERE OID_seccion = P_oid;
END;
/
--Procedure para modificar stock limite y seguridad
CREATE OR REPLACE PROCEDURE Mod_stock(
    P_seccion       IN      SECCION.OID_SECCION%TYPE,
    P_limite        IN      SECCION.STOCK_LIMITE%TYPE,
    P_seguridad        IN      SECCION.STOCK_SEGURIDAD%TYPE
)AS 
BEGIN
    UPDATE seccion 
    SET stock_limite = P_limite,
        stock_seguridad = P_seguridad
    WHERE (seccion.oid_seccion = P_seccion);
END;
/

--RO01-RF05-Pedidos
--Procedure para crear pedido a proveedor
CREATE OR REPLACE PROCEDURE New_pedido_proveedor(
    P_proveedor          IN      PEDIDO.OID_PROVEEDOR%TYPE
)AS 
    ag  ALMACEN.OID_ALMACEN%TYPE;
BEGIN
    SELECT OID_ALMACEN INTO ag FROM ALMACEN WHERE ALMACEN_GENERAL = 1;
    INSERT INTO pedido (oid_almacen, oid_proveedor, oid_almacen2, ESPROVEEDOR)
                VALUES    (ag, P_proveedor, null, 1);
END;
/
--Procedure para crear pedido a almacen general
CREATE OR REPLACE PROCEDURE New_pedido_general(
    P_almacen            IN      PEDIDO.OID_ALMACEN%TYPE
)AS 
    ag  ALMACEN.OID_ALMACEN%TYPE;
BEGIN
    SELECT OID_ALMACEN INTO ag FROM ALMACEN WHERE ALMACEN_GENERAL = 1;
    INSERT INTO pedido (oid_almacen, oid_proveedor, oid_almacen2, ESPROVEEDOR)
                VALUES    (P_almacen, null, ag, 0);
END;
/
--RO01-RF06-Enviar pedidos
create or replace PROCEDURE Enviar_pedido(
    P_oid   IN  PEDIDO.OID_PEDIDO%TYPE
)AS 
BEGIN
    UPDATE pedido 
    SET enviado = 1
    WHERE (pedido.oid_pedido = P_oid);
END;
/

--RO01-RF07-Eliminar pedidos
--Procedure para eliminar pedidos
CREATE OR REPLACE PROCEDURE Delete_pedido(
    P_oid   IN  PEDIDO.OID_PEDIDO%TYPE
)AS 
    e    PEDIDO.ENVIADO%TYPE    := null;
BEGIN
    SELECT enviado INTO e FROM pedido WHERE OID_PEDIDO = P_oid;
    IF(e = 0) THEN DELETE FROM pedido WHERE OID_pedido = P_oid;
    END IF;
END;
/

--RO01-RF08-Crear facturas
--Procedure para crear facturas
CREATE OR REPLACE PROCEDURE New_factura(
    P_precio_env            IN      FACTURA.PRECIO_ENVIO%TYPE,
    P_oid_pedido            IN      FACTURA.OID_PEDIDO%TYPE,
    P_oid_almacen           IN      FACTURA.OID_ALMACEN%TYPE,
    P_oid_envio             IN      FACTURA.OID_ENVIO%TYPE
)AS 
BEGIN
    INSERT INTO factura (oid_almacen, oid_pedido, oid_envio, PRECIO_ENVIO)
                VALUES    (P_oid_almacen, P_oid_pedido, P_oid_envio, P_precio_env);
END;
/

--RO01-RF09-Envíos
--Procedure para crear envios proveedor
CREATE OR REPLACE PROCEDURE New_envio_proveedor(
    P_fecha_envio       IN      ENVIO.FECHA_ENVIO%TYPE,
    P_proveedor         IN      ENVIO.OID_PROVEEDOR%TYPE
)AS 
BEGIN
    INSERT INTO envio (fecha_envio, oid_proveedor, OID_ALMACEN, esproveedor)
                VALUES    (P_fecha_envio, P_proveedor, null, 1);
END;
/
--Procedure para crear envios almacen
CREATE OR REPLACE PROCEDURE New_envio_almacen(
    P_fecha_envio       IN      ENVIO.FECHA_ENVIO%TYPE,
    P_almacen           IN      ENVIO.OID_ALMACEN%TYPE
)AS 
BEGIN
    INSERT INTO envio (fecha_envio, OID_ALMACEN, oid_proveedor, esproveedor)
                VALUES    (P_fecha_envio, P_almacen, null, 0);
END;
/
--RO01-RF10-Pedidos por fecha
CREATE OR REPLACE PROCEDURE ver_pedido_fecha(
    P_fecha       IN    PEDIDO.FECHA_PEDIDO%TYPE
)AS 
    CURSOR c IS
        SELECT oid_pedido, FECHA_PEDIDO,OID_ALMACEN FROM pedido WHERE FECHA_PEDIDO >= P_fecha AND ESPROVEEDOR = 0 GROUP BY oid_almacen, FECHA_PEDIDO,oid_pedido;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Pedidos desde la fecha: ' || P_fecha || ' hasta hoy:');
    FOR fila IN c LOOP
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(fila.oid_almacen || '-> fecha: ' || fila.fecha_pedido || ' = ' || fila.oid_pedido);
    END LOOP;
END;
/
--RO01-RF11-Pedidos proveedor
CREATE OR REPLACE PROCEDURE ver_pedido_proveedor(
    P_proveedor       IN    PEDIDO.OID_PROVEEDOR%TYPE,
    P_fecha_comienzo    IN  PEDIDO.FECHA_PEDIDO%TYPE
)AS 
    CURSOR c IS
        SELECT oid_pedido, FECHA_PEDIDO,OID_ALMACEN FROM pedido WHERE FECHA_PEDIDO >= P_fecha_comienzo AND ESPROVEEDOR = 1 GROUP BY oid_almacen,FECHA_PEDIDO,oid_pedido;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Pedidos realizados al proveedor: ' || P_proveedor || ' desde:' || P_fecha_comienzo);
    FOR fila IN c LOOP
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(fila.oid_almacen || '-> fecha: ' || fila.fecha_pedido || ' = ' || fila.oid_pedido);
    END LOOP;
END;
/
--RO01-RF12-Pedidos proveedores
CREATE OR REPLACE PROCEDURE ver_proveedores_mas_pedidos(
    P_fecha_comienzo    IN  PEDIDO.FECHA_PEDIDO%TYPE
)AS 
    CURSOR c IS
        SELECT oid_proveedor, COUNT(*) AS num FROM pedido WHERE FECHA_PEDIDO >= P_fecha_comienzo AND ESPROVEEDOR = 1 GROUP BY oid_proveedor ORDER BY 2 DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Los 3 proveedores a los que mas pedimos, desde:' || P_fecha_comienzo || ' son: ');
    FOR fila IN c LOOP
        EXIT WHEN c%ROWCOUNT > 3;
        DBMS_OUTPUT.PUT_LINE(fila.oid_proveedor || ' = ' || fila.num);
    END LOOP;
END;
/
--RO01-RF13-Menos pedidos
CREATE OR REPLACE PROCEDURE ver_farmacias_menos_pedidos(
    P_fecha_comienzo    IN  PEDIDO.FECHA_PEDIDO%TYPE
)AS 
    CURSOR c IS
        SELECT p.oid_almacen, COUNT(*) AS num FROM almacen a LEFT OUTER JOIN pedido p ON a.OID_ALMACEN = p.OID_ALMACEN
            WHERE FECHA_PEDIDO >= P_fecha_comienzo AND ESPROVEEDOR = 0 GROUP BY p.oid_almacen ORDER BY 2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Los 2 almacenes que menos han pedido desde:' || P_fecha_comienzo || ' son: ');
    FOR fila IN c LOOP
        EXIT WHEN c%ROWCOUNT > 2;
        DBMS_OUTPUT.PUT_LINE(fila.oid_almacen || ' = ' || fila.num);
    END LOOP;
END;
/
--RO01-RF14-Lotes proveedores
CREATE OR REPLACE PROCEDURE ver_lotes_proveedor(
    P_producto      IN  PRODUCTO.NOMBRE%TYPE
)AS 
    CURSOR c IS
        SELECT px.NOMBRE, oid_proveedor, oid_lote, cantidad_lote, precio_lote  FROM producto px
            LEFT OUTER JOIN (SELECT * FROM lote)py
            ON px.oid_producto = py.OID_PRODUCTO WHERE px.NOMBRE = P_producto AND py.oid_lote IS NOT NULL
            GROUP BY px.NOMBRE, oid_proveedor, oid_lote, cantidad_lote, precio_lote;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Los lotes que se ofrecen de ' || P_producto || ' son: ');
    FOR fila IN c LOOP
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || fila.nombre || ' Proveedor: ' || fila.oid_proveedor || '-> LOTE: ' ||fila.oid_lote
        || ' Cantidad: ' || fila.cantidad_lote || ' - Precio: ' || fila.precio_lote || ' euros');
    END LOOP;
END;
/
--RO01-RF15-Stock total
CREATE OR REPLACE PROCEDURE ver_stock_almacenes(
    P_producto      IN  PRODUCTO.NOMBRE%TYPE
)AS 
    CURSOR c IS
        SELECT s.OID_ALMACEN, p.NOMBRE,  s.OID_SECCION, s.STOCK_ACTUAL FROM seccion s LEFT OUTER JOIN producto p ON p.OID_PRODUCTO = s.OID_PRODUCTO
             WHERE p.NOMBRE = 'medicina'
             GROUP BY  s.OID_ALMACEN, p.nombre, s.OID_SECCION, s.STOCK_ACTUAL; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('El stock disponible de ' || P_producto || ' en los almacenes son: ');
    FOR fila IN c LOOP
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Almacén: ' || fila.oid_almacen || '-> Sección: ' ||fila.oid_seccion
        || ' + Stock actual: ' || fila.stock_actual);
    END LOOP;
END;
/
--RO01-RF16-Lotes
--Procedure para crear lotes
CREATE OR REPLACE PROCEDURE New_lote(
    P_cantidad            IN      LOTE.CANTIDAD_LOTE%TYPE,
    P_precio              IN      LOTE.PRECIO_LOTE%TYPE,
    P_proveedor           IN      LOTE.OID_PROVEEDOR%TYPE,
    P_producto            IN      LOTE.OID_PRODUCTO%TYPE
)AS 
BEGIN
    INSERT INTO  lote (CANTIDAD_LOTE, OID_PRODUCTO, OID_PROVEEDOR, PRECIO_LOTE)
                VALUES    (P_cantidad, P_producto, P_proveedor, P_precio);
END;
/

--Procedure para eliminar lotes
CREATE OR REPLACE PROCEDURE Delete_lote(
    P_oid   IN  LOTE.OID_LOTE%TYPE
)AS 
BEGIN
    DELETE FROM lote WHERE OID_lote = P_oid;
END;
/
--Procedure para modificar la cantidad y el precio del lote
CREATE OR REPLACE PROCEDURE cambiar_cantidadPrecio_lote(
    P_oid_lote        IN    LOTE.oid_lote%TYPE,
    P_cantidad        IN    LOTE.cantidad_lote%TYPE,
    P_precio          IN    LOTE.precio_lote%TYPE
)   AS 
    BEGIN
        UPDATE lote SET cantidad_lote = P_cantidad WHERE oid_lote = P_oid_lote;
        UPDATE lote SET precio_lote = P_precio WHERE oid_lote = P_oid_lote;
    END;
/
--Procedure para crear lineas de lotes
CREATE OR REPLACE PROCEDURE New_linea_lote(
    P_pedido              IN      LINEA.OID_PEDIDO%TYPE,
    P_lote                IN      LINEA.OID_LOTE%TYPE
)AS 
    P_cantidad            LINEA.CANTIDAD%TYPE;
BEGIN
    SELECT CANTIDAD_LOTE INTO P_cantidad FROM lote WHERE OID_LOTE = P_lote;
    INSERT INTO  linea (CANTIDAD, OID_PEDIDO, OID_LOTE)
                VALUES    (P_cantidad, P_pedido, P_lote);
END;
/
--Procedure para crear lineas a almacen general
CREATE OR REPLACE PROCEDURE New_linea_producto(
    P_cantidad            IN      LINEA.CANTIDAD%TYPE,
    P_pedido              IN      LINEA.OID_PEDIDO%TYPE,
    P_producto                IN      LINEA.OID_producto%TYPE
)AS 
BEGIN
    INSERT INTO  linea (CANTIDAD, OID_PEDIDO, OID_producto)
                VALUES    (P_cantidad, P_pedido, P_producto);
END;
/
-- RO01-RF18-Lote económico
-- Primero necesitaremos una funcion auxiliar para calcular la diferencia entre stock limite y de seguridad para saber la cantidad a pedir
CREATE OR REPLACE FUNCTION dif_stock(P_seccion IN SECCION.OID_SECCION%TYPE)
    RETURN NUMBER
    IS
      P_limite  SECCION.STOCK_LIMITE%TYPE;
      P_seguridad  SECCION.STOCK_SEGURIDAD%TYPE;
BEGIN
    SELECT STOCK_LIMITE INTO P_limite FROM seccion WHERE OID_SECCION = P_seccion;
    SELECT STOCK_SEGURIDAD INTO P_seguridad FROM seccion WHERE OID_SECCION = P_seccion;
    RETURN P_limite - P_seguridad;
END;
/

CREATE OR REPLACE FUNCTION dif_stock2(P_seccion IN SECCION.OID_SECCION%TYPE)
    RETURN NUMBER
    IS
      P_limite  SECCION.STOCK_LIMITE%TYPE;
      P_seguridad  SECCION.STOCK_SEGURIDAD%TYPE;
BEGIN
    SELECT STOCK_LIMITE INTO P_limite FROM seccion WHERE OID_SECCION = P_seccion;
    SELECT STOCK_actual INTO P_seguridad FROM seccion WHERE OID_SECCION = P_seccion;
    RETURN P_limite - P_seguridad;
END;
/
--RO01-RF17-Seccion proveedor
-- Necesitamos tambien una funcion que nos devuelva el proveedor que vende dicho producto
CREATE OR REPLACE FUNCTION proveedor_producto(P_seccion IN SECCION.OID_SECCION%TYPE)
    RETURN PROVEEDOR.OID_PROVEEDOR%TYPE
    IS
        P_nombre producto.nombre%TYPE;
        P_proveedor PROVEEDOR.OID_PROVEEDOR%TYPE;
BEGIN
    SELECT nombre INTO P_nombre FROM producto p LEFT OUTER JOIN seccion s ON p.OID_PRODUCTO = s.OID_PRODUCTO WHERE s.oid_seccion = P_seccion;
    SELECT DISTINCT oid_proveedor INTO P_proveedor FROM lote l LEFT OUTER JOIN producto p ON p.OID_PRODUCTO = l.OID_PRODUCTO WHERE p.NOMBRE = P_nombre;
    RETURN P_proveedor;
END;
/
-- Ahora creamos el procedure que introduzca lote a comprar
CREATE OR REPLACE FUNCTION lote_optimo(P_seccion   IN  SECCION.OID_SECCION%TYPE)
    RETURN lote.OID_lote%TYPE 
    IS
        W_lote lote.OID_lote%TYPE := null;
        CURSOR c IS
            SELECT * FROM lote WHERE OID_PROVEEDOR = PROVEEDOR_PRODUCTO(P_seccion) AND CANTIDAD_LOTE < DIF_STOCK(P_seccion) ORDER BY CANTIDAD_LOTE DESC;
BEGIN
    FOR fila IN c LOOP
        EXIT WHEN c%ROWCOUNT > 1;
        W_lote := fila.oid_lote;
    END LOOP;
    RETURN W_lote;
END;
/





