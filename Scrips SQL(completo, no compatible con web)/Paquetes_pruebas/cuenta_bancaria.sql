/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_CUENTA_BANCARIA AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_id_cuenta_bancaria cuenta_bancaria.id_cuenta_bancaria%TYPE, P_titular cuenta_bancaria.titular%TYPE, 
   P_dinero_disponible cuenta_bancaria.dinero_disponible%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2,P_id_cuenta_bancaria cuenta_bancaria.id_cuenta_bancaria%TYPE, P_dinero_disponible cuenta_bancaria.dinero_disponible%TYPE,
                                                    salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_id_cuenta_bancaria cuenta_bancaria.id_cuenta_bancaria%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_CUENTA_BANCARIA;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_CUENTA_BANCARIA AS

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

/* PRUEBA PARA LA INSERCIÓN DE CUENTA BANCARIA */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_id_cuenta_bancaria CUENTA_BANCARIA.ID_CUENTA_BANCARIA%TYPE, P_titular cuenta_bancaria.titular%TYPE, 
   P_dinero_disponible cuenta_bancaria.dinero_disponible%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_cuenta_bancaria cuenta_bancaria%ROWTYPE;
  BEGIN
    
    /* Insertar cuenta bancaria */
    New_cuenta_bancaria(P_id_cuenta_bancaria, P_titular, P_dinero_disponible);
    
    /* Seleccionar almacen y comprobar que los datos se insertaron correctamente */    
    SELECT * INTO w_cuenta_bancaria FROM cuenta_bancaria WHERE id_cuenta_bancaria = p_id_cuenta_bancaria;
    IF (w_cuenta_bancaria.id_cuenta_bancaria <> P_id_cuenta_bancaria OR w_cuenta_bancaria.titular <> P_titular OR 
    w_cuenta_bancaria.dinero_disponible <> P_dinero_disponible) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE CUENTA BANCARIA */
  PROCEDURE actualizar (nombre_prueba VARCHAR2,P_id_cuenta_bancaria cuenta_bancaria.id_cuenta_bancaria%TYPE, P_dinero_disponible cuenta_bancaria.dinero_disponible%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    P_cuenta_bancaria cuenta_bancaria%ROWTYPE;
  BEGIN
    
    /* Actualizar cuenta bancaria */
    UPDATE cuenta_bancaria SET dinero_disponible = P_dinero_disponible WHERE id_cuenta_bancaria = P_id_cuenta_bancaria;
    
    /* Seleccionar cuenta bancaria y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO P_cuenta_bancaria FROM cuenta_bancaria WHERE id_cuenta_bancaria=p_id_cuenta_bancaria;
    IF (P_cuenta_bancaria.dinero_disponible <> P_dinero_disponible ) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE CUENTA BANCARIA */
  PROCEDURE eliminar (nombre_prueba VARCHAR2, w_id_cuenta_bancaria cuenta_bancaria.id_cuenta_bancaria%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_cuenta_bancaria INTEGER;
  BEGIN
    
    /* Eliminar cuenta bancaria */
    delete_cuenta_bancaria(w_id_cuenta_bancaria);
    
    /* Verificar que la cuenta bancaria no se encuentra en la BD */
    SELECT COUNT(*) INTO n_cuenta_bancaria FROM cuenta_bancaria WHERE id_cuenta_bancaria=w_id_cuenta_bancaria;
    IF (n_cuenta_bancaria <> 0) THEN
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

END PRUEBAS_CUENTA_BANCARIA;
/