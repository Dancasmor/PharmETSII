/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_FACTURA AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_precio_envio FACTURA.PRECIO_ENVIO%TYPE, P_oid_pedido FACTURA.OID_PEDIDO%TYPE,
                    P_oid_envio FACTURA.OID_ENVIO%TYPE, P_oid_almacen FACTURA.OID_ALMACEN%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_factura FACTURA.OID_FACTURA%TYPE,P_precio_envio FACTURA.PRECIO_ENVIO%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_factura FACTURA.OID_FACTURA%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_FACTURA;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_FACTURA AS

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

/* PRUEBA PARA LA INSERCIÓN DE FACTURA */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_precio_envio FACTURA.PRECIO_ENVIO%TYPE, P_oid_pedido FACTURA.OID_PEDIDO%TYPE,
                    P_oid_envio FACTURA.OID_ENVIO%TYPE, P_oid_almacen FACTURA.OID_ALMACEN%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_factura factura%ROWTYPE;
    w_oid_factura factura.OID_factura%TYPE;
    w_pedido pedido%ROWTYPE;
  BEGIN
    
    /* Insertar factura */
    New_factura(P_precio_envio, P_oid_pedido, P_oid_almacen, P_oid_envio);
    
    /* Seleccionar factura y comprobar que los datos se insertaron correctamente */
    w_oid_factura := sq_factura.currval;
    SELECT * INTO w_factura FROM factura WHERE oid_factura = w_oid_factura;
    SELECT * INTO w_pedido FROM pedido WHERE oid_pedido = p_oid_pedido;
    IF (w_factura.PRECIO_ENVIO <> P_precio_envio OR w_factura.OID_PEDIDO <> P_oid_pedido OR w_factura.OID_ALMACEN <> P_oid_almacen 
                    OR w_factura.OID_ENVIO  <> P_oid_envio OR w_pedido.enviado <> 1) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE FACTURA */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_factura FACTURA.OID_FACTURA%TYPE,P_precio_envio FACTURA.PRECIO_ENVIO%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_factura factura%ROWTYPE;
  BEGIN
    
    /* Actualizar factura */
    UPDATE factura SET PRECIO_ENVIO = P_precio_envio WHERE oid_factura=p_oid_factura;
    
    /* Seleccionar factura y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_factura FROM factura WHERE oid_factura=p_oid_factura;
    IF (p_factura.PRECIO_ENVIO <> P_precio_envio ) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE FACTURA */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_factura FACTURA.OID_FACTURA%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_factura INTEGER;
  BEGIN
    
    /* Eliminar factura */
    DELETE FROM factura WHERE OID_factura = w_oid_factura;
    
    /* Verificar que el factura no se encuentra en la BD */
    SELECT COUNT(*) INTO n_factura FROM factura WHERE oid_factura=w_oid_factura;
    IF (n_factura <> 0) THEN
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

END PRUEBAS_FACTURA;
/