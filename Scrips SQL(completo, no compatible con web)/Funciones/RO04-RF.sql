--REQUISITOS FUNCIONALES

--RO04-RF01
--Procedura para crear nomina
CREATE OR REPLACE PROCEDURE New_nomina(
    N_empleado          IN  NOMINA.DNI_EMPLEADO%TYPE,
    N_salarioBase       IN  NOMINA.SALARIO_BASE%TYPE,
    N_salarioVariable   IN  NOMINA.SALARIO_VARIABLE%TYPE,
    N_fecha             IN  NOMINA.FECHA%TYPE,
    N_cobrada           IN  NOMINA.COBRADA%TYPE   
)AS 
BEGIN
    INSERT INTO nomina (DNI_EMPLEADO, SALARIO_BASE, SALARIO_VARIABLE, FECHA, COBRADA)
                VALUES    (N_empleado, N_salarioBase, N_salarioVariable, N_fecha, N_cobrada);
END;
/
--Procedure para eliminar nomina  
CREATE OR REPLACE PROCEDURE Delete_nomina(
    N_oid   IN  NOMINA.OID_NOMINA%TYPE
)AS 
BEGIN
    DELETE FROM nomina WHERE OID_NOMINA = N_oid;
END;
/
--RO04-RF02
--Procedure para cobrar nomina
CREATE OR REPLACE PROCEDURE Cobrar_nomina(
    N_oid   IN  NOMINA.OID_NOMINA%TYPE
)AS 
BEGIN
    UPDATE nomina 
    SET cobrada = 1
    WHERE (nomina.oid_nomina = N_oid);
END;
/
--RO04-RF03
--Procedure para crear cuenta bancaria
CREATE OR REPLACE PROCEDURE New_cuenta_bancaria(
    N_id_cuenta_bancaria    IN  CUENTA_BANCARIA.ID_CUENTA_BANCARIA%TYPE,
    N_titular               IN  CUENTA_BANCARIA.TITULAR%TYPE,
    N_dinero_disponible     IN  CUENTA_BANCARIA.DINERO_DISPONIBLE%TYPE
)AS 
BEGIN
    INSERT INTO cuenta_bancaria (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
                VALUES    (N_id_cuenta_bancaria, N_titular, N_dinero_disponible);
END;
/
--Procedure para eliminar cuenta bancaria
CREATE OR REPLACE PROCEDURE Delete_cuenta_bancaria(
    N_oid   IN  CUENTA_BANCARIA.ID_CUENTA_BANCARIA%TYPE
)AS 
BEGIN
    DELETE FROM cuenta_bancaria WHERE ID_CUENTA_BANCARIA = N_oid;
END;
/
--RO04-RF04
--Procedure para sumar dinero a la cuenta bancaria
CREATE OR REPLACE PROCEDURE Sum_dinero(
    N_cuenta_bancaria       IN  CUENTA_BANCARIA.ID_CUENTA_BANCARIA%TYPE,
    N_dinero                IN  CUENTA_BANCARIA.DINERO_DISPONIBLE%TYPE
)AS 
BEGIN
    UPDATE cuenta_bancaria 
    SET dinero_disponible = dinero_disponible+N_dinero
    WHERE (cuenta_bancaria.id_cuenta_bancaria = N_cuenta_bancaria);
END;
/
--Procedure para restar dinero a la cuenta bancaria
CREATE OR REPLACE PROCEDURE Res_dinero(
    N_cuenta_bancaria       IN  CUENTA_BANCARIA.ID_CUENTA_BANCARIA%TYPE,
    N_dinero                IN  CUENTA_BANCARIA.DINERO_DISPONIBLE%TYPE
)AS 
BEGIN
    UPDATE cuenta_bancaria 
    SET dinero_disponible = dinero_disponible-N_dinero
    WHERE (cuenta_bancaria.id_cuenta_bancaria = N_cuenta_bancaria);
END;
/
