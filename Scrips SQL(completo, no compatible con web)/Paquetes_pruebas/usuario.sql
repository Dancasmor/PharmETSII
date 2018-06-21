CREATE OR REPLACE PACKAGE PRUEBAS_USUARIO AS 

   PROCEDURE inicializar;

   PROCEDURE insertar (   nombre_prueba VARCHAR2, 
                          P_dni USUARIO.DNI_USUARIO%TYPE, 
                          P_nombre USUARIO.NOMBRE%TYPE, 
                          P_apellidos USUARIO.APELLIDOS%TYPE,
                          P_fecha_nacimiento USUARIO.FECHA_NACIMIENTO%TYPE, 
                          P_contacto USUARIO.OID_CONTACTO%TYPE,
                          P_fecha_alta USUARIO.FECHA_ALTA_SISTEMA%TYPE, 
                          P_empresa USUARIO.OID_EMPRESA%TYPE, 
                          P_contrasenya USUARIO.CONTRASENYA%TYPE,
                          P_puntos USUARIO.PUNTOS%TYPE, 
                          P_peso USUARIO.PESO%TYPE,
                          P_altura USUARIO.ALTURA%TYPE,
                          salidaEsperada BOOLEAN);

   PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          P_dni usuario.dni_usuario%TYPE, 
                          P_nombre usuario.nombre%TYPE, 
                          P_apellidos usuario.apellidos%TYPE,
                          P_fecha_baja USUARIO.FECHA_baja_SISTEMA%TYPE, 
                          P_contrasenya usuario.contrasenya%TYPE,
                          P_puntos usuario.puntos%TYPE, 
                          P_peso usuario.peso%TYPE,
                          P_altura usuario.altura%TYPE,
                          salidaEsperada BOOLEAN); 

   PROCEDURE eliminar (   nombre_prueba VARCHAR2, 
                          w_dni_usuario usuario.dni_usuario%TYPE, 
                          salidaEsperada BOOLEAN); 

END PRUEBAS_usuario;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_usuario AS

  PROCEDURE inicializar AS
  BEGIN

      DELETE FROM usuario;
      DELETE FROM cuenta_bancaria;
      DELETE FROM empresa;
      DELETE FROM usuario;
      DELETE FROM producto;
      DELETE FROM almacen;
      DELETE FROM seccion;
      DELETE FROM usuario;
      DELETE FROM lote;
      DELETE FROM usuario;
      DELETE FROM usuario;
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

  PROCEDURE insertar (    nombre_prueba VARCHAR2, 
                          P_dni USUARIO.DNI_USUARIO%TYPE, 
                          P_nombre USUARIO.NOMBRE%TYPE, 
                          P_apellidos USUARIO.APELLIDOS%TYPE,
                          P_fecha_nacimiento USUARIO.FECHA_NACIMIENTO%TYPE, 
                          P_contacto USUARIO.OID_CONTACTO%TYPE,
                          P_fecha_alta USUARIO.FECHA_ALTA_SISTEMA%TYPE, 
                          P_empresa USUARIO.OID_EMPRESA%TYPE, 
                          P_contrasenya USUARIO.CONTRASENYA%TYPE,
                          P_puntos USUARIO.PUNTOS%TYPE, 
                          P_peso USUARIO.PESO%TYPE,
                          P_altura USUARIO.ALTURA%TYPE,
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_usuario usuario%ROWTYPE;
  BEGIN

    nuevo_usuario(P_dni, P_nombre, P_apellidos, P_fecha_nacimiento, P_contacto, P_fecha_alta, P_empresa, P_contrasenya, P_puntos, P_peso, P_altura);

    SELECT * INTO w_usuario FROM usuario WHERE dni_usuario = p_dni;

    IF (w_usuario.dni_usuario <> P_dni OR w_usuario.nombre <> P_nombre OR w_usuario.apellidos <> P_apellidos
                OR P_fecha_nacimiento <> w_usuario.fecha_nacimiento OR P_contacto <> w_usuario.oid_contacto OR P_fecha_alta <> w_usuario.fecha_alta_sistema
                OR P_empresa <> w_usuario.oid_empresa OR P_contrasenya <> w_usuario.contrasenya OR P_puntos <> w_usuario.puntos OR P_peso <> w_usuario.peso OR P_altura <> w_usuario.altura) THEN
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
                          P_dni usuario.dni_usuario%TYPE, 
                          P_nombre usuario.nombre%TYPE, 
                          P_apellidos usuario.apellidos%TYPE,
                          P_fecha_baja USUARIO.FECHA_baja_SISTEMA%TYPE, 
                          P_contrasenya usuario.contrasenya%TYPE,
                          P_puntos usuario.puntos%TYPE, 
                          P_peso usuario.peso%TYPE,
                          P_altura usuario.altura%TYPE,
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_usuario usuario%ROWTYPE;
  BEGIN

    UPDATE usuario SET dni_usuario = P_dni, 
                         nombre= P_nombre , 
                         apellidos = P_apellidos ,
                         FECHA_baja_SISTEMA = P_fecha_baja, 
                         contrasenya = P_contrasenya,
                         puntos = P_puntos, 
                         peso = P_peso,
                         altura =  P_altura WHERE dni_usuario=p_dni;

    SELECT * INTO p_usuario FROM usuario WHERE dni_usuario=p_dni;
    IF (p_usuario.dni_usuario <> P_dni OR p_usuario.nombre <> P_nombre OR p_usuario.apellidos <> P_apellidos OR p_usuario.fecha_baja_sistema <> P_fecha_baja
               OR P_contrasenya <> p_usuario.contrasenya OR P_puntos <> p_usuario.puntos OR P_peso <> p_usuario.peso OR P_altura <> p_usuario.altura) THEN
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
                          w_dni_usuario usuario.dni_usuario%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_usuario INTEGER;
  BEGIN

    eliminar_usuario(w_dni_usuario);

    SELECT COUNT(*) INTO n_usuario FROM usuario WHERE dni_usuario=w_dni_usuario;
    IF (n_usuario <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_usuario;
/