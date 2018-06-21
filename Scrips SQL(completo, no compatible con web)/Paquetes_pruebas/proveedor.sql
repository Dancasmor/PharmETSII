/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_PROVEEDOR AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_lab proveedor.nombre_lab%TYPE, P_pre_sin PROVEEDOR.PRECIO_ENVIO_SIN_GASTOS%TYPE,
                    P_contacto PROVEEDOR.OID_CONTACTO%TYPE, P_contra Proveedor.contraseña%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, w_oid_proveedor proveedor.OID_proveedor%TYPE, P_lab proveedor.NOMBRE_LAB%TYPE, P_pre_sin PROVEEDOR.PRECIO_ENVIO_SIN_GASTOS%TYPE,
                    P_contacto PROVEEDOR.OID_CONTACTO%TYPE, P_contra Proveedor.contraseña%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_proveedor proveedor.OID_proveedor%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_PROVEEDOR;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_PROVEEDOR AS

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

/* PRUEBA PARA LA INSERCIÓN DE PROVEEDOR */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_lab proveedor.nombre_lab%TYPE, P_pre_sin PROVEEDOR.PRECIO_ENVIO_SIN_GASTOS%TYPE,
                    P_contacto PROVEEDOR.OID_CONTACTO%TYPE, P_contra Proveedor.contraseña%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_proveedor proveedor%ROWTYPE;
    w_oid_proveedor proveedor.OID_proveedor%TYPE;
  BEGIN
    
    /* Insertar proveedor */
    New_proveedor(P_lab, P_pre_sin, P_contacto, P_contra);
    
    /* Seleccionar proveedor y comprobar que los datos se insertaron correctamente */
    w_oid_proveedor := sq_proveedor.currval;
    SELECT * INTO w_proveedor FROM proveedor WHERE oid_proveedor = w_oid_proveedor;
    IF (w_proveedor.nombre_lab <> P_lab OR w_proveedor.PRECIO_ENVIO_SIN_GASTOS <> P_pre_sin OR w_proveedor.OID_CONTACTO <> P_contacto
                OR P_contra <> w_proveedor.contraseña) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE PROVEEDOR */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, w_oid_proveedor proveedor.OID_proveedor%TYPE, P_lab proveedor.NOMBRE_LAB%TYPE, P_pre_sin PROVEEDOR.PRECIO_ENVIO_SIN_GASTOS%TYPE,
                    P_contacto PROVEEDOR.OID_CONTACTO%TYPE, P_contra Proveedor.contraseña%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_proveedor proveedor%ROWTYPE;
  BEGIN
    
    /* Actualizar proveedor */
    UPDATE proveedor SET NOMBRE_LAB = P_lab, PRECIO_ENVIO_SIN_GASTOS = P_pre_sin,
                 OID_CONTACTO = P_contacto, contraseña = P_contra WHERE oid_proveedor=w_oid_proveedor;
    
    /* Seleccionar proveedor y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_proveedor FROM proveedor WHERE oid_proveedor=w_oid_proveedor;
    IF (p_proveedor.nombre_lab <> P_lab OR p_proveedor.PRECIO_ENVIO_SIN_GASTOS <> P_pre_sin OR
                 p_proveedor.OID_CONTACTO <> P_contacto OR p_proveedor.contraseña <> P_contra) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE PROVEEDOR */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_proveedor proveedor.OID_proveedor%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_proveedor INTEGER;
  BEGIN
    
    /* Eliminar seccion */
    delete_proveedor(w_oid_proveedor);
    
    /* Verificar que el proveedor no se encuentra en la BD */
    SELECT COUNT(*) INTO n_proveedor FROM proveedor WHERE oid_proveedor=w_oid_proveedor;
    IF (n_proveedor <> 0) THEN
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

END PRUEBAS_PROVEEDOR;
/