CREATE OR REPLACE PACKAGE PRUEBAS_empresa AS 

   PROCEDURE inicializar;

   PROCEDURE insertar (   nombre_prueba VARCHAR2, 
                          P_nombre empresa.nombre%TYPE,
                          P_contacto empresa.oid_contacto%TYPE, 
                          P_cuenta EMPRESA.ID_CUENTA_BANCARIA%TYPE,
                          salidaEsperada BOOLEAN);

   PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          w_oid_empresa empresa.oid_empresa%TYPE, 
                          P_nombre empresa.nombre%TYPE,
                          salidaEsperada BOOLEAN); 

   PROCEDURE eliminar (   nombre_prueba VARCHAR2, 
                          w_oid_empresa empresa.oid_empresa%TYPE, 
                          salidaEsperada BOOLEAN); 

END PRUEBAS_empresa;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_empresa AS

  PROCEDURE inicializar AS
  BEGIN

      DELETE FROM empresa;
      DELETE FROM cuenta_bancaria;
      DELETE FROM empresa;
      DELETE FROM empresa;
      DELETE FROM producto;
      DELETE FROM almacen;
      DELETE FROM seccion;
      DELETE FROM empresa;
      DELETE FROM lote;
      DELETE FROM empresa;
      DELETE FROM empresa;
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

  PROCEDURE insertar ( nombre_prueba VARCHAR2, 
                          P_nombre empresa.nombre%TYPE,
                          P_contacto empresa.oid_contacto%TYPE, 
                          P_cuenta EMPRESA.ID_CUENTA_BANCARIA%TYPE,
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_empresa empresa%ROWTYPE;
    w_oid_empresa empresa.oid_empresa%TYPE;
  BEGIN

    INSERT INTO empresa (nombre, oid_contacto, id_cuenta_bancaria) VALUES(P_nombre, P_contacto, P_cuenta);

    w_oid_empresa := sq_empresa.currval;

    SELECT * INTO w_empresa FROM empresa WHERE oid_empresa = w_oid_empresa;

    IF (w_empresa.nombre <> P_nombre OR P_contacto <> w_empresa.oid_contacto) THEN
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
                          w_oid_empresa empresa.oid_empresa%TYPE, 
                          P_nombre empresa.nombre%TYPE,
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_empresa empresa%ROWTYPE;
  BEGIN

    UPDATE empresa SET nombre = P_nombre WHERE oid_empresa=w_oid_empresa;

    SELECT * INTO p_empresa FROM empresa WHERE oid_empresa=w_oid_empresa;
    IF (p_empresa.nombre <> P_nombre) THEN
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
                          w_oid_empresa empresa.oid_empresa%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_empresa INTEGER;
  BEGIN

    DELETE FROM empresa WHERE oid_empresa = w_oid_empresa;

    SELECT COUNT(*) INTO n_empresa FROM empresa WHERE oid_empresa=w_oid_empresa;
    IF (n_empresa <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_empresa;
/