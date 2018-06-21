
/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_ALMACEN AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, w_almacen_general ALMACEN.ALMACEN_GENERAL%TYPE, w_oid_empresa ALMACEN.OID_EMPRESA%TYPE,
                                w_oid_farmacia ALMACEN.OID_FARMACIA%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_almacen ALMACEN.OID_almacen%TYPE, p_almacen_general ALMACEN.ALMACEN_GENERAL%TYPE, 
            p_oid_empresa ALMACEN.OID_EMPRESA%TYPE, p_oid_farmacia ALMACEN.OID_FARMACIA%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_almacen ALMACEN.OID_ALMACEN%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_ALMACEN;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_ALMACEN AS

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

/* PRUEBA PARA LA INSERCIÓN DE ALMACEN */
  PROCEDURE insertar (nombre_prueba VARCHAR2, w_almacen_general ALMACEN.ALMACEN_GENERAL%TYPE, w_oid_empresa ALMACEN.OID_EMPRESA%TYPE,
                                w_oid_farmacia ALMACEN.OID_FARMACIA%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_almacen almacen%ROWTYPE;
    w_oid_almacen ALMACEN.OID_ALMACEN%TYPE;
  BEGIN
    
    /* Insertar almacen */
    New_almacen(w_almacen_general, w_oid_empresa, w_oid_farmacia);
    
    /* Seleccionar almacen y comprobar que los datos se insertaron correctamente */
    w_oid_almacen := sq_almacen.currval;
    SELECT * INTO w_almacen FROM almacen WHERE oid_almacen = w_oid_almacen;
    IF (w_almacen.almacen_general<>w_almacen_general OR w_almacen.oid_empresa<>w_oid_empresa OR w_almacen.oid_farmacia<>w_oid_farmacia ) THEN
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

/* PRUEBA PARA LA ACTUALIZACIÓN DE ALMACEN */
  PROCEDURE actualizar (nombre_prueba VARCHAR2,p_oid_almacen ALMACEN.OID_almacen%TYPE, p_almacen_general ALMACEN.ALMACEN_GENERAL%TYPE, 
            p_oid_empresa ALMACEN.OID_EMPRESA%TYPE, p_oid_farmacia ALMACEN.OID_FARMACIA%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_almacen almacen%ROWTYPE;
  BEGIN
    
    /* Actualizar almacen */
    UPDATE almacen SET almacen_general = p_almacen_general, oid_empresa = p_oid_empresa,
                 oid_farmacia = p_oid_farmacia WHERE oid_almacen=p_oid_almacen;
    
    /* Seleccionar almacen y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_almacen FROM almacen WHERE oid_almacen=p_oid_almacen;
    IF (p_almacen.almacen_general <> p_almacen_general OR p_almacen.oid_empresa <> p_oid_empresa OR
                 p_almacen.oid_farmacia <> p_oid_farmacia) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE ALMACENES */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_almacen ALMACEN.OID_ALMACEN%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_almacen INTEGER;
  BEGIN
    
    /* Eliminar almacen */
    delete_almacen(w_oid_almacen);
    
    /* Verificar que el almacen no se encuentra en la BD */
    SELECT COUNT(*) INTO n_almacen FROM almacen WHERE oid_almacen=w_oid_almacen;
    IF (n_almacen <> 0) THEN
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

END PRUEBAS_ALMACEN;
/
