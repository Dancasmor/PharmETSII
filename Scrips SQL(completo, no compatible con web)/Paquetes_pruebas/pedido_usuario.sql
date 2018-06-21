/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_pedido_usuario AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_dni_usuario pedido_usuario.dni_usuario%TYPE,
    P_fecha_solicitud pedido_usuario.fecha_solicitud%TYPE,P_contrareembolso_tarjeta pedido_usuario.contrareembolso_tarjeta%TYPE,
    P_tarjeta pedido_usuario.tarjeta%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_pedido_usuario pedido_usuario.oid_pedido_usuario%TYPE,
    P_preparado pedido_usuario.preparado%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2,P_oid_pedido_usuario pedido_usuario.oid_pedido_usuario%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_pedido_usuario;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_pedido_usuario AS

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

/* PRUEBA PARA LA INSERCIÓN DE pedido_usuario */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_dni_usuario pedido_usuario.dni_usuario%TYPE,
    P_fecha_solicitud pedido_usuario.fecha_solicitud%TYPE,P_contrareembolso_tarjeta pedido_usuario.contrareembolso_tarjeta%TYPE,
    P_tarjeta pedido_usuario.tarjeta%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_pedido_usuario pedido_usuario%ROWTYPE;
    w_oid_pedido_usuario pedido_usuario.oid_pedido_usuario%TYPE;
  BEGIN

    /* Insertar pedido_usuario */
    crear_pedido_usuario(P_dni_usuario, P_fecha_solicitud, P_contrareembolso_tarjeta, P_tarjeta);
    
    /* Seleccionar pedido usuario y comprobar que los datos se insertaron correctamente */
    w_oid_pedido_usuario := sq_pedido_usuario.currval;
    SELECT * INTO w_pedido_usuario FROM pedido_usuario WHERE oid_pedido_usuario = w_oid_pedido_usuario;
    IF (w_pedido_usuario.dni_usuario <> P_dni_usuario OR w_pedido_usuario.fecha_solicitud <> P_fecha_solicitud OR w_pedido_usuario.contrareembolso_tarjeta <> P_contrareembolso_tarjeta OR w_pedido_usuario.tarjeta <> P_tarjeta) THEN
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
  PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_pedido_usuario pedido_usuario.oid_pedido_usuario%TYPE,
    P_preparado pedido_usuario.preparado%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_pedido_usuario pedido_usuario%ROWTYPE;
  BEGIN
    
    /* Actualizar pedido usuario */
    set_preparado(P_oid_pedido_usuario, P_preparado);
    
    /* Seleccionar pedido usuario y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO P_pedido_usuario FROM pedido_usuario WHERE oid_pedido_usuario=P_oid_pedido_usuario;
    IF (p_pedido_usuario.preparado <> P_preparado) THEN
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
  PROCEDURE eliminar (nombre_prueba VARCHAR2,P_oid_pedido_usuario pedido_usuario.oid_pedido_usuario%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_pedido_usuario INTEGER;
  BEGIN
    
    /* Eliminar pedido usuario */
    eliminar_pedido_usuario(P_oid_pedido_usuario);
    
    /* Verificar que la pedido usuario no se encuentra en la BD */
    SELECT COUNT(*) INTO n_pedido_usuario FROM pedido_usuario WHERE oid_pedido_usuario = P_oid_pedido_usuario;
    IF (n_pedido_usuario <> 0) THEN
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

END PRUEBAS_pedido_usuario;
/
show error