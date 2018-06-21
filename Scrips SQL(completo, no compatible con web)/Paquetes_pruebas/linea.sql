
/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_LINEA AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_cantidad LINEA.CANTIDAD%TYPE, P_lote LINEA.OID_LOTE%TYPE,
        P_pedido LINEA.OID_pedido%TYPE,P_producto LINEA.OID_producto%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_linea LINEA.OID_LINEA%TYPE, P_cantidad LINEA.CANTIDAD%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_linea LINEA.OID_LINEA%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_LINEA;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_LINEA AS

  /* INICIALIZACIÓN */
  PROCEDURE inicializar AS
  BEGIN

    /* Borrar contenido de la tabla */
      DELETE FROM factura_usuario;
      DELETE FROM bolsa;
      DELETE FROM pedido_usuario;
      DELETE FROM linea;
      DELETE FROM factura;
      DELETE FROM pedido;
      DELETE FROM envio;
      DELETE FROM nomina;
      DELETE FROM empleado;
      DELETE FROM usuario;
      DELETE FROM lote;
      DELETE FROM proveedor;
      DELETE FROM seccion;
      DELETE FROM almacen;
      DELETE FROM producto;
      DELETE FROM farmacia;
      DELETE FROM empresa;
      DELETE FROM contacto;
      DELETE FROM cuenta_bancaria;
      
    NULL;
  END inicializar;

/* PRUEBA PARA LA INSERCIÓN DE LINEA */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_cantidad LINEA.CANTIDAD%TYPE, P_lote LINEA.OID_LOTE%TYPE,
        P_pedido LINEA.OID_pedido%TYPE,P_producto LINEA.OID_producto%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_linea linea%ROWTYPE;
    w_oid_linea linea.OID_linea%TYPE;
  BEGIN
    
    /* Insertar linea */
    INSERT INTO linea (CANTIDAD, OID_LOTE, OID_pedido, OID_producto)
                VALUES    (P_cantidad, P_lote, P_pedido, P_producto);
    
    /* Seleccionar linea y comprobar que los datos se insertaron correctamente */
    w_oid_linea := sq_linea.currval;
    SELECT * INTO w_linea FROM linea WHERE oid_linea = w_oid_linea;
    IF (w_linea.CANTIDAD <> P_cantidad OR w_linea.OID_LOTE <> P_lote OR w_linea.OID_pedido <> P_pedido OR w_linea.OID_producto <> P_producto) THEN
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
  PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_linea LINEA.OID_LINEA%TYPE, P_cantidad LINEA.CANTIDAD%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_linea linea%ROWTYPE;
  BEGIN
    
    /* Actualizar linea */
    UPDATE linea SET cantidad = P_cantidad WHERE oid_linea=p_oid_linea;
    
    /* Seleccionar linea y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_linea FROM linea WHERE oid_linea=p_oid_linea;
    IF (p_linea.cantidad <> P_cantidad) THEN
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
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_linea LINEA.OID_LINEA%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_linea INTEGER;
  BEGIN
    
    /* Eliminar linea */
    DELETE FROM linea WHERE OID_linea = w_oid_linea;
    
    /* Verificar que la linea no se encuentra en la BD */
    SELECT COUNT(*) INTO n_linea FROM linea WHERE oID_linea = w_oid_linea;
    IF (n_linea <> 0) THEN
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

END PRUEBAS_LINEA;
/