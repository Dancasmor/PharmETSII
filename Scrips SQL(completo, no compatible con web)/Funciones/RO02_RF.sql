--RO02-RF01-Empleados
--Procedure para crear empleado
CREATE OR REPLACE PROCEDURE nuevo_empleado(
    P_dni           IN      empleado.dni_empleado%TYPE,
    P_nombre       	IN      empleado.nombre%TYPE,
    P_apellidos     IN      empleado.apellidos%TYPE,
    P_fecha_nacim	IN 		empleado.fecha_nacimiento%TYPE,
    P_contacto		IN 		empleado.oid_contacto%TYPE,
    P_fecha_alta	IN 		empleado.fecha_alta_sistema%TYPE,
    P_farmacia		IN 		empleado.oid_farmacia%TYPE,
    P_empresa		IN 		empleado.oid_empresa%TYPE,
    P_contrasenya	IN 		empleado.contrasenya%TYPE,
    P_cargo			IN 		empleado.cargo%TYPE
)AS 
BEGIN
    INSERT INTO empleado (dni_empleado, nombre, apellidos, fecha_nacimiento, oid_contacto, fecha_alta_sistema,  oid_farmacia, oid_empresa, contrasenya, cargo)
                VALUES    (P_dni, P_nombre, P_apellidos, P_fecha_nacim, P_contacto, P_fecha_alta,  P_farmacia, P_empresa,P_contrasenya, P_cargo);
END;
/
--Procedure para eliminar empleados
CREATE OR REPLACE PROCEDURE eliminar_empleado(
    P_dni   IN  empleado.dni_empleado%TYPE
)AS 
BEGIN
    DELETE FROM empleado WHERE dni_empleado = P_dni;
END;
/

--RO02-RF02-Farmacias
--Procedure para crear farmacias
CREATE OR REPLACE PROCEDURE nueva_farmacia(
    P_nombre           IN   farmacia.nombre%TYPE,
    P_contacto      IN      farmacia.oid_contacto%TYPE,
    P_cuenta_banc	IN 		farmacia.id_cuenta_bancaria%TYPE
)AS 
BEGIN
    INSERT INTO farmacia (nombre,oid_contacto, id_cuenta_bancaria)
                VALUES    (P_nombre,P_contacto, P_cuenta_banc);
END;
/
--Procedure para eliminar farmacias
CREATE OR REPLACE PROCEDURE eliminar_farmacia(
    P_oid   IN  farmacia.oid_farmacia%TYPE
)AS 
BEGIN
    DELETE FROM farmacia WHERE oid_farmacia = P_oid;
END;
/

--RO02-RF03-Productos
--Procedure para crear productos
CREATE OR REPLACE PROCEDURE nuevo_producto(
    P_nombre      	IN      producto.nombre%TYPE,
    P_precio_venta  IN      producto.precio_venta%TYPE,
    P_imagen		IN 		PRODUCTO.URL_IMAGENES%TYPE,
    P_puntos	    IN      producto.puntos%TYPE,
    P_receta 		IN 		PRODUCTO.RECETA%TYPE
)AS 
BEGIN
    INSERT INTO producto (nombre, precio_venta, URL_IMAGENES, puntos, receta)
                VALUES    (P_nombre, P_precio_venta, P_imagen, P_puntos, P_receta);
END;
/
--Procedure para eliminar productos
CREATE OR REPLACE PROCEDURE eliminar_producto(
    P_oid   IN  producto.oid_producto%TYPE
)AS 
BEGIN
    DELETE FROM producto WHERE oid_producto = P_oid;
END;
/

--RO02-RF04-Usuarios
--Procedure para crear usuarios
CREATE OR REPLACE PROCEDURE nuevo_usuario(
    P_dni           IN      usuario.dni_usuario%TYPE,
    P_nombre       	IN      usuario.nombre%TYPE,
    P_apellidos     IN      usuario.apellidos%TYPE,
    P_fecha_nacim	IN 		usuario.fecha_nacimiento%TYPE,
    P_contacto		IN 		usuario.oid_contacto%TYPE,
    P_fecha_alta	IN 		usuario.fecha_alta_sistema%TYPE,
    P_empresa		IN 		usuario.oid_empresa%TYPE,
    P_contrasenya	IN 		usuario.contrasenya%TYPE,
    P_puntos		IN 		usuario.puntos%TYPE,
    P_peso 			IN 		usuario.peso%TYPE,
    P_altura		IN 		usuario.altura%TYPE
)AS 
BEGIN
    INSERT INTO usuario (dni_usuario, nombre, apellidos, fecha_nacimiento, oid_contacto, fecha_alta_sistema,
            oid_empresa, contrasenya, puntos, peso, altura)
                VALUES    (P_dni, P_nombre, P_apellidos, P_fecha_nacim, P_contacto, P_fecha_alta,
                P_empresa, P_contrasenya, P_puntos, P_peso, P_altura);
END;
/

--Procedure para eliminar usuarios
CREATE OR REPLACE PROCEDURE eliminar_usuario(
    P_dni   IN  usuario.dni_usuario%TYPE
)AS 
BEGIN
    DELETE FROM usuario WHERE dni_usuario = P_dni;
END;
/