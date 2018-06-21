/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_LOTE AS

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_cantidad LOTE.CANTIDAD_LOTE%TYPE, P_precio LOTE.PRECIO_LOTE%TYPE,P_proveedor LOTE.OID_PROVEEDOR%TYPE,
                    P_producto LOTE.OID_PRODUCTO%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_lote lote.OID_lote%TYPE,P_cantidad LOTE.CANTIDAD_LOTE%TYPE, P_precio LOTE.PRECIO_LOTE%TYPE,
             P_proveedor LOTE.OID_PROVEEDOR%TYPE, P_producto LOTE.OID_PRODUCTO%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_lote lote.OID_lote%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_LOTE;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_LOTE AS

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

/* PRUEBA PARA LA INSERCIÓN DE LOTE */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_cantidad LOTE.CANTIDAD_LOTE%TYPE, P_precio LOTE.PRECIO_LOTE%TYPE,P_proveedor LOTE.OID_PROVEEDOR%TYPE,
    P_producto LOTE.OID_PRODUCTO%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_lote lote%ROWTYPE;
    w_oid_lote lote.OID_lote%TYPE;
  BEGIN
    
    /* Insertar lote */
    New_lote(P_cantidad, P_precio, P_proveedor, P_producto);
    
    /* Seleccionar lote y comprobar que los datos se insertaron correctamente */
    w_oid_lote := sq_lote.currval;
    SELECT * INTO w_lote FROM lote WHERE oid_lote = w_oid_lote;
    IF (w_lote.CANTIDAD_LOTE <> P_cantidad OR w_lote.PRECIO_LOTE <> P_precio OR 
            w_lote.OID_PROVEEDOR <> P_proveedor OR w_lote.OID_PRODUCTO <> P_producto) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE LOTE */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, p_oid_lote lote.OID_lote%TYPE,P_cantidad LOTE.CANTIDAD_LOTE%TYPE,
                        P_precio LOTE.PRECIO_LOTE%TYPE,P_proveedor LOTE.OID_PROVEEDOR%TYPE,
    P_producto LOTE.OID_PRODUCTO%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_lote lote%ROWTYPE;
  BEGIN
    
    /* Actualizar lote */
    UPDATE lote SET OID_PRODUCTO = P_producto, CANTIDAD_LOTE = P_cantidad,
                 PRECIO_LOTE = P_precio, OID_PROVEEDOR = P_proveedor WHERE oid_lote=p_oid_lote;
    
    /* Seleccionar lote y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO p_lote FROM lote WHERE oid_lote=p_oid_lote;
    IF (p_lote.OID_PRODUCTO = P_producto OR p_lote.CANTIDAD_LOTE = P_cantidad OR
                 p_lote.PRECIO_LOTE = P_precio OR p_lote.OID_PROVEEDOR = P_proveedor) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE LOTE*/
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_lote lote.OID_lote%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_lote INTEGER;
  BEGIN
    
    /* Eliminar lote */
    delete_lote(w_oid_lote);
    
    /* Verificar que el lote no se encuentra en la BD */
    SELECT COUNT(*) INTO n_lote FROM lote WHERE oid_lote=w_oid_lote;
    IF (n_lote <> 0) THEN
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

END PRUEBAS_LOTE;
/