<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de lineas de la capa de acceso a datos 		
     * #==========================================================#
     */
     
function consultarTodosLineas($conexion) {
	$consulta = "SELECT * FROM LINEA";
    return $conexion->query($consulta);
}

function consultarSeccionPorOIDAlmacen($conexion, $oidAlmacen){
	try {	
		$consulta = "SELECT * FROM SECCION WHERE OID_ALMACEN = '". $oidAlmacen ."'";
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_linea_lote($conexion, $pedido, $cantidad, $lote) {
	try {
		$consulta = "INSERT INTO linea (oid_pedido, oid_lote, cantidad)
                VALUES    (".$pedido.", ".$lote.", ".$cantidad.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_linea_producto($conexion, $pedido, $cantidad, $producto) {
	try {
		$consulta = "INSERT INTO linea (oid_pedido, oid_producto, cantidad)
                VALUES    (".$pedido.", ".$producto.", ".$cantidad.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage() . $consulta;
    }
}

function borrar_linea($conexion, $linea) {
	try {
		$stmt=$conexion->prepare('DELETE FROM linea WHERE OID_linea = :linea');
		$stmt->bindParam(':linea',$linea);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function consultarLineasPorPedido($conexion, $pedido) {
	try {
		$consulta = "SELECT * FROM LINEA"
		. " WHERE OID_PEDIDO = ".$pedido;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}

function consultarLineasPorLote($conexion, $lote) {
	try {
		$consulta = "SELECT * FROM LINEA"
		. " WHERE OID_LOTE = ".$lote;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}

function consultarLineasPorProducto($conexion, $producto) {
	try {
		$consulta = "SELECT * FROM LINEA"
		. " WHERE OID_PRODUCTO = ".$producto;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}

//Funciones para validacion

function existePedido1($conexion, $oid) {
		$consulta1 = "SELECT oid_pedido FROM pedido WHERE OID_pedido ='".$oid."'";
		$_SESSION["id_pedido"] = $conexion->query($consulta1)->fetch()[0];
		$consulta = "SELECT COUNT(*) FROM pedido WHERE OID_pedido ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function esAlmacen($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM pedido WHERE OID_pedido ='".$oid."' and esproveedor=0";
		return $conexion->query($consulta)->fetch()[0];
}

function esProveedor($conexion, $oid) {
		$consulta1 = "SELECT oid_proveedor FROM pedido WHERE OID_pedido ='".$oid."'";
		$_SESSION["id"] = $conexion->query($consulta1)->fetch()[0];
		$consulta = "SELECT COUNT(*) FROM pedido WHERE OID_pedido ='".$oid."' and esproveedor=1";
		return $conexion->query($consulta)->fetch()[0];
}

function existeProducto($conexion, $oid) {
		$consulta1 = "SELECT oid_producto FROM producto WHERE OID_producto ='".$oid."'";
		$_SESSION["id_producto"] = $conexion->query($consulta1)->fetch()[0];
		$consulta = "SELECT COUNT(*) FROM producto WHERE OID_producto ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function existeLote($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM lote WHERE OID_lote ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function coincideProveedor($conexion, $oid, $proveedor){
		$consulta = "SELECT COUNT(*) FROM lote WHERE OID_lote ='".$oid."' and oid_proveedor ='".$proveedor."'";
		return $conexion->query($consulta)->fetch()[0];
}

function cantidadValida($conexion, $oid, $cantidad, $pedido){
		$consulta = "SELECT es_valido(".$oid.", ".$cantidad.", ".$pedido.") FROM DUAL";
		return $conexion->query($consulta)->fetch()[0];
}

?>