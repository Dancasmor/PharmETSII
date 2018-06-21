
/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_ENVIO AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_fecha_envio ENVIO.FECHA_ENVIO%TYPE, P_oid_proveedor ENVIO.OID_PROVEEDOR%TYPE,
        P_oid_almacen ENVIO.OID_ALMACEN%TYPE, P_esproveedor ENVIO.ESPROVEEDOR%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_envio envio.OID_envio%TYPE,P_fecha_envio ENVIO.FECHA_ENVIO%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_envio envio.OID_envio%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_ENVIO;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_ENVIO AS

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

/* PRUEBA PARA LA INSERCIÓN DE ENVIO */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_fecha_envio ENVIO.FECHA_ENVIO%TYPE, P_oid_proveedor ENVIO.OID_PROVEEDOR%TYPE,
        P_oid_almacen ENVIO.OID_ALMACEN%TYPE, P_esproveedor ENVIO.ESPROVEEDOR%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_envio envio%ROWTYPE;
    w_oid_envio envio.OID_envio%TYPE;
  BEGIN
    
    /* Insertar envio */
    INSERT INTO envio (FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
                VALUES    (P_fecha_envio, P_oid_proveedor, P_oid_almacen, P_esproveedor);
    
    /* Seleccionar envio y comprobar que los datos se insertaron correctamente */
    w_oid_envio := sq_envio.currval;
    SELECT * INTO w_envio FROM envio WHERE oid_envio = w_oid_envio;
    IF (w_envio.FECHA_ENVIO <> P_fecha_envio OR w_envio.OID_PROVEEDOR <> P_oid_proveedor OR w_envio.OID_ALMACEN <> P_oid_almacen
                OR w_envio.ESPROVEEDOR <> P_esproveedor) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE ENVIO */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_envio envio.OID_envio%TYPE,P_fecha_envio ENVIO.FECHA_ENVIO%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_envio envio%ROWTYPE;
  BEGIN
    
    /* Actualizar envio */
    UPDATE envio SET fecha_envio = P_fecha_envio WHERE oid_envio = P_oid_envio;
    
    /* Seleccionar envio y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_envio FROM envio WHERE oid_envio=p_oid_envio;
    IF (p_envio.fecha_envio = P_fecha_envio) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE ENVIO */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_envio envio.OID_envio%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_envio INTEGER;
  BEGIN
    
    /* Eliminar envio */
    DELETE FROM envio WHERE OID_envio = w_oid_envio;
    
    /* Verificar que el envio no se encuentra en la BD */
    SELECT COUNT(*) INTO n_envio FROM envio  WHERE oid_envio=w_oid_envio;
    IF (n_envio <> 0) THEN
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

END PRUEBAS_ENVIO;
/