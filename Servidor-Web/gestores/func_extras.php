<?php
    function consultarTodosProductosB($conexion) {
	$consulta = "SELECT * FROM PRODUCTO";
    return $conexion->query($consulta);
	}
	function consultarProductoNombreB($conexion,$nombre){
		$consulta = "SELECT * FROM PRODUCTO WHERE NOMBRE LIKE '%".$nombre."%'";
		return $conexion->query($consulta);
	}
	function consultarTodosPedidosUsuarioB($conexion){
		$consulta = "SELECT * FROM PEDIDO_USUARIO ORDER BY OID_PEDIDO_USUARIO";
		return $conexion->query($consulta);
	}
	function consultarTodosAlmacenesB($conexion){
		$consulta = "SELECT * FROM ALMACEN";
		return $conexion->query($consulta);
	}
	function consultarTodosProveedoresB($conexion){
		$consulta = "SELECT * FROM PROVEEDOR";
		return $conexion->query($consulta);
	}
	function comprobarContraseñas($contraseña1,$contraseña2){
		return $contraseña1==$contraseña2;
	}
	
	function extraeEmpresa($conexion){
		$consulta = "SELECT oid_empresa FROM EMPRESA";
		return $conexion->query($consulta)->fetch()[0];
	}
	
	function crearProveedor($conexion,$nombreLab,$precioEnvioSinGastos,$oidContacto,$contraseña) {
	try {
		$stmt=$conexion->prepare('INSERT INTO PROVEEDOR (OID_PROVEEDOR,CONTRASEÑA,NOMBRE_LAB,PRECIO_ENVIO_SIN_GASTOS,OID_CONTACTO) VALUES (0,:contraseña,:nombre_lab,:precio_envio_sin_gastos,:oid_contacto)');
		$stmt->bindParam(':nombre_lab',$nombreLab);
		$stmt->bindParam(':precio_envio_sin_gastos',$precioEnvioSinGastos);
		$stmt->bindParam(':oid_contacto',$oidContacto);
		$stmt->bindParam(':contraseña',$contraseña);
		$stmt->execute();
		return "proveedor creado";
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
	}
}
	function ultimoOidContacto($conexion) {
	$consulta = "SELECT max(TO_NUMBER(oid_contacto)) FROM CONTACTO ORDER BY OID_CONTACTO DESC";
    return $conexion->query($consulta)->fetch()[0];
	}


?>