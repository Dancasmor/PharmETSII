CREATE OR REPLACE PACKAGE PRUEBAS_producto AS 

   PROCEDURE inicializar;

   PROCEDURE insertar (   nombre_prueba VARCHAR2, 
                          P_nombre producto.nombre%TYPE, 
                          P_imagenes PRODUCTO.URL_IMAGENES%TYPE, 
                          P_precio_venta producto.precio_venta%TYPE,
                          P_puntos producto.puntos%TYPE, 
                          P_receta producto.receta%TYPE,
                          salidaEsperada BOOLEAN);

   PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          w_oid_producto producto.oid_producto%TYPE, 
                          P_imagenes PRODUCTO.URL_IMAGENES%TYPE, 
                          P_precio_venta producto.precio_venta%TYPE,
                          P_puntos producto.puntos%TYPE, 
                          salidaEsperada BOOLEAN); 

   PROCEDURE eliminar (   nombre_prueba VARCHAR2, 
                          w_oid_producto producto.oid_producto%TYPE, 
                          salidaEsperada BOOLEAN); 

END PRUEBAS_producto;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_producto AS

  PROCEDURE inicializar AS
  BEGIN

      DELETE FROM producto;
      DELETE FROM cuenta_bancaria;
      DELETE FROM empresa;
      DELETE FROM producto;
      DELETE FROM producto;
      DELETE FROM almacen;
      DELETE FROM seccion;
      DELETE FROM producto;
      DELETE FROM lote;
      DELETE FROM usuario;
      DELETE FROM empleado;
      DELETE FROM nomina;
      DELETE FROM envio;
      DELETE FROM pedido;
      DELETE FROM factura;
      DELETE FROM linea;
      DELETE FROM pedido_usuario;
      DELETE FROM bolsa;
      DELETE FROM factura_usuario;
      
    NULL;
  END inicializar;

  PROCEDURE insertar (    nombre_prueba VARCHAR2, 
                          P_nombre producto.nombre%TYPE, 
                          P_imagenes PRODUCTO.URL_IMAGENES%TYPE, 
                          P_precio_venta producto.precio_venta%TYPE,
                          P_puntos producto.puntos%TYPE, 
                          P_receta producto.receta%TYPE,
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_producto producto%ROWTYPE;
    w_oid_producto producto.oid_producto%TYPE;
  BEGIN

    INSERT INTO producto (nombre, precio_venta, URL_IMAGENES, puntos, receta)
                VALUES    (P_nombre, P_precio_venta, P_imagenes, P_puntos, P_receta);

    w_oid_producto := sq_producto.currval;

    SELECT * INTO w_producto FROM producto WHERE oid_producto = w_oid_producto;

    IF (w_producto.nombre <> P_nombre OR w_producto.url_imagenes <> P_imagenes OR w_producto.precio_venta <> P_precio_venta
                OR P_puntos <> w_producto.puntos OR P_receta <> w_producto.receta) THEN
      salida := false;
    END IF;

    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END insertar;

  PROCEDURE actualizar (  nombre_prueba VARCHAR2, 
                          w_oid_producto producto.oid_producto%TYPE, 
                          P_imagenes PRODUCTO.URL_IMAGENES%TYPE, 
                          P_precio_venta producto.precio_venta%TYPE,
                          P_puntos producto.puntos%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_producto producto%ROWTYPE;
  BEGIN

    UPDATE producto SET url_imagenes = P_imagenes,
                 precio_venta = P_precio_venta, puntos = P_puntos WHERE oid_producto=w_oid_producto;

    SELECT * INTO p_producto FROM producto WHERE oid_producto=w_oid_producto;
    IF ( p_producto.url_imagenes <> P_imagenes OR p_producto.precio_venta <> P_precio_venta
                OR P_puntos <> p_producto.puntos) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END actualizar;

  PROCEDURE eliminar (    nombre_prueba VARCHAR2,
                          w_oid_producto producto.oid_producto%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_producto INTEGER;
  BEGIN

    eliminar_producto(w_oid_producto);

    SELECT COUNT(*) INTO n_producto FROM producto WHERE oid_producto=w_oid_producto;
    IF (n_producto <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_producto;
/