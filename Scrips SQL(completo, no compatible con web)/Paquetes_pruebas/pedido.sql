/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_PEDIDO AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_esproveedor PEDIDO.ESPROVEEDOR%TYPE, P_oid_almacen PEDIDO.OID_ALMACEN%TYPE,P_oid_almacen2 PEDIDO.OID_ALMACEN2%TYPE,
                        P_oid_proveedor PEDIDO.OID_PROVEEDOR%TYPE,salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, w_oid_pedido pedido.OID_pedido%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_pedido pedido.OID_pedido%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_PEDIDO;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_PEDIDO AS

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

/* PRUEBA PARA LA INSERCIÓN DE PEDIDO */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_esproveedor PEDIDO.ESPROVEEDOR%TYPE, P_oid_almacen PEDIDO.OID_ALMACEN%TYPE,P_oid_almacen2 PEDIDO.OID_ALMACEN2%TYPE,
                        P_oid_proveedor PEDIDO.OID_PROVEEDOR%TYPE,salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_pedido pedido%ROWTYPE;
    w_oid_pedido pedido.OID_pedido%TYPE;
  BEGIN
    
    /* Insertar pedido */
    INSERT INTO pedido (ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
                VALUES    (P_esproveedor, P_oid_almacen, P_oid_almacen2, P_oid_proveedor);
    
    /* Seleccionar pedido y comprobar que los datos se insertaron correctamente */
    w_oid_pedido := sq_pedido.currval;
    SELECT * INTO w_pedido FROM pedido WHERE oid_pedido = w_oid_pedido;
    IF (w_pedido.ESPROVEEDOR <> P_esproveedor OR w_pedido.OID_ALMACEN <> P_oid_almacen 
    OR w_pedido.OID_ALMACEN2 <> P_oid_almacen2 OR w_pedido.OID_PROVEEDOR <> P_oid_proveedor) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE PEDIDO */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, w_oid_pedido pedido.OID_pedido%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_pedido pedido%ROWTYPE;
  BEGIN
    
    /* Actualizar pedido */
    ENVIAR_PEDIDO(w_oid_pedido);
    
    /* Seleccionar pedido y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_pedido FROM pedido WHERE oid_pedido=w_oid_pedido;
    IF (p_pedido.enviado <> 1) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE PEDIDO */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_pedido pedido.OID_pedido%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_pedido INTEGER;
  BEGIN
    
    /* Eliminar pedido */
    delete_pedido(w_oid_pedido);
    
    /* Verificar que el pedido no se encuentra en la BD */
    SELECT COUNT(*) INTO n_pedido FROM pedido WHERE oid_pedido=w_oid_pedido;
    IF (n_pedido <> 0) THEN
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

END PRUEBAS_PEDIDO;
/