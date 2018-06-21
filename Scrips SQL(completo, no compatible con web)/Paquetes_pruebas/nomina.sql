
/* PAQUETES */

 CREATE OR REPLACE PACKAGE PRUEBAS_NOMINA AS 

   PROCEDURE inicializar;
   PROCEDURE insertar (nombre_prueba VARCHAR2, P_dni_empleado nomina.dni_empleado%TYPE, P_salario_base nomina.salario_base%TYPE, 
   P_salario_variable nomina.salario_variable%TYPE, P_fecha nomina.fecha%TYPE, P_cobrada nomina.cobrada%TYPE, salidaEsperada BOOLEAN);
   PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_nomina nomina.oid_nomina%TYPE,P_salario_base nomina.salario_base%TYPE, 
        P_salario_variable nomina.salario_variable%TYPE, P_cobrada nomina.cobrada%TYPE, salidaEsperada BOOLEAN); 
   PROCEDURE eliminar (nombre_prueba VARCHAR2, w_oid_nomina nomina.oid_nomina%TYPE, salidaEsperada BOOLEAN); 

END PRUEBAS_NOMINA;
/

 CREATE OR REPLACE PACKAGE BODY PRUEBAS_NOMINA AS

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

/* PRUEBA PARA LA INSERCIÓN DE NOMINA */
  PROCEDURE insertar (nombre_prueba VARCHAR2, P_dni_empleado nomina.dni_empleado%TYPE, P_salario_base nomina.salario_base%TYPE, 
  P_salario_variable nomina.salario_variable%TYPE, P_fecha nomina.fecha%TYPE, P_cobrada nomina.cobrada%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    w_nomina nomina%ROWTYPE;
    p_oid_nomina nomina.oid_nomina%TYPE;
  BEGIN
    
    /* Insertar almacen */
    New_nomina(P_dni_empleado, P_salario_base, P_salario_variable, P_fecha, P_cobrada);
    
    /* Seleccionar nomina y comprobar que los datos se insertaron correctamente */
    P_oid_nomina := sq_nomina.currval;
    SELECT * INTO w_nomina FROM nomina WHERE oid_nomina = p_oid_nomina;
    IF (w_nomina.oid_nomina <> P_oid_nomina OR w_nomina.dni_empleado <> P_dni_empleado OR w_nomina.salario_base <> P_salario_base OR
    w_nomina.salario_variable <> P_salario_variable OR w_nomina.fecha <> P_fecha OR w_nomina.cobrada <> P_cobrada) THEN
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
  
/* PRUEBA PARA LA ACTUALIZACIÓN DE NOMINA */
  PROCEDURE actualizar (nombre_prueba VARCHAR2, P_oid_nomina nomina.oid_nomina%TYPE, P_salario_base nomina.salario_base%TYPE, 
        P_salario_variable nomina.salario_variable%TYPE, P_cobrada nomina.cobrada%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    P_nomina nomina%ROWTYPE;
  BEGIN
    
    /* Actualizar nomina */
    UPDATE nomina SET salario_base = P_salario_base, salario_variable = P_salario_variable,
                 cobrada = P_cobrada WHERE oid_nomina=P_oid_nomina;
    
    /* Seleccionar nomina y comprobar que los campos se actualizaron correctamente */
    SELECT * INTO P_nomina FROM nomina WHERE oid_nomina=P_oid_nomina;
    IF (P_nomina.salario_base <> P_salario_base OR P_nomina.salario_variable <> P_salario_variable OR
                 P_nomina.cobrada <> P_cobrada) THEN
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


/* PRUEBA PARA LA ELIMINACIÓN DE NOMINA */
  PROCEDURE eliminar (nombre_prueba VARCHAR2,w_oid_nomina nomina.oid_nomina%TYPE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    n_nomina INTEGER;
  BEGIN
    
    /* Eliminar nomina */
    delete_nomina(w_oid_nomina);
    
    /* Verificar que la nomina no se encuentra en la BD */
    SELECT COUNT(*) INTO n_nomina FROM nomina WHERE oid_nomina=w_oid_nomina;
    IF (n_nomina <> 0) THEN
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

END PRUEBAS_NOMINA;
/