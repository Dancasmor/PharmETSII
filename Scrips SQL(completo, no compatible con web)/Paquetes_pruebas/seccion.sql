
/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_SECCION AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_almacen SECCION.OID_ALMACEN%TYPE, P_producto SECCION.OID_producto%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_seccion SECCION.OID_SECCION%TYPE,P_stock_actual SECCION.stock_actual%TYPE, 
        P_stock_limite SECCION.stock_limite%TYPE, P_stock_seguridad SECCION.stock_seguridad%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_seccion SECCION.OID_SECCION%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_SECCION;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_SECCION AS

  /* INICIALIZACIÓN */
  PROCEDURE inicializar AS
  BEGIN

    /* Borrar contenido de la tabla */
      DELETE FROM contacto;
      DELETE FROM cuenta_bancaria;
      DELETE FROM empresa;
      DELETE FROM farmacia;
      DELETE FROM producto;
      DELETE FROM almacen;
      DELETE FROM seccion;
      DELETE FROM proveedor;
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

/* PRUEBA PARA LA INSERCIÓN DE SECCION */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_almacen SECCION.OID_ALMACEN%TYPE, P_producto SECCION.OID_producto%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_seccion seccion%ROWTYPE;
    w_oid_seccion seccion.OID_seccion%TYPE;
  BEGIN
    
    /* Insertar almacen */
    New_seccion(P_almacen, P_producto);
    
    /* Seleccionar almacen y comprobar que los datos se insertaron correctamente */
    w_oid_seccion := sq_seccion.currval;
    SELECT * INTO w_seccion FROM seccion WHERE oid_seccion = w_oid_seccion;
    IF (w_seccion.oid_almacen <> P_almacen OR w_seccion.oid_producto <> P_producto) THEN
      salida := false;
    END IF;
    COMMIT WORK;
    
    /* Mostrar resultado de la prueba */
    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END insertar;
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE SECCION */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_seccion SECCION.OID_SECCION%TYPE, P_stock_actual SECCION.stock_actual%TYPE, 
        P_stock_limite SECCION.stock_limite%TYPE, P_stock_seguridad SECCION.stock_seguridad%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_seccion seccion%ROWTYPE;
  BEGIN
    
    /* Actualizar seccion */
    UPDATE seccion SET stock_actual = P_stock_actual, stock_limite = P_stock_limite,
                 stock_seguridad = P_stock_seguridad WHERE oid_seccion=p_oid_seccion;
    
    /* Seleccionar seccion y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_seccion FROM seccion WHERE oid_seccion=p_oid_seccion;
    IF (p_seccion.stock_actual <> P_stock_actual OR p_seccion.stock_limite <> P_stock_limite OR
                 p_seccion.stock_seguridad <> P_stock_seguridad) THEN
      salida := false;
    END IF;
    COMMIT WORK;
    
    /* Mostrar resultado de la prueba */
    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END actualizar;


/* PRUEBA PARA LA ELIMINACIÓN DE SECCION */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_seccion SECCION.OID_SECCION%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_seccion INTEGER;
  BEGIN
    
    /* Eliminar seccion */
    delete_seccion(w_oid_seccion);
    
    /* Verificar que el almacen no se encuentra en la BD */
    SELECT COUNT(*) INTO n_seccion FROM seccion WHERE oid_seccion=w_oid_seccion;
    IF (n_seccion <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;
    
    /* Mostrar resultado de la prueba */
    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_SECCION;
/