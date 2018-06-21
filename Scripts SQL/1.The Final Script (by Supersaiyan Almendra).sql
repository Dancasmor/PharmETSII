--------------------------------------------------------
-- Borrado inicial de tablas
--------------------------------------------------------
DROP TABLE contacto 	        CASCADE CONSTRAINTS;
DROP TABLE producto		        CASCADE CONSTRAINTS;
DROP TABLE cuenta_bancaria		CASCADE CONSTRAINTS;
DROP TABLE empresa 		        CASCADE CONSTRAINTS;
DROP TABLE farmacia 	        CASCADE CONSTRAINTS;
DROP TABLE proveedor 	        CASCADE CONSTRAINTS;
DROP TABLE lote 		        CASCADE CONSTRAINTS;
DROP TABLE usuario 		        CASCADE CONSTRAINTS;
DROP TABLE empleado 	        CASCADE CONSTRAINTS;
DROP TABLE nomina 		        CASCADE CONSTRAINTS;
DROP TABLE seccion 		        CASCADE CONSTRAINTS;
DROP TABLE almacen 		        CASCADE CONSTRAINTS;	
DROP TABLE envio                CASCADE CONSTRAINTS;
DROP TABLE pedido               CASCADE CONSTRAINTS;
DROP TABLE factura              CASCADE CONSTRAINTS;
DROP TABLE linea                CASCADE CONSTRAINTS;
DROP TABLE bolsa 		        CASCADE CONSTRAINTS;
DROP TABLE pedido_usuario 		CASCADE CONSTRAINTS;
DROP TABLE factura_usuario 		CASCADE CONSTRAINTS;


--------------------------------------------------------
-- Creacion de tablas
--------------------------------------------------------
CREATE TABLE contacto(
    oid_contacto            			CHAR(9),
    telefono                			VARCHAR2(50), 
    email                   			VARCHAR2(50),
    direccion               			VARCHAR2(50)    NOT NULL,
    codigo_postal           			NUMBER(10)      NOT NULL,
    ciudad                  			VARCHAR2(50)    NOT NULL,
    PRIMARY KEY (oid_contacto)
);

CREATE TABLE cuenta_bancaria(
    id_cuenta_bancaria                  CHAR(34), --numero iban correspondiente a la cuenta bancaria
    titular                             VARCHAR2(50),
    dinero_disponible                   NUMBER(6,2),
    PRIMARY KEY (id_cuenta_bancaria)
);
CREATE TABLE empresa(
    oid_empresa             			CHAR(9),
    nombre                  			VARCHAR2(50), 
    id_cuenta_bancaria                  CHAR(34),
    oid_contacto             			CHAR(9),
    PRIMARY KEY (oid_empresa),
    FOREIGN KEY (oid_contacto) 			REFERENCES contacto,
    FOREIGN KEY (id_cuenta_bancaria)    REFERENCES cuenta_bancaria
);
CREATE TABLE farmacia(
    oid_farmacia            			CHAR(9),
    nombre                  			VARCHAR2(50),
    oid_contacto            			CHAR(9)			NOT NULL,
    id_cuenta_bancaria					CHAR(34),
    PRIMARY KEY (oid_farmacia),
    FOREIGN KEY (oid_contacto) 			REFERENCES contacto,
    FOREIGN KEY (id_cuenta_bancaria)    REFERENCES cuenta_bancaria
);

CREATE TABLE producto(
	oid_producto						CHAR(9),
	nombre 								VARCHAR2(50)	NOT NULL,
	url_imagenes						VARCHAR2(150)	NOT NULL,	-- revisar
	precio_venta						NUMBER(6,2)		NOT NULL,
	puntos								NUMBER(3)		NOT NULL,
	receta								NUMBER(1)		NOT NULL, 	-- boolean 0/1
	PRIMARY KEY (oid_producto)
);

CREATE TABLE almacen(
	oid_almacen							CHAR(9),
	almacen_general						NUMBER(1)		NOT NULL, 	-- boolean 0/1
    oid_empresa                         CHAR(9),
    oid_farmacia                        CHAR(9), 
	PRIMARY KEY	(oid_almacen),
    FOREIGN KEY (oid_farmacia)          REFERENCES farmacia,
    FOREIGN KEY (oid_empresa)          REFERENCES empresa 
);

CREATE TABLE seccion(
	oid_seccion							CHAR(9),
    stock_actual                        SMALLINT        DEFAULT 0,
    stock_limite                        SMALLINT        DEFAULT 100,
    stock_seguridad                     SMALLINT        DEFAULT 20, 
    oid_almacen                         CHAR(9)         NOT NULL,
    oid_producto                        CHAR(9)         NOT NULL,
    PRIMARY KEY (oid_seccion),
    FOREIGN KEY (oid_almacen)          REFERENCES almacen,
    FOREIGN KEY (oid_producto)           REFERENCES producto
);

CREATE TABLE proveedor(
    oid_proveedor           			CHAR(9),
    contraseña                          VARCHAR2(50) NOT NULL,
    nombre_lab              			VARCHAR2(50)    NOT NULL,
    precio_envio_sin_gastos 			NUMBER(10)      NOT NULL,
    oid_contacto            			CHAR(9),
    PRIMARY KEY (oid_proveedor),
    FOREIGN KEY (oid_contacto) 			REFERENCES contacto
);
CREATE TABLE lote(
    oid_lote                			CHAR(9),
    cantidad_lote           			NUMBER(8)      NOT NULL,
    precio_lote             			NUMBER(8,2)      NOT NULL,
    oid_proveedor           			CHAR(9)         NOT NULL,
    oid_producto                        CHAR(9)         NOT NULL,
    PRIMARY KEY (oid_lote),
    FOREIGN KEY (oid_proveedor) 		REFERENCES proveedor,
    FOREIGN KEY (oid_producto)          REFERENCES producto 
);
CREATE TABLE usuario(
	dni_usuario	            			VARCHAR2(9),
    nombre                  			VARCHAR2(50)    NOT NULL,
    apellidos               			VARCHAR2(50)    NOT NULL,
    fecha_nacimiento        			DATE         NOT NULL,
    fecha_alta_sistema      			DATE         NOT NULL,
    fecha_baja_sistema      			DATE,
    contrasenya              			VARCHAR(50)     NOT NULL,
    puntos								NUMBER(4)		NOT NULL,
    peso 								NUMBER(5,2),					-- xxx'xx KG
    altura								NUMBER(3),					-- xxx CM
    oid_empresa            			CHAR(9)         NOT NULL,
    oid_contacto            			CHAR(9)         NOT NULL,
    PRIMARY KEY (dni_usuario),
    FOREIGN KEY (oid_contacto) 			REFERENCES contacto,
    FOREIGN KEY (oid_empresa) 			REFERENCES empresa
);
CREATE TABLE empleado( 
    dni_empleado                        CHAR(9),
    nombre                              VARCHAR2(50) NOT NULL,
    apellidos                           VARCHAR2(50) NOT NULL,
    fecha_nacimiento                    DATE NOT NULL,
    fecha_alta_sistema                  DATE NOT NULL,
    fecha_baja_sistema                  DATE,
    cargo                               VARCHAR2(50) CHECK ( cargo IN ('DIRECTOR','SUBDIRECTOR','JEFE_ENCARGADO_ALMACEN',
                                                                           'GERENTE','PERSONAL_ADMINISTRATIVO','ENCARGADO_ALMACEN',
                                                                           'EMPLEADOS_ALMACEN','ENCARGADO_TIENDA')),
    contrasenya                         VARCHAR2(50) NOT NULL,
    oid_farmacia                        CHAR(9), --farmacia a la que perteneces dicho empleado 
    oid_empresa                         CHAR(9),
    oid_contacto                        CHAR(9) NOT NULL, --datos de contacto de cada empleado
    PRIMARY KEY (dni_empleado),
    FOREIGN KEY (oid_farmacia)          REFERENCES farmacia,
    FOREIGN KEY (oid_contacto)          REFERENCES contacto,
    FOREIGN KEY (oid_empresa)           REFERENCES empresa
);
CREATE TABLE nomina(
    oid_nomina                          CHAR(9) NOT NULL,
    dni_empleado                        CHAR(9) NOT NULL, --empleado al que corresponde la nomina
    salario_base                        NUMBER(6,2) NOT NULL,
    salario_variable                    NUMBER(6,2),
    fecha                               DATE DEFAULT SYSDATE,
    cobrada                             NUMBER(1) DEFAULT 0, --boolean ->0=pago de nomina no recibido
    PRIMARY KEY (oid_nomina),                                          -->1=pago de nomina recibido
    FOREIGN KEY (dni_empleado)          REFERENCES empleado
);

CREATE TABLE envio(
	oid_envio							CHAR(9),
    fecha_envio                         DATE,
    oid_proveedor                       CHAR(9),
    oid_almacen                         CHAR(9), 
    esProveedor                        NUMBER(1)    NOT NULL, -- un 0 indica que es del almacen general y un 1 que es de un proveedor
    PRIMARY KEY (oid_envio),
    FOREIGN KEY (oid_almacen)          REFERENCES almacen, 
    FOREIGN KEY (oid_proveedor)        REFERENCES proveedor 
);

CREATE TABLE pedido(
	oid_pedido							CHAR(9),
    fecha_pedido                        DATE           DEFAULT SYSDATE,
    enviado                             NUMBER(1)      DEFAULT 0, --Boolean 0 si no ha sido enviado aun
    esProveedor                        NUMBER(1)        NOT NULL, -- un 0 indica que es al almacen general y un 1 que es a un proveedor
    oid_almacen                         CHAR(9)         NOT NULL, -- el que realiza el pedido
    oid_almacen2                        CHAR(9),    --al que se realiza el pedido
    oid_proveedor                       CHAR(9),  
    PRIMARY KEY (oid_pedido),
    FOREIGN KEY (oid_almacen)          REFERENCES almacen,
    FOREIGN KEY (oid_almacen2)         REFERENCES almacen, 
    FOREIGN KEY (oid_proveedor)        REFERENCES proveedor 
);
CREATE TABLE factura(
	oid_factura							CHAR(9),
    fecha_factura                       DATE            DEFAULT SYSDATE,
    precio_envio                        NUMBER(5,2)       NOT NULL,
    oid_pedido                          CHAR(9)         NOT NULL,
    oid_envio                           CHAR(9)         NOT NULL,
    oid_almacen                         CHAR(9)         NOT NULL,
    PRIMARY KEY (oid_factura),
    FOREIGN KEY (oid_almacen)          REFERENCES almacen, 
    FOREIGN KEY (oid_envio)            REFERENCES envio,
    FOREIGN KEY (oid_pedido)            REFERENCES pedido
);

CREATE TABLE linea(
	oid_linea						   CHAR(9),
    cantidad                           SMALLINT NOT NULL,
    oid_pedido                         CHAR(9)  NOT NULL,
    oid_producto                       CHAR(9),
    oid_lote                           CHAR(9),
    PRIMARY KEY (oid_linea),
    FOREIGN KEY (oid_pedido)           REFERENCES pedido,
    FOREIGN KEY (oid_producto)         REFERENCES producto,
    FOREIGN KEY (oid_lote)             REFERENCES lote
);

CREATE TABLE pedido_usuario (
oid_pedido_usuario      CHAR(9),
dni_usuario             VARCHAR2(9)     NOT NULL,
fecha_solicitud         date            NOT NULL,
contrareembolso_tarjeta NUMBER(1)       NOT NULL,  --[Bolean: 0/1] Contrareembolso/tarjeta
tarjeta                 VARCHAR2(19),              --El número de tarjeta seguido de los 3 digitos de seguridad
preparado               NUMBER(1),

PRIMARY KEY(oid_pedido_usuario),
FOREIGN KEY(dni_usuario)                REFERENCES usuario
);

CREATE TABLE bolsa (
oid_bolsa               CHAR(9),
oid_pedido_usuario      CHAR(9)         NOT NULL,
oid_producto            CHAR(9)         NOT NULL,
cantidad                NUMBER(2)       NOT NULL,                 

PRIMARY KEY(oid_bolsa),
FOREIGN KEY(oid_producto)               REFERENCES producto,
FOREIGN KEY(oid_pedido_usuario)         REFERENCES pedido_usuario

);


CREATE TABLE factura_usuario(  
oid_factura_usuario     CHAR(9),
oid_pedido_usuario      CHAR(9)         NOT NULL,
fecha_venta             date,
oid_almacen             CHAR(9)         NOT NULL,
enviado                 NUMBER(1),  --[Boolean]Indica si el pedido fue ya enviado

PRIMARY KEY(oid_factura_usuario),
FOREIGN KEY(oid_pedido_usuario)         REFERENCES pedido_usuario,
FOREIGN KEY(oid_almacen)                REFERENCES almacen

);		

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

--CONTACTOS PARA PROVEEDORES
INSERT INTO CONTACTO VALUES (1, '+34 711 398 115', '00@proveedor.com', 'C/ Alegría la Salada, 24', 31003, 'Jaén');
INSERT INTO CONTACTO VALUES (2, '+34 986 056 308', '01@proveedor.com', 'C/ Bujías del Almadroño, 7', 41009, 'Sevilla');
INSERT INTO CONTACTO VALUES (3, '+34 922 570 090', '02@proveedor.com', 'C/ Hernando Casanueva, 67', 27999, 'Huelva');
INSERT INTO CONTACTO VALUES (4, '+34 644 123 321', '03@proveedor.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (5, '+34 910 237 888', '04@proveedor.com', 'C/ Sierpes, 13', 00678, 'Córdoba');
--CONTACTOS PARA EMPLEADOS
INSERT INTO CONTACTO VALUES (6, '+34 911 220 021', '00@empleado.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (7, '+34 611 378 155', '01@empleado.com', 'C/ Tendence Terra, 34', 65009, 'Madrid');
INSERT INTO CONTACTO VALUES (8, '+34 900 346 398', '02@empleado.com', 'C/ Federico Mayo Gayarre, 56, 4ºA', 41006, 'Sevilla');
INSERT INTO CONTACTO VALUES (9, '+34 766 534 021', '03@empleado.com', 'Av/ Grito del Alba, 1, 1ºD', 21223, 'Huelva');
INSERT INTO CONTACTO VALUES (10, '+34 677 177 371', '04@empleado.com', 'C/ Joaquín Galvés, 21', 26110, 'Almería');
INSERT INTO CONTACTO VALUES (11, '+34 934 437 809', '05@empleado.com', 'C/ Columnas de Templo, 9, 3ºI', 40678, 'Sevilla');
INSERT INTO CONTACTO VALUES (12, '+34 954 111 231', '06@empleado.com', 'C/ Moderno Galdós Serrano, 1', 27990, 'Cádiz');
INSERT INTO CONTACTO VALUES (13, '+34 723 354 135', '07@empleado.com', 'C/ Sentimiento, 34, 2ºB', 35603, 'Huelva');
INSERT INTO CONTACTO VALUES (14, '+34 954 056 338', '08@empleado.com', 'C/ Casa de la Madera, 23', 41209, 'Cádiz');
INSERT INTO CONTACTO VALUES (15, '+34 954 570 190', '09@empleado.com', 'Av/ Cantante Manuel Escobar, 23, 8ºD', 27999, 'Huelva');
INSERT INTO CONTACTO VALUES (16, '+34 669 198 361', '10@empleado.com', 'C/ Wonder Wallace, 10', 45110, 'Sevilla');
--CONTACTOS PARA USUARIOS
INSERT INTO CONTACTO VALUES (18, '+34 954 212 121', '01@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (19, '+34 677 234 679', '02@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (20, '+34 600 110 026', '03@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (21, '+34 917 193 365', '04@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (22, '+34 688 860 177', '05@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (23, '+34 701 220 021', '06@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (24, '+34 955 700 560', '07@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (25, '+34 954 336 479', '08@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (26, '+34 644 217 880', '09@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
INSERT INTO CONTACTO VALUES (27, '+34 684 287 880', '10@usuario.com', 'C/ Injusticia, 4, 1ºB', 41003, 'Sevilla');
--CONTACTO PARA EMPRESA
INSERT INTO CONTACTO VALUES (28, '+34 689 183 361', '00@empresa.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
--CONTACTOS PARA FARMACIAS
INSERT INTO CONTACTO VALUES (29, '+34 644 123 321', '00@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (30, '+34 654 123 321', '01@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (31, '+34 664 123 321', '02@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (32, '+34 674 123 321', '03@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (33, '+34 684 123 321', '04@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (34, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
--CONTACTO EMPLEADO
INSERT INTO CONTACTO VALUES (35, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (36, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (37, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (38, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (39, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (40, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (41, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (42, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (43, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (44, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (45, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (46, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
INSERT INTO CONTACTO VALUES (47, '+34 604 123 321', '05@farmacia.com', 'C/ Pedrosada del Rosal, 2', 86110, 'Sevilla');
---------------------------------------------------------------------------------------------
--PRODUCTOS
INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (1,'Paracetamol 500g','./images/productos/paracetamol500mg.jpg',4.9,2,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (2,'Dextrosa Monoclida 15ml','./images/productos/dextrosa15ml.jpg',15.99,12,1);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (3,'Temazepam (Restoril)','./images/productos/temazepan.jpg',4.99,8,1);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (4,'Inhalador Ventolin 100ug','./images/productos/ventolin.png',4.59,2,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (5,'Omeprazol comprimidos 20mg','./images/productos/omeprazol.jpg',2.42,3,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (6,'Aspirina comprimidos 500mg','./images/productos/Aspirina500mg.jpg',4.45,5,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (7,'Lidocaína 5% Uso topico ','./images/productos/lidocaina.jpg',18.36,12,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (8,'Cinfamucol 600mg acetilcisteína ','./images/productos/cinfamucol.jpg',7.01,6,1);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (9,'Sintrom 4mg ','./images/productos/sintrom.jpg',2.33,3,1);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (10,'Viagra 4uds. ','./images/productos/viagra.jpg',80,26,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (11,'Dalsy 40mg/ml','./images/productos/dalsy.jpg',5.01,6,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (12,'Ibuprofeno 500mg','./images/productos/ibuprofeno.jpg',1.97,3,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (13,'Desloratadina 5mg','./images/productos/desloratadina.jpg',6.63,7,0);

INSERT INTO PRODUCTO (OID_PRODUCTO, NOMBRE, URL_IMAGENES, PRECIO_VENTA, PUNTOS, RECETA)
VALUES (14,'Rupatadina 10mg','./images/productos/rupatadina.jpg',6.90,8,0);
---------------------------------------------------------------------------------------------
--CUENTA BANCARIAS
INSERT INTO CUENTA_BANCARIA (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
VALUES ('ES11111111111111111111111111111111','PharmETSII',5000);

INSERT INTO CUENTA_BANCARIA (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
VALUES ('ES11111111111111111111111111111112','Farmacia Moron Ledro',2000);

INSERT INTO CUENTA_BANCARIA (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
VALUES ('ES11111111111111111111111111111113','Farmacia Reina Mercedes',3000);

INSERT INTO CUENTA_BANCARIA (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
VALUES ('ES11111111111111111111111111111114','Farmacia de Buzo',4000);

INSERT INTO CUENTA_BANCARIA (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
VALUES ('ES11111111111111111111111111111115','Farmacia Perez y Perez',2000);

INSERT INTO CUENTA_BANCARIA (ID_CUENTA_BANCARIA, TITULAR, DINERO_DISPONIBLE)
VALUES ('ES11111111111111111111111111111116','PharmHealth',2500);

---------------------------------------------------------------------------------------------
--EMPRESA
INSERT INTO EMPRESA (OID_EMPRESA, NOMBRE, ID_CUENTA_BANCARIA, OID_CONTACTO)
VALUES (1,'PharmETSII','ES11111111111111111111111111111111',28);
---------------------------------------------------------------------------------------------
--FARMACIAS
INSERT INTO FARMACIA (OID_FARMACIA, NOMBRE, OID_CONTACTO, ID_CUENTA_BANCARIA)
VALUES (1,'Farmacia Moron Ledro',29,'ES11111111111111111111111111111112');

INSERT INTO FARMACIA (OID_FARMACIA, NOMBRE, OID_CONTACTO, ID_CUENTA_BANCARIA)
VALUES (2,'Farmacia Reina Mercedes',30,'ES11111111111111111111111111111113');

INSERT INTO FARMACIA (OID_FARMACIA, NOMBRE, OID_CONTACTO, ID_CUENTA_BANCARIA)
VALUES (3,'Farmacia de Buzo',31,'ES11111111111111111111111111111114');

INSERT INTO FARMACIA (OID_FARMACIA, NOMBRE, OID_CONTACTO, ID_CUENTA_BANCARIA)
VALUES (4,'Farmacia Perez y Perez',32,'ES11111111111111111111111111111115');

INSERT INTO FARMACIA (OID_FARMACIA, NOMBRE, OID_CONTACTO, ID_CUENTA_BANCARIA)
VALUES (5,'PharmHealth',33,'ES11111111111111111111111111111116');
---------------------------------------------------------------------------------------------
--PROVEEDORES
INSERT INTO PROVEEDOR (OID_PROVEEDOR, CONTRASEÑA, NOMBRE_LAB, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO)
VALUES(1,'123','Laboratorio de Dexter', 200, 13);

INSERT INTO PROVEEDOR (OID_PROVEEDOR, CONTRASEÑA, NOMBRE_LAB, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO)
VALUES(2,'123','Laboratorio Dr.FrankStein', 200, 2);

INSERT INTO PROVEEDOR (OID_PROVEEDOR, CONTRASEÑA, NOMBRE_LAB, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO)
VALUES(3,'123','Laboratorio de Jaime', 200, 10);

INSERT INTO PROVEEDOR (OID_PROVEEDOR, CONTRASEÑA, NOMBRE_LAB, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO)
VALUES(4,'123','MathLab', 200, 4);

INSERT INTO PROVEEDOR (OID_PROVEEDOR, CONTRASEÑA, NOMBRE_LAB, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO)
VALUES(5,'123','Orochimaru Lab', 200, 9);

INSERT INTO PROVEEDOR (OID_PROVEEDOR, CONTRASEÑA, NOMBRE_LAB, PRECIO_ENVIO_SIN_GASTOS, OID_CONTACTO)
VALUES(6,'123','ETSII LAB', 200, 6);
---------------------------------------------------------------------------------------------
--LOTE
INSERT INTO LOTE (OID_LOTE, CANTIDAD_LOTE, PRECIO_LOTE, OID_PROVEEDOR, OID_PRODUCTO)
VALUES (1,1,100,1,2);

INSERT INTO LOTE (OID_LOTE, CANTIDAD_LOTE, PRECIO_LOTE, OID_PROVEEDOR, OID_PRODUCTO)
VALUES (2,1,100,2,4);

INSERT INTO LOTE (OID_LOTE, CANTIDAD_LOTE, PRECIO_LOTE, OID_PROVEEDOR, OID_PRODUCTO)
VALUES (3,1,100,3,6);

INSERT INTO LOTE (OID_LOTE, CANTIDAD_LOTE, PRECIO_LOTE, OID_PROVEEDOR, OID_PRODUCTO)
VALUES (4,1,100,4,8);

INSERT INTO LOTE (OID_LOTE, CANTIDAD_LOTE, PRECIO_LOTE, OID_PROVEEDOR, OID_PRODUCTO)
VALUES (5,1,100,5,10);

INSERT INTO LOTE (OID_LOTE, CANTIDAD_LOTE, PRECIO_LOTE, OID_PROVEEDOR, OID_PRODUCTO)
VALUES (6,1,100,6,12);
---------------------------------------------------------------------------------------------
--USUARIO
INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455A','Jaime','Cortes',TO_DATE('21/05/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,90,180,1,18);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455B','Jose','Cote',TO_DATE('28/05/1997', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,60,160,1,19);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455C','Daniel','Casanueva',TO_DATE('18/07/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,85,170,1,20);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455D','Antonio','Vazquez',TO_DATE('11/02/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,90,160,1,21);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455E','Ivan','Romero',TO_DATE('30/05/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,65,165,1,22);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455F','Jose','Maestre',TO_DATE('11/06/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,80,195,1,23);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455G','Alberto','Escalera',TO_DATE('23/08/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,75,180,1,24);

INSERT INTO USUARIO (DNI_USUARIO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CONTRASENYA, PUNTOS, PESO, ALTURA, OID_EMPRESA, OID_CONTACTO)
VALUES ('33344455H','Ismael','Masuco',TO_DATE('08/08/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'123',100,80,130,1,25);
--EMPLEADO
INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233A','Jaime','Cortes',TO_DATE('21/05/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'DIRECTOR','123',null,1,6);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233B','Roberto','Diaz',TO_DATE('23/08/1994', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'SUBDIRECTOR','123',null,1,7);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233C','Daniel','Casanueva',TO_DATE('24/09/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'JEFE_ENCARGADO_ALMACEN','123',null,1,8);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233D','Antonio','Vazquez',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'GERENTE','123',1,null,9);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233E','Ivan ','Romero',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'GERENTE','123',2,null,10);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233F','Ismael','Masuco',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'GERENTE','123',3,null,11);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233G','Alberto','Alberto',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'GERENTE','123',4,null,12);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233H','Naruto','Fernandez',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'GERENTE','123',5,null,13);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233J','Coquel','Vazquez',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_ALMACEN','123',1,null,15);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233K','Luffy','El peligroso',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_ALMACEN','123',2,null,16);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233L','Almendra','UltraInstinct',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_ALMACEN','123',3,null,35);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233M','Goku','Saiyan',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_ALMACEN','123',4,null,36);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233N','Ichigo','Hollow',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_ALMACEN','123',5,null,37);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233I','Abel','Mendez',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'PERSONAL_ADMINISTRATIVO','123',1,null,14);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233O','Asta','Luego',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'PERSONAL_ADMINISTRATIVO','123',2,null,38);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233P','Yuno','Mendez',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'PERSONAL_ADMINISTRATIVO','123',3,null,39);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233Q','Almendra','El fakin king',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'PERSONAL_ADMINISTRATIVO','123',4,null,40);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233R','El quinto','almendra',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'PERSONAL_ADMINISTRATIVO','123',5,null,41);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233S','Sasuke','Emo',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_TIENDA','123',1,null,42);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233T','Zoro','EL navaja',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_TIENDA','123',2,null,43);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233U','Tomate','El pistola',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_TIENDA','123',3,null,44);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233V','Fluzo','Mendez',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_TIENDA','123',4,null,45);

INSERT INTO EMPLEADO (DNI_EMPLEADO, NOMBRE, APELLIDOS, FECHA_NACIMIENTO, FECHA_ALTA_SISTEMA, FECHA_BAJA_SISTEMA, CARGO, CONTRASENYA, OID_FARMACIA, OID_EMPRESA, OID_CONTACTO)
VALUES ('11122233X','Daddy','Yankee',TO_DATE('11/04/1998', 'dd/MM/yyyy'),TO_DATE('30/05/2018', 'dd/MM/yyyy'),null,'ENCARGADO_TIENDA','123',5,null,46);
--NOMINAS
INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233A',2500,200,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233B',1700,300,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233C',1500,200,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233F',1400,200,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233X',1600,800,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233L',2200,200,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233T',1300,200,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);

INSERT INTO NOMINA (OID_NOMINA,DNI_EMPLEADO,SALARIO_BASE,SALARIO_VARIABLE,FECHA,COBRADA)
VALUES (1,'11122233P',1500,200,TO_DATE('11/04/2018', 'dd/MM/yyyy'),0);
--ALMACEN
INSERT INTO ALMACEN (OID_ALMACEN, ALMACEN_GENERAL, OID_EMPRESA, OID_FARMACIA)
VALUES (1,1,1,null);

INSERT INTO ALMACEN (OID_ALMACEN, ALMACEN_GENERAL, OID_EMPRESA, OID_FARMACIA)
VALUES (2,0,null,1);

INSERT INTO ALMACEN (OID_ALMACEN, ALMACEN_GENERAL, OID_EMPRESA, OID_FARMACIA)
VALUES (3,0,null,2);

INSERT INTO ALMACEN (OID_ALMACEN, ALMACEN_GENERAL, OID_EMPRESA, OID_FARMACIA)
VALUES (4,0,null,3);

INSERT INTO ALMACEN (OID_ALMACEN, ALMACEN_GENERAL, OID_EMPRESA, OID_FARMACIA)
VALUES (5,0,null,4);

INSERT INTO ALMACEN (OID_ALMACEN, ALMACEN_GENERAL, OID_EMPRESA, OID_FARMACIA)
VALUES (6,0,null,5);
--SECCION
INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (1,20,50,10,1,2);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (2,20,50,10,1,4);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (3,20,50,10,1,6);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (4,20,50,10,1,8);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (5,20,50,10,2,12);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (6,20,50,10,2,2);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (7,20,50,10,2,14);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (8,20,50,10,2,16);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (9,20,50,10,3,6);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (10,20,50,10,3,12);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (11,20,50,10,3,22);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (12,20,50,10,3,18);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (13,20,50,10,4,20);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (14,20,50,10,4,26);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (15,20,50,10,4,28);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (16,20,50,10,4,2);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (17,20,50,10,1,10);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (18,20,50,10,1,12);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (19,20,50,10,1,14);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (20,20,50,10,1,16);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (21,20,50,10,1,18);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (22,20,50,10,1,20);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (23,20,50,10,1,22);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (24,20,50,10,1,24);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (25,20,50,10,1,26);

INSERT INTO SECCION (OID_SECCION, STOCK_ACTUAL, STOCK_LIMITE, STOCK_SEGURIDAD, OID_ALMACEN, OID_PRODUCTO)
VALUES (26,20,50,10,1,28);
--ENVIO
INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (1,TO_DATE('18/04/2018', 'dd/MM/yyyy'),1,null,1);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (2,TO_DATE('12/04/2018', 'dd/MM/yyyy'),2,null,1);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (3,TO_DATE('14/04/2018', 'dd/MM/yyyy'),3,null,1);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (4,TO_DATE('15/04/2018', 'dd/MM/yyyy'),4,null,1);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (5,TO_DATE('16/04/2018', 'dd/MM/yyyy'),5,null,1);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (6,TO_DATE('20/04/2018', 'dd/MM/yyyy'),null,1,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (7,TO_DATE('14/04/2018', 'dd/MM/yyyy'),null,1,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (8,TO_DATE('11/04/2018', 'dd/MM/yyyy'),null,1,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (9,TO_DATE('10/04/2018', 'dd/MM/yyyy'),null,1,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (10,TO_DATE('20/04/2018', 'dd/MM/yyyy'),null,2,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (11,TO_DATE('14/04/2018', 'dd/MM/yyyy'),null,2,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (12,TO_DATE('11/04/2018', 'dd/MM/yyyy'),null,2,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (13,TO_DATE('10/04/2018', 'dd/MM/yyyy'),null,2,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (14,TO_DATE('20/04/2018', 'dd/MM/yyyy'),null,3,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (15,TO_DATE('14/04/2018', 'dd/MM/yyyy'),null,3,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (16,TO_DATE('11/04/2018', 'dd/MM/yyyy'),null,3,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (17,TO_DATE('10/04/2018', 'dd/MM/yyyy'),null,3,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (18,TO_DATE('20/04/2018', 'dd/MM/yyyy'),null,4,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (19,TO_DATE('14/04/2018', 'dd/MM/yyyy'),null,4,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (20,TO_DATE('11/04/2018', 'dd/MM/yyyy'),null,4,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (21,TO_DATE('21/04/2018', 'dd/MM/yyyy'),null,4,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (22,TO_DATE('20/04/2018', 'dd/MM/yyyy'),null,5,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (23,TO_DATE('14/04/2018', 'dd/MM/yyyy'),null,5,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (24,TO_DATE('11/04/2018', 'dd/MM/yyyy'),null,5,0);

INSERT INTO ENVIO (OID_ENVIO, FECHA_ENVIO, OID_PROVEEDOR, OID_ALMACEN, ESPROVEEDOR)
VALUES (25,TO_DATE('10/04/2018', 'dd/MM/yyyy'),null,5,0);
--PEDIDOS
INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (1,TO_DATE('10/04/2018', 'dd/MM/yyyy'),0,1,1,null,1);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (2,TO_DATE('23/04/2018', 'dd/MM/yyyy'),0,1,1,null,2);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (3,TO_DATE('25/04/2018', 'dd/MM/yyyy'),0,1,1,null,3);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (4,TO_DATE('12/04/2018', 'dd/MM/yyyy'),0,1,1,null,4);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (5,TO_DATE('10/04/2018', 'dd/MM/yyyy'),0,0,2,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (6,TO_DATE('18/04/2018', 'dd/MM/yyyy'),0,0,2,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (7,TO_DATE('20/04/2018', 'dd/MM/yyyy'),0,0,2,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (8,TO_DATE('16/04/2018', 'dd/MM/yyyy'),0,0,2,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (9,TO_DATE('10/04/2018', 'dd/MM/yyyy'),0,0,3,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (10,TO_DATE('18/04/2018', 'dd/MM/yyyy'),0,0,3,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (11,TO_DATE('20/04/2018', 'dd/MM/yyyy'),0,0,3,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (12,TO_DATE('16/04/2018', 'dd/MM/yyyy'),0,0,3,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (13,TO_DATE('10/04/2018', 'dd/MM/yyyy'),0,0,4,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (14,TO_DATE('18/04/2018', 'dd/MM/yyyy'),0,0,4,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (15,TO_DATE('20/04/2018', 'dd/MM/yyyy'),0,0,4,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (16,TO_DATE('16/04/2018', 'dd/MM/yyyy'),0,0,4,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (17,TO_DATE('10/04/2018', 'dd/MM/yyyy'),0,0,5,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (18,TO_DATE('18/04/2018', 'dd/MM/yyyy'),0,0,5,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (19,TO_DATE('20/04/2018', 'dd/MM/yyyy'),0,0,5,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (20,TO_DATE('16/04/2018', 'dd/MM/yyyy'),0,0,5,1,null);

INSERT INTO PEDIDO (OID_PEDIDO, FECHA_PEDIDO, ENVIADO, ESPROVEEDOR, OID_ALMACEN, OID_ALMACEN2, OID_PROVEEDOR)
VALUES (21,TO_DATE('16/04/2018', 'dd/MM/yyyy'),0,0,6,1,null);
--FACTURA
INSERT INTO FACTURA (OID_FACTURA,FECHA_FACTURA, PRECIO_ENVIO, OID_PEDIDO, OID_ENVIO, OID_ALMACEN)
VALUES (1,TO_DATE('16/04/2018', 'dd/MM/yyyy'),100,20,8,4);

INSERT INTO FACTURA (OID_FACTURA,FECHA_FACTURA, PRECIO_ENVIO, OID_PEDIDO, OID_ENVIO, OID_ALMACEN)
VALUES (2,TO_DATE('18/04/2018', 'dd/MM/yyyy'),150,10,10,3);

INSERT INTO FACTURA (OID_FACTURA,FECHA_FACTURA, PRECIO_ENVIO, OID_PEDIDO, OID_ENVIO, OID_ALMACEN)
VALUES (3,TO_DATE('20/04/2018', 'dd/MM/yyyy'),100,7,1,2);

INSERT INTO FACTURA (OID_FACTURA,FECHA_FACTURA, PRECIO_ENVIO, OID_PEDIDO, OID_ENVIO, OID_ALMACEN)
VALUES (4,TO_DATE('10/04/2018', 'dd/MM/yyyy'),100,17,1,5);
--LINEA
INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (1,10,1,null,1);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (2,10,2,null,2);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (3,10,3,null,3);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (4,10,4,null,4);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (5,10,5,null,5);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (6,10,6,null,6);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (7,10,7,null,1);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (8,10,8,null,2);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (9,10,9,null,3);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (10,10,10,null,4);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (11,10,11,null,5);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (12,10,12,null,6);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (13,10,13,24,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (14,10,14,26,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (15,10,15,28,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (16,10,16,2,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (17,10,17,4,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (18,10,18,6,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (19,10,19,8,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (20,10,20,10,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (21,10,20,12,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (22,10,1,null,3);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (23,10,10,16,null);

INSERT INTO LINEA (OID_LINEA,CANTIDAD,OID_PEDIDO,OID_PRODUCTO,OID_LOTE)
VALUES (24,10,6,18,null);
--PEDIDO USUARIO
INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (1,'33344455A',TO_DATE('20/04/2018', 'dd/MM/yyyy'),0,null,0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (2,'33344455B',TO_DATE('23/04/2018', 'dd/MM/yyyy'),1,'126456789123456',0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (3,'33344455C',TO_DATE('29/04/2018', 'dd/MM/yyyy'),0,null,0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (4,'33344455C',TO_DATE('30/04/2018', 'dd/MM/yyyy'),0,null,0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (5,'33344455D',TO_DATE('21/04/2018', 'dd/MM/yyyy'),1,'123456789127456',0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (6,'33344455E',TO_DATE('18/04/2018', 'dd/MM/yyyy'),0,null,0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (7,'33344455F',TO_DATE('16/04/2018', 'dd/MM/yyyy'),1,'123452789123456',0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (8,'33344455G',TO_DATE('12/04/2018', 'dd/MM/yyyy'),0,null,0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (9,'33344455H',TO_DATE('20/04/2018', 'dd/MM/yyyy'),1,'123456789123456',0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (10,'33344455A',TO_DATE('17/04/2018', 'dd/MM/yyyy'),0,null,0);

INSERT INTO PEDIDO_USUARIO (OID_PEDIDO_USUARIO, DNI_USUARIO, FECHA_SOLICITUD, CONTRAREEMBOLSO_TARJETA, TARJETA,PREPARADO)
VALUES (11,'33344455A',TO_DATE('30/04/2018', 'dd/MM/yyyy'),0,null,0);
--BOLSA
INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (1,1,2,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (2,2,4,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (3,3,6,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (4,4,8,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (5,5,10,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (6,6,12,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (7,7,14,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (8,8,16,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (9,9,18,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (10,10,20,3);

INSERT INTO BOLSA (OID_BOLSA, OID_PEDIDO_USUARIO, OID_PRODUCTO, CANTIDAD)
VALUES (11,11,22,3);
