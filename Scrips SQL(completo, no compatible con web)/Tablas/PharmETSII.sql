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




