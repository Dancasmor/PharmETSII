/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_BOLSA AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_oid_producto bolsa.oid_producto%TYPE,
    P_oid_pedido_usuario bolsa.oid_pedido_usuario%TYPE, P_cantidad bolsa.cantidad%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_bolsa bolsa.oid_bolsa%TYPE, P_cantidad bolsa.cantidad%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_bolsa bolsa.oid_bolsa%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_BOLSA;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_BOLSA AS

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

/* PRUEBA PARA LA INSERCIÓN DE BOLSA */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_oid_producto bolsa.oid_producto%TYPE,
    P_oid_pedido_usuario bolsa.oid_pedido_usuario%TYPE, P_cantidad bolsa.cantidad%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_bolsa bolsa%ROWTYPE;
    w_oid_bolsa bolsa.oid_bolsa%TYPE;
  BEGIN

    /* Insertar bolsa */
    crear_bolsa(P_oid_producto, P_oid_pedido_usuario, P_cantidad);
    
    /* Seleccionar bolsa y comprobar que los datos se insertaron correctamente */
    w_oid_bolsa := sq_bolsa.currval;
    SELECT * INTO w_bolsa FROM bolsa WHERE oid_bolsa = w_oid_bolsa;
    IF (w_bolsa.cantidad <> P_cantidad OR w_bolsa.oid_producto <> P_oid_producto OR w_bolsa.oid_pedido_usuario <> P_oid_pedido_usuario) THEN
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
  PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_bolsa bolsa.oid_bolsa%TYPE, P_cantidad bolsa.cantidad%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_bolsa bolsa%ROWTYPE;
  BEGIN
    
    /* Actualizar bolsa */
    cambiar_cantidad_bolsa(P_oid_bolsa, P_cantidad);
    
    /* Seleccionar bolsa y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO P_bolsa FROM bolsa WHERE oid_bolsa=P_oid_bolsa;
    IF (p_bolsa.cantidad <> P_cantidad) THEN
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
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_bolsa bolsa.oid_bolsa%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_bolsa INTEGER;
  BEGIN
    
    /* Eliminar bolsa */
    eliminar_bolsa(w_oid_bolsa);
    
    /* Verificar que la bolsa no se encuentra en la BD */
    SELECT COUNT(*) INTO n_bolsa FROM bolsa WHERE oid_bolsa = w_oid_bolsa;
    IF (n_bolsa <> 0) THEN
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

END PRUEBAS_BOLSA;
/