CREATE OR REPLACE PACKAGE PRUEBAS_FARMACIA AS 

   PROCEDURE inicializar;

   PROCEDURE insertar (   nombre_prueba VARCHAR2,
                          P_contacto farmacia.oid_contacto%TYPE, 
                          P_nombre farmacia.nombre%TYPE,
                          P_cuenta_bancaria farmacia.id_cuenta_bancaria%TYPE, 
                          salidaEsperada BOOLEAN);

   PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          w_oid_farmacia farmacia.oid_farmacia%TYPE,
                          P_nombre FARMACIA.NOMBRE%TYPE, 
                          salidaEsperada BOOLEAN); 

   PROCEDURE eliminar (   nombre_prueba VARCHAR2, 
                          w_oid_farmacia farmacia.oid_farmacia%TYPE, 
                          salidaEsperada BOOLEAN); 

END PRUEBAS_FARMACIA;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_FARMACIA AS

  PROCEDURE inicializar AS
  BEGIN

      DELETE FROM contacto;
      DELETE FROM cuenta_bancaria;
      DELETE FROM empresa;
      DELETE FROM farmacia;
      DELETE FROM producto;
      DELETE FROM almacen;
      DELETE FROM seccion;
      DELETE FROM farmacia;
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

  PROCEDURE insertar (  nombre_prueba VARCHAR2,
                          P_contacto farmacia.oid_contacto%TYPE, 
                          P_nombre farmacia.nombre%TYPE,
                          P_cuenta_bancaria farmacia.id_cuenta_bancaria%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_farmacia farmacia%ROWTYPE;
    w_oid_farmacia farmacia.oid_farmacia%TYPE;
  BEGIN

    insert INTO farmacia (oid_contacto, nombre, id_cuenta_bancaria) VALUES (P_contacto, P_nombre, P_cuenta_bancaria);

    w_oid_farmacia := sq_farmacia.currval;

    SELECT * INTO w_farmacia FROM farmacia WHERE oid_farmacia = w_oid_farmacia;

    IF (w_farmacia.nombre <> P_nombre OR w_farmacia.oid_contacto <> P_contacto
                OR P_cuenta_bancaria <> w_farmacia.id_cuenta_bancaria) THEN
      salida := false;
    END IF;

    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
    
  END insertar;

  PROCEDURE actualizar (  nombre_prueba VARCHAR2, 
                          w_oid_farmacia farmacia.oid_farmacia%TYPE,
                          P_nombre FARMACIA.NOMBRE%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_farmacia farmacia%ROWTYPE;
  BEGIN

    UPDATE farmacia SET nombre = p_nombre WHERE oid_farmacia=w_oid_farmacia;

    SELECT * INTO p_farmacia FROM farmacia WHERE oid_farmacia=w_oid_farmacia;
    IF (p_farmacia.nombre <> p_nombre) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END actualizar;

  PROCEDURE eliminar (    nombre_prueba VARCHAR2,
                          w_oid_farmacia farmacia.oid_farmacia%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_farmacia INTEGER;
  BEGIN

    eliminar_farmacia(w_oid_farmacia);

    SELECT COUNT(*) INTO n_farmacia FROM farmacia WHERE oid_farmacia=w_oid_farmacia;
    IF (n_farmacia <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_farmacia;
/