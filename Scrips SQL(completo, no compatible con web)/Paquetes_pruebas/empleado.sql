CREATE OR REPLACE PACKAGE PRUEBAS_EMPLEADO AS 

   PROCEDURE inicializar;

   PROCEDURE insertar (   nombre_prueba VARCHAR2, 
                          p_dni empleado.dni_empleado%TYPE,
                          P_nombre empleado.nombre%TYPE, 
                          P_apellidos empleado.apellidos%TYPE,
                          P_fecha_nacimiento empleado.fecha_nacimiento%TYPE, 
                          P_contacto empleado.oid_contacto%TYPE,
                          P_fecha_alta empleado.fecha_alta_sistema%TYPE, 
                          P_farmacia empleado.oid_farmacia%TYPE,
                          P_empresa empleado.oid_empresa%TYPE, 
                          P_contrasenya empleado.contrasenya%TYPE,
                          P_cargo empleado.cargo%TYPE, 
                          salidaEsperada BOOLEAN);

   PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          w_dni empleado.dni_empleado%TYPE, 
                          P_nombre empleado.nombre%TYPE, 
                          P_apellidos empleado.apellidos%TYPE,
                          P_fecha_baja empleado.fecha_baja_sistema%TYPE,
                          P_farmacia empleado.oid_farmacia%TYPE, 
                          P_contrasenya empleado.contrasenya%TYPE,
                          P_cargo empleado.cargo%TYPE,  
                          salidaEsperada BOOLEAN); 

   PROCEDURE eliminar (   nombre_prueba VARCHAR2, 
                          w_dni_empleado empleado.dni_empleado%TYPE, 
                          salidaEsperada BOOLEAN); 

END PRUEBAS_empleado;
/
show error
CREATE OR REPLACE PACKAGE BODY PRUEBAS_empleado AS

  PROCEDURE inicializar AS
  BEGIN

      DELETE FROM empleado;
      DELETE FROM cuenta_bancaria;
      DELETE FROM empresa;
      DELETE FROM empleado;
      DELETE FROM producto;
      DELETE FROM almacen;
      DELETE FROM seccion;
      DELETE FROM empleado;
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

  PROCEDURE insertar (    nombre_prueba VARCHAR2, 
                          P_dni empleado.dni_empleado%TYPE, 
                          P_nombre empleado.nombre%TYPE, 
                          P_apellidos empleado.apellidos%TYPE,
                          P_fecha_nacimiento empleado.fecha_nacimiento%TYPE, 
                          P_contacto empleado.oid_contacto%TYPE,
                          P_fecha_alta empleado.fecha_alta_sistema%TYPE, 
                          P_farmacia empleado.oid_farmacia%TYPE,
                          P_empresa empleado.oid_empresa%TYPE,
                          P_contrasenya empleado.contrasenya%TYPE,
                          P_cargo empleado.cargo%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_empleado empleado%ROWTYPE;
  BEGIN

    nuevo_empleado(P_dni, P_nombre, P_apellidos, P_fecha_nacimiento, P_contacto, P_fecha_alta, P_farmacia, P_empresa,P_contrasenya, P_cargo);

    SELECT * INTO w_empleado FROM empleado WHERE dni_empleado = P_DNI;

    IF (w_empleado.dni_empleado <> P_dni OR w_empleado.nombre <> P_nombre OR w_empleado.apellidos <> P_apellidos
                OR P_fecha_nacimiento <> w_empleado.fecha_nacimiento OR P_contacto <> w_empleado.oid_contacto OR P_fecha_alta <> w_empleado.fecha_alta_sistema
                OR P_farmacia <> w_empleado.oid_farmacia OR P_contrasenya <> w_empleado.contrasenya OR P_cargo <> w_empleado.cargo) THEN
      salida := false;
    END IF;

    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END insertar;

  PROCEDURE actualizar ( nombre_prueba VARCHAR2, 
                          w_dni empleado.dni_empleado%TYPE, 
                          P_nombre empleado.nombre%TYPE, 
                          P_apellidos empleado.apellidos%TYPE,
                          P_fecha_baja empleado.fecha_baja_sistema%TYPE,
                          P_farmacia empleado.oid_farmacia%TYPE, 
                          P_contrasenya empleado.contrasenya%TYPE,
                          P_cargo empleado.cargo%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    p_empleado empleado%ROWTYPE;
  BEGIN

    UPDATE empleado SET nombre = P_nombre, apellidos = P_apellidos,
                 fecha_baja_sistema = P_fecha_baja, oid_farmacia = P_farmacia, contrasenya = P_contrasenya, cargo = P_cargo WHERE dni_empleado=W_DNI;

    SELECT * INTO p_empleado FROM empleado WHERE dni_empleado=w_dni;
    IF (p_empleado.nombre <> P_nombre OR p_empleado.apellidos <> P_apellidos OR
                 p_empleado.fecha_baja_sistema <> P_fecha_baja OR p_empleado.oid_farmacia <> P_farmacia OR p_empleado.contrasenya <> P_contrasenya
                 OR p_empleado.cargo = P_cargo) THEN
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
                          w_dni_empleado empleado.dni_empleado%TYPE, 
                          salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_empleado INTEGER;
  BEGIN

    eliminar_empleado(w_dni_empleado);

    SELECT COUNT(*) INTO n_empleado FROM empleado WHERE dni_empleado=w_dni_empleado;
    IF (n_empleado <> 0) THEN
      salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(salida,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.put_line(nombre_prueba || ASSERT_EQUALS(false,salidaEsperada));
          ROLLBACK;
  END eliminar;

END PRUEBAS_empleado;
/
show error