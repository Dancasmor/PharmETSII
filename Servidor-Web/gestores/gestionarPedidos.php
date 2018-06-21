<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de pedidos de la capa de acceso a datos 		
     * #==========================================================#
     */
     
function consultarTodosPedidos() {
	$consulta = "SELECT * FROM PEDIDO";
    return $consulta;
}
function consultarTodosPedidos2($conexion) {
	$consulta = "SELECT * FROM PEDIDO";
    return $conexion->query($consulta);
}

function crear_pedido_farmacia($conexion, $oidAlmacen) {
	try {
		$stmt=$conexion->prepare('CALL NEW_PEDIDO_GENERAL(:oidAlmacen)');
		$stmt->bindParam(':oidAlmacen',$oidAlmacen);
		$stmt->execute();
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_pedido_proveedor($conexion, $oidProveedor) {
	try {
		$stmt=$conexion->prepare('CALL NEW_PEDIDO_PROVEEDOR(:oidProveedor)');
		$stmt->bindParam(':oidProveedor',$oidProveedor);
		$stmt->execute();
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function enviar_pedido($conexion, $oidPedido) {
	try {
		$stmt=$conexion->prepare('CALL ENVIAR_PEDIDO(:oidPedido)');
		$stmt->bindParam(':oidPedido',$oidPedido);
		$stmt->execute();
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_pedido($conexion, $oidPedido) {
	try {
		$stmt=$conexion->prepare('CALL DELETE_PEDIDO(:oidPedido)');
		$stmt->bindParam(':oidPedido',$oidPedido);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function consultarPedidosPorProveedor($oidProveedor) {
	
	$consulta = "SELECT * FROM PEDIDO"
	. " WHERE OID_PROVEEDOR = ".$oidProveedor;
	return $consulta;
	
}

function consultarPedidosPorAlmacen($conexion, $oidAlmacen) {
	try {	
		$consulta = "SELECT * FROM PEDIDO"
	. " WHERE OID_ALMACEN = ".$oidAlmacen;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function consultarPedidosPorFecha($fecha) {
	
	$formato = "'yyyy-MM-dd'";
	$consulta = "SELECT * FROM PEDIDO"
	. " WHERE FECHA_PEDIDO >= TO_DATE('".$fecha."', ".$formato.")";
	return $consulta;
	
}

//Validar

function almacenGeneral($conexion) {
		$consulta = "SELECT OID_ALMACEN FROM ALMACEN WHERE OID_FARMACIA is null";
		return $conexion->query($consulta)->fetch()[0];
}

?>