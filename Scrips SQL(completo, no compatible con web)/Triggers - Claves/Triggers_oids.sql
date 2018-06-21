--Secuencias para los oid's necesarios
DROP SEQUENCE SQ_producto;
CREATE SEQUENCE SQ_producto;

DROP SEQUENCE SQ_almacen;
CREATE SEQUENCE SQ_almacen;

DROP SEQUENCE SQ_seccion;
CREATE SEQUENCE SQ_seccion;

DROP SEQUENCE SQ_envio;
CREATE SEQUENCE SQ_envio;

DROP SEQUENCE SQ_factura;
CREATE SEQUENCE SQ_factura;

DROP SEQUENCE SQ_linea;
CREATE SEQUENCE SQ_linea;

DROP SEQUENCE SQ_lote;
CREATE SEQUENCE SQ_lote;

DROP SEQUENCE SQ_pedido;
CREATE SEQUENCE SQ_pedido;

DROP SEQUENCE SQ_proveedor;
CREATE SEQUENCE SQ_proveedor;

DROP SEQUENCE SQ_bolsa;
CREATE SEQUENCE SQ_bolsa;

DROP SEQUENCE SQ_pedido_usuario;
CREATE SEQUENCE SQ_pedido_usuario;

DROP SEQUENCE SQ_factura_usuario;
CREATE SEQUENCE SQ_factura_usuario;

DROP SEQUENCE SQ_nomina;
CREATE SEQUENCE SQ_nomina;

DROP SEQUENCE SQ_farmacia;
CREATE SEQUENCE SQ_farmacia;

DROP SEQUENCE SQ_producto;
CREATE SEQUENCE SQ_producto;

DROP SEQUENCE SQ_empresa;
CREATE SEQUENCE SQ_empresa;

DROP SEQUENCE SQ_contacto;
CREATE SEQUENCE SQ_contacto;

DROP SEQUENCE SQ_nomina;
CREATE SEQUENCE SQ_nomina;

DROP SEQUENCE SQ_farmacia;
CREATE SEQUENCE SQ_farmacia;

DROP SEQUENCE SQ_producto;
CREATE SEQUENCE SQ_producto;

DROP SEQUENCE SQ_empresa;
CREATE SEQUENCE SQ_empresa;

DROP SEQUENCE SQ_contacto;
CREATE SEQUENCE SQ_contacto;


-- Triggers para autoincremento de claves primarias

-- Trigger para autoincrementar la clave primaria de los productos
CREATE OR REPLACE TRIGGER PK_Productos
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
     :NEW.oid_producto := SQ_producto.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los almacenes
CREATE OR REPLACE TRIGGER PK_Almacenes
BEFORE INSERT ON almacen
FOR EACH ROW
BEGIN
     :NEW.oid_almacen := SQ_almacen.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los seccion
CREATE OR REPLACE TRIGGER PK_Secciones
BEFORE INSERT ON seccion
FOR EACH ROW
BEGIN
     :NEW.oid_seccion := SQ_seccion.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los envios
CREATE OR REPLACE TRIGGER PK_Envios
BEFORE INSERT ON envio
FOR EACH ROW
BEGIN
     :NEW.oid_envio := SQ_envio.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de las facturas
CREATE OR REPLACE TRIGGER PK_Facturas
BEFORE INSERT ON factura
FOR EACH ROW
BEGIN
     :NEW.oid_factura := SQ_factura.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de las linea
CREATE OR REPLACE TRIGGER PK_Lineas
BEFORE INSERT ON linea
FOR EACH ROW
BEGIN
     :NEW.oid_linea := SQ_linea.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los lotes
CREATE OR REPLACE TRIGGER PK_Lotes
BEFORE INSERT ON lote
FOR EACH ROW
BEGIN
     :NEW.oid_lote := SQ_lote.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los pedidos
CREATE OR REPLACE TRIGGER PK_Pedidos
BEFORE INSERT ON pedido
FOR EACH ROW
BEGIN
     :NEW.oid_pedido := SQ_pedido.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los proveedores
CREATE OR REPLACE TRIGGER PK_Proveedores
BEFORE INSERT ON proveedor
FOR EACH ROW
BEGIN
     :NEW.oid_proveedor := SQ_proveedor.NEXTVAL;
END;
/

--Claves primarias de bolsas
CREATE OR REPLACE TRIGGER PK_bolsa
BEFORE INSERT ON bolsa
FOR EACH ROW
BEGIN
     :NEW.oid_bolsa := SQ_bolsa.NEXTVAL;
END;
/



--Claves primarias de pedidos
CREATE OR REPLACE TRIGGER PK_pedido_usuario
BEFORE INSERT ON pedido_usuario
FOR EACH ROW
BEGIN
     :NEW.oid_pedido_usuario := SQ_pedido_usuario.NEXTVAL;
END;
/


--Claves primarias de facturas
CREATE OR REPLACE TRIGGER PK_factura_usuario
BEFORE INSERT ON factura_usuario
FOR EACH ROW
BEGIN
     :NEW.oid_factura_usuario := SQ_factura_usuario.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER PK_Nomina
BEFORE INSERT ON nomina
FOR EACH ROW
BEGIN
     :NEW.oid_nomina := SQ_nomina.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de las nominas
CREATE OR REPLACE TRIGGER PK_Nomina
BEFORE INSERT ON nomina
FOR EACH ROW
BEGIN
     :NEW.oid_nomina := SQ_nomina.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de las farmacias
CREATE OR REPLACE TRIGGER PK_farmacia
BEFORE INSERT ON farmacia
FOR EACH ROW
BEGIN
     :NEW.oid_farmacia := SQ_farmacia.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los productos
CREATE OR REPLACE TRIGGER PK_producto
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
     :NEW.oid_producto := SQ_producto.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los envios
CREATE OR REPLACE TRIGGER PK_empresa
BEFORE INSERT ON empresa
FOR EACH ROW
BEGIN
     :NEW.oid_empresa := SQ_empresa.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los contactos
CREATE OR REPLACE TRIGGER PK_contacto
BEFORE INSERT ON contacto
FOR EACH ROW
BEGIN
     :NEW.oid_contacto := SQ_contacto.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de las farmacias
CREATE OR REPLACE TRIGGER PK_farmacia
BEFORE INSERT ON farmacia
FOR EACH ROW
BEGIN
     :NEW.oid_farmacia := SQ_farmacia.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los productos
CREATE OR REPLACE TRIGGER PK_producto
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
     :NEW.oid_producto := SQ_producto.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los envios
CREATE OR REPLACE TRIGGER PK_empresa
BEFORE INSERT ON empresa
FOR EACH ROW
BEGIN
     :NEW.oid_empresa := SQ_empresa.NEXTVAL;
END;
/

-- Trigger para autoincrementar la clave primaria de los contactos
CREATE OR REPLACE TRIGGER PK_contacto
BEFORE INSERT ON contacto
FOR EACH ROW
BEGIN
     :NEW.oid_contacto := SQ_contacto.NEXTVAL;
END;
/
