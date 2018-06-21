/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_factura_usuario AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, 
    P_oid_pedido_usuario factura_usuario.oid_pedido_usuario%TYPE, P_fecha_venta factura_usuario.fecha_venta%TYPE,
    P_oid_almacen factura_usuario.oid_almacen%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_factura_usuario factura_usuario.oid_factura_usuario%TYPE,
    P_enviado factura_usuario.enviado%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, P_oid_factura_usuario factura_usuario.oid_factura_usuario%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_factura_usuario;
/
show error

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_factura_usuario AS

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

/* PRUEBA PARA LA INSERCIÓN DE factura usuario */
  PROCEDURE insertar (nombre_prueba VARCHAR2,
    P_oid_pedido_usuario factura_usuario.oid_pedido_usuario%TYPE, P_fecha_venta factura_usuario.fecha_venta%TYPE,
    P_oid_almacen factura_usuario.oid_almacen%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_factura_usuario factura_usuario%ROWTYPE;
    w_oid_factura_usuario factura_usuario.oid_factura_usuario%TYPE;
  BEGIN

    /* Insertar factura usuario */
    crear_factura_usuario(P_oid_pedido_usuario, P_fecha_venta, P_oid_almacen);
    
    /* Seleccionar factura usuario y comprobar que los datos se insertaron correctamente */
    w_oid_factura_usuario := sq_factura_usuario.currval;
    SELECT * INTO w_factura_usuario FROM factura_usuario WHERE oid_factura_usuario = w_oid_factura_usuario;
    IF ( w_factura_usuario.oid_pedido_usuario <> P_oid_pedido_usuario OR w_factura_usuario.fecha_venta <> P_fecha_venta OR w_factura_usuario.oid_almacen <> P_oid_almacen) THEN
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
  PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_factura_usuario factura_usuario.oid_factura_usuario%TYPE,
    P_enviado factura_usuario.enviado%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_factura_usuario factura_usuario%ROWTYPE;
  BEGIN
    
    /* Actualizar factura usuario */
    set_enviado(P_oid_factura_usuario, P_enviado);
    
    /* Seleccionar factura usuario y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO P_factura_usuario FROM factura_usuario WHERE oid_factura_usuario=P_oid_factura_usuario;
    IF (p_factura_usuario.enviado <> P_enviado) THEN
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
  PROCEDURE eliminar (nombre_prueba VARCHAR2, P_oid_factura_usuario factura_usuario.oid_factura_usuario%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_factura_usuario INTEGER;
  BEGIN
    
    /* Eliminar factura usuario */
    eliminar_factura_usuario(P_oid_factura_usuario);
    
    /* Verificar que la factura usuario no se encuentra en la BD */
    SELECT COUNT(*) INTO n_factura_usuario FROM factura_usuario WHERE oid_factura_usuario = P_oid_factura_usuario;
    IF (n_factura_usuario <> 0) THEN
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

END PRUEBAS_factura_usuario;
/
show error