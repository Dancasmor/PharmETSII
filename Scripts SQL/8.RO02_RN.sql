CREATE OR REPLACE TRIGGER almacen_unico_farmacia
    BEFORE UPDATE OR INSERT ON almacen
    FOR EACH ROW 
    DECLARE
        P_almacen NUMBER;
BEGIN
    SELECT COUNT(*) INTO P_almacen FROM almacen WHERE oid_farmacia = :NEW.oid_farmacia;
        IF(P_almacen > 0) THEN
            RAISE_APPLICATION_ERROR(-20010, 'Esta farmacia ya tiene un almacen asignado');
        END IF;
END;
/

CREATE OR REPLACE TRIGGER cuenta_bancaria_unica_farmacia
    BEFORE UPDATE OR INSERT ON farmacia
    FOR EACH ROW 
    DECLARE
        P_farmacia NUMBER;
BEGIN
    SELECT COUNT(*) INTO P_farmacia FROM farmacia WHERE id_cuenta_bancaria = :NEW.id_cuenta_bancaria;
        IF(P_farmacia > 0) THEN
            RAISE_APPLICATION_ERROR(-20010, 'Ya existe una farmacia asignada a la cuenta bancaria');
        END IF;
END;
/
