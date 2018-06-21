DROP TABLE log_cuenta_bancaria;
CREATE TABLE log_cuenta_bancaria AS SELECT * FROM cuenta_bancaria;
TRUNCATE TABLE log_cuenta_bancaria; 
ALTER TABLE log_cuenta_bancaria 
ADD(
    fcambio     DATE        DEFAULT SYSDATE,
    usuario     CHAR(9)     DEFAULT user,
    cambio      CHAR(1)     CHECK(cambio IN ('U','D'))
    );
-- Crear un trigger after que deje como pistas los valores anteriores al cambio
--Cambios en la cuenta bancaria
CREATE OR REPLACE TRIGGER log_cuenta_bancaria
    AFTER DELETE OR UPDATE ON cuenta_bancaria
    FOR EACH ROW 
    DECLARE w_cambio CHAR(1);
BEGIN
    IF deleting THEN w_cambio := 'D';
    ELSE w_cambio := 'U';
    END IF;
    INSERT INTO log_cuenta_bancaria(ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE, cambio)
        VALUES (:OLD.ID_CUENTA_BANCARIA, :OLD.TITULAR, :OLD.DINERO_DISPONIBLE, w_cambio);
END;
/
--Cambios en la nomina
DROP TABLE log_nomina;
CREATE TABLE log_nomina AS SELECT * FROM nomina;
TRUNCATE TABLE log_nomina; 
ALTER TABLE log_nomina 
ADD(
    fcambio     DATE        DEFAULT SYSDATE,
    usuario     CHAR(9)     DEFAULT user,
    cambio      CHAR(1)     CHECK(cambio IN ('U','D'))
    );
-- Crear un trigger after que deje como pistas los valores anteriores al cambio  
CREATE OR REPLACE TRIGGER log_nomina
    AFTER DELETE OR UPDATE ON nomina
    FOR EACH ROW 
    DECLARE w_cambio CHAR(1);
BEGIN
    IF deleting THEN w_cambio := 'D';
    ELSE w_cambio := 'U';
    END IF;
    INSERT INTO log_nomina(OID_NOMINA, DNI_EMPLEADO, SALARIO_BASE, SALARIO_VARIABLE, FECHA, COBRADA, cambio)
        VALUES (:OLD.OID_NOMINA, :OLD.DNI_EMPLEADO, :OLD.SALARIO_BASE, :OLD.SALARIO_VARIABLE, :OLD.FECHA, :OLD.COBRADA, w_cambio);
END;
/