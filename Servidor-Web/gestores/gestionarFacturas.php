<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de facturas de la capa de acceso a datos 		
     * #==========================================================#
     */
     
function consultarTodosFacturas() {
	$consulta = "SELECT * FROM FACTURA";
    return $consulta;
}
function consultarTodosFacturas2($conexion) {
	$consulta = "SELECT * FROM FACTURA";
    return $conexion->query($consulta);
}

function crear_factura($conexion, $precio, $pedido, $almacen, $envio) {
	try {
		$consulta = "INSERT INTO factura (oid_almacen, oid_pedido, oid_envio, PRECIO_ENVIO)
                VALUES    (".$almacen.", ".$pedido.", ".$envio.", ".$precio.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_factura($conexion, $oidFactura) {
	try {
		$stmt=$conexion->prepare('DELETE FROM factura WHERE OID_factura = :factura');
		$stmt->bindParam(':factura',$oidFactura);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function consultarFacturasPorPedido($pedido) {
		$consulta = "SELECT * FROM FACTURA WHERE OID_PEDIDO = ".$pedido;
		return $consulta;
}
function consultarFacturasPorPedido1($conexion, $pedido) {
		try {	
		$consulta = "SELECT * FROM FACTURA WHERE OID_PEDIDO = ". $pedido;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}


function consultarFacturasPorAlmacen($oidAlmacen) {
		$consulta = "SELECT * FROM FACTURA"
		. " WHERE OID_ALMACEN = ".$oidAlmacen;
		return $consulta;
}

function consultarFacturasPorEnvio($envio) {
		$consulta = "SELECT * FROM FACTURA"
		. " WHERE OID_ENVIO = ".$envio;
		return $consulta;
}

function consultarFacturasPorFecha($fecha) {
		$formato = "'yyyy-MM-dd'";
		$consulta = "SELECT * FROM FACTURA"
		. " WHERE FECHA_FACTURA >= TO_DATE('".$fecha."', ".$formato.")";
		return $consulta;
}

//Funciones para validacion

function existePedido($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM pedido WHERE OID_pedido ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function pedidoEnviado($conexion, $oid) {
		$consulta = "SELECT enviado FROM pedido WHERE OID_pedido ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function existeEnvio($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM envio WHERE OID_envio ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

?>