--RO04-RN03
--Trigger para que el dinero de las nominas salga de la cuenta bancaria de la farmacia
CREATE OR REPLACE TRIGGER pago_nominas
BEFORE INSERT OR update ON nomina
FOR EACH ROW
    DECLARE N_farmacia FARMACIA.nombre%TYPE;
     N_titular_cuenta cuenta_bancaria.id_cuenta_bancaria%TYPE;
     N_cargo empleado.cargo%TYPE;
BEGIN 
    select cargo into N_cargo from empleado WHERE dni_empleado = :NEW.dni_empleado;
    IF(:NEW.cobrada = 1 and (N_cargo='GERENTE' or N_cargo='PERSONAL_ADMINISTRATIVO' or 
                             N_cargo='ENCARGADO_ALMACEN' or N_cargo='EMPLEADOS_ALMACEN' or N_cargo='ENCARGADO_TIENDA')) THEN
    SELECT f.nombre INTO N_farmacia FROM empleado e left outer join farmacia f ON f.OID_FARMACIA = e.OID_FARMACIA WHERE e.dni_empleado = :NEW.dni_empleado; 
    SELECT ID_CUENTA_BANCARIA INTO N_titular_cuenta FROM cuenta_bancaria  WHERE titular = N_farmacia;
    RES_DINERO(N_titular_cuenta, :NEW.salario_base);
    RES_DINERO(N_titular_cuenta, :NEW.salario_variable);
    END IF;
END;
/

--RO04-RN06
--Trigger para que solo se pueda eliminar la nomina si se ha confirmado su cobro
create or replace TRIGGER eliminacion_nomina
BEFORE DELETE ON nomina
FOR EACH ROW 
    DECLARE
        N_nomina NOMINA.COBRADA%TYPE;
BEGIN
        IF :OLD.cobrada=0
        THEN RAISE_APPLICATION_ERROR(-20013, 'No se puede eliminar una nomina si no ha sido cobrada previamente');
        END IF;

END;
/

--RO04-RN07
--Triggers para restar la nomina del director, subdirector y jefe encargado del almacen de la cuenta de la empresa
create or replace trigger pago_nominas_superiores
before insert or update on nomina 
for each row 
    declare 
    N_cargo empleado.cargo%TYPE;
    N_titular_cuenta cuenta_bancaria.id_cuenta_bancaria%TYPE;
    N_empresa empresa.nombre%TYPE;
begin 
    select cargo into N_cargo from empleado WHERE dni_empleado = :NEW.dni_empleado;
    if(:new.cobrada=1 and (N_cargo='DIRECTOR' or N_cargo='SUBDIRECTOR' or N_cargo='JEFE_ENCARGADO_ALMACEN')) then
    SELECT NOMBRE INTO N_empresa FROM empresa;
    select id_cuenta_bancaria into N_titular_cuenta from cuenta_bancaria where titular=N_empresa;
    RES_DINERO(N_titular_cuenta,:new.salario_base);
    RES_DINERO(N_titular_cuenta,:new.salario_variable);
    end if;
end;
/  









