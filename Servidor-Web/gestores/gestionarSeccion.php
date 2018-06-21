<?php

function consultarTodasSecciones($conexion) {
	$consulta = "select * from seccion";
	return $conexion->query($consulta);
}

function almacenGeneral($conexion){
	$consulta = "select oid_almacen from almacen where oid_farmacia is null";
	return $conexion->query($consulta)->fetch()[0];
}

function consultarSeccionPorOID($conexion, $oidSeccion) {
	try {	
		$consulta = "SELECT * FROM SECCION WHERE OID_SECCION = '". $oidSeccion ."'";
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function consultarSeccionPorOIDAlmacen($conexion, $oidAlmacen){
	try {	
		$consulta = "SELECT * FROM SECCION WHERE OID_ALMACEN = '". $oidAlmacen ."'";
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function consultarSeccionPorOIDproducto($conexion, $oidProducto){
	try {	
		$consulta = "SELECT * FROM SECCION WHERE OID_PRODUCTO = '". $oidProducto ."'";
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_seccion($conexion, $oidAlmacen, $oidProducto) {
	try {
		$consulta = "INSERT INTO seccion(oid_almacen, oid_producto) VALUES('". $oidAlmacen ."','". $oidProducto ."')";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_seccion($conexion, $oidSeccion) {
	try {
		$stmt=$conexion->prepare('DELETE FROM seccion WHERE OID_SECCION = :oidSeccion');
		$stmt->bindParam(':oidSeccion',$oidSeccion);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function añadir_cantidad_seccion($conexion, $idSeccion, $cantidad) {
	try {
		$consulta = "Call Sum_cantidad(".$idSeccion.", ".$cantidad.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function restar_cantidad_seccion($conexion, $idSeccion, $cantidad) {
	try {
		$consulta = "Call Rest_cantidad(".$idSeccion.", ".$cantidad.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}


function existeProducto($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM PRODUCTO WHERE OID_PRODUCTO ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function existeAlmacen($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM ALMACEN WHERE OID_ALMACEN ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

?>