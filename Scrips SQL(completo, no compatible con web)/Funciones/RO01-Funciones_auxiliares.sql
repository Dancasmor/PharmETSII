/*
    FUNCIONES AUXILIARES
*/
-- Función para comprobar si la salida es correcta

CREATE OR REPLACE FUNCTION ASSERT_EQUALS (salida BOOLEAN, salida_esperada BOOLEAN) RETURN VARCHAR2 AS 
BEGIN
  IF (salida = salida_esperada) THEN
    RETURN 'EXITO';
  ELSE
    RETURN 'FALLO';
  END IF;
END ASSERT_EQUALS;
/

-- RN01

--Necesario previamente una funcion que calcule el nombre de un producto a partir id
CREATE OR REPLACE FUNCTION nombre_producto (P_producto PRODUCTO.OID_PRODUCTO%TYPE)
    RETURN PRODUCTO.NOMBRE%TYPE 
    IS
      P_enviado  PRODUCTO.NOMBRE%TYPE;
BEGIN
    SELECT nombre INTO P_enviado FROM producto WHERE oid_producto = P_producto;
    RETURN P_enviado;                        
END;
/

-- RN03

-- Funcion necesaria para, a partir de una linea, obtener el nombre del producto que tiene
CREATE OR REPLACE FUNCTION producto_linea(P_linea IN LINEA.OID_LINEA%TYPE)
    RETURN PRODUCTO.NOMBRE%TYPE
    IS
      P_nombre  PRODUCTO.NOMBRE%TYPE;
BEGIN
    SELECT p.NOMBRE INTO P_nombre FROM producto p LEFT OUTER JOIN linea l ON p.OID_PRODUCTO = l.OID_PRODUCTO WHERE l.OID_LINEA = P_linea;
    RETURN P_nombre;                        
END;
/

-- Ultima funcion necesaria para poder obtener la seccion a partir del almacen y el nombre del producto
CREATE OR REPLACE FUNCTION seccion_producto (P_producto IN PRODUCTO.NOMBRE%TYPE)
    RETURN SECCION.OID_SECCION%TYPE
    IS
      P_nombre  SECCION.OID_SECCION%TYPE;
BEGIN
    SELECT s.OID_SECCION INTO P_nombre FROM seccion s NATURAL JOIN almacen a LEFT OUTER JOIN producto p ON s.OID_PRODUCTO = p.OID_PRODUCTO
            WHERE a.almacen_general = 1 AND p.NOMBRE = P_producto;
    RETURN P_nombre;                        
END;
/

--Es necesario previamente una funcion que devuelva a partir de la factura, el pedido al que corresponde
CREATE OR REPLACE FUNCTION pedido_factura(P_factura IN factura.oid_factura%TYPE)
    RETURN pedido.oid_pedido%TYPE
    IS
      P_pedido  pedido.oid_pedido%TYPE;
BEGIN
    SELECT p.OID_PEDIDO INTO P_pedido FROM factura f LEFT OUTER JOIN pedido p ON f.OID_PEDIDO = p.OID_PEDIDO
                            WHERE oid_factura = P_factura;
    RETURN P_pedido;                        
END;
/

-- RN05

-- creamos una función que te diga si está enviado un pedido 
CREATE OR REPLACE FUNCTION esta_enviado (P_pedido IN pedido.oid_pedido%TYPE)
    RETURN number 
    IS
      P_enviado  number;
BEGIN
    SELECT COUNT(*) INTO P_enviado FROM pedido WHERE enviado = 1 AND oid_pedido = P_pedido;
    RETURN P_enviado;                        
END;
/

CREATE OR REPLACE FUNCTION es_valido (producto IN producto.oid_producto%TYPE, cantidad IN seccion.stock_actual%TYPE, pedido IN pedido.oid_pedido%type)
    RETURN number 
    IS
         P_seccion seccion.oid_seccion%TYPE;
         P_almacen almacen.oid_almacen%TYPE;
BEGIN
            SELECT oid_almacen INTO P_almacen FROM pedido WHERE oid_pedido = pedido;
            SELECT oid_seccion INTO P_seccion FROM seccion  s 
            WHERE oid_almacen = P_almacen AND  oid_producto = producto;
            if(cantidad > dif_stock2(P_seccion)) THEN
                return 0;
            END IF;
            return 1;
     EXCEPTION
            WHEN NO_DATA_FOUND THEN  return 1;   
END;
/


