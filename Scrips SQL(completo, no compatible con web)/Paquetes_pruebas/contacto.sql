CREATE OR REPLACE PACKAGE PRUEBAS_CONTACTO AS 

   PROCEDURE inicializar;

   PROCEDURE insertar (   nombre_prueba VARCHAR2, 
                          P_telefono IN contacto.telefono%TYPE, 
                          P_email IN contacto.email%TYPE, 
                          P_direccion IN contacto.direccion%TYPE,
                          P_codigo_postal IN contacto.codigo_postal%TYPE, 
                          P_ciudad IN contacto.ciudad%TYPE,
                          salidaEsperada BOOLEAN);

   PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          w_oid_contacto contacto.oid_contacto%TYPE, 
                          P_telefono contacto.telefono%TYPE, 
                          P_email contacto.email%TYPE, 
                          P_direccion contacto.direccion%TYPE,
                          P_codigo_postal contacto.codigo_postal%TYPE, 
                          P_ciudad contacto.ciudad%TYPE, 
                          salidaEsperada BOOLEAN); 

   PROCEDURE eliminar (   nombre_prueba VARCHAR2, 
                          w_oid_contacto contacto.oid_contacto%TYPE, 
                          salidaEsperada BOOLEAN); 

END PRUEBAS_contacto;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_contacto AS

  PROCEDURE inicializar AS
  BEGIN
      
      DELETE FROM factura_usuario;
      DELETE FROM bolsa;
      DELETE FROM pedido_usuario;
      DELETE FROM linea;
      DELETE FROM factura;
      DELETE FROM pedido;
      DELETE FROM envio;
      DELETE FROM nomina;
      DELETE FROM empleado;
      DELETE FROM usuario;
      DELETE FROM lote;
      DELETE FROM proveedor;
      DELETE FROM seccion;
      DELETE FROM almacen;
      DELETE FROM producto;
      DELETE FROM farmacia;
      DELETE FROM empresa;
      DELETE FROM contacto;
      DELETE FROM cuenta_bancaria;
      
    NULL;
  END inicializar;

  PROCEDURE insertar (     nombre_prueba VARCHAR2, 
                          P_telefono IN contacto.telefono%TYPE, 
                          P_email IN contacto.email%TYPE, 
                          P_direccion IN contacto.direccion%TYPE,
                          P_codigo_postal IN contacto.codigo_postal%TYPE, 
                          P_ciudad IN contacto.ciudad%TYPE,
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_contacto contacto%ROWTYPE;
    w_oid_contacto contacto.oid_contacto%TYPE;
  BEGIN

    INSERT INTO contacto (telefono, email, direccion, codigo_postal, ciudad) VALUES(P_telefono, P_email, P_direccion, P_codigo_postal, P_ciudad);

    w_oid_contacto := sq_contacto.currval;
    
    SELECT * INTO w_contacto FROM contacto WHERE oid_contacto = w_oid_contacto;

    IF (w_contacto.telefono <> P_telefono OR w_contacto.email <> P_email OR w_contacto.direccion <> P_direccion
                OR P_codigo_postal <> w_contacto.codigo_postal OR P_ciudad <> w_contacto.ciudad) THEN
      salida := false;
    END IF;

    COMMIT;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END insertar;

  PROCEDURE actualizar (  nombre_prueba VARCHAR2, 
                          w_oid_contacto contacto.oid_contacto%TYPE, 
                          P_telefono contacto.telefono%TYPE, 
                          P_email contacto.email%TYPE, 
                          P_direccion contacto.direccion%TYPE,
                          P_codigo_postal contacto.codigo_postal%TYPE, 
                          P_ciudad contacto.ciudad%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_contacto contacto%ROWTYPE;
  BEGIN

    UPDATE contacto SET telefono = P_telefono, email = P_email,
                 direccion = P_direccion, codigo_postal = P_codigo_postal, ciudad = P_ciudad WHERE oid_contacto=w_oid_contacto;

    SELECT * INTO p_contacto FROM contacto WHERE oid_contacto=w_oid_contacto;
    IF (p_contacto.telefono <> P_telefono OR p_contacto.email <> P_email OR p_contacto.direccion <> P_direccion
                OR P_codigo_postal <> p_contacto.codigo_postal OR P_ciudad <> p_contacto.ciudad) THEN
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
                          w_oid_contacto contacto.oid_contacto%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_contacto INTEGER;
  BEGIN

    DELETE FROM contacto WHERE oid_contacto = w_oid_contacto;

    SELECT COUNT(*) INTO n_contacto FROM contacto WHERE oid_contacto=w_oid_contacto;
    IF (n_contacto <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_contacto;
/