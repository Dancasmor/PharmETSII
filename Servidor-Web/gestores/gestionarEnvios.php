<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de envios de la capa de acceso a datos 		
     * #==========================================================#
     */
     
function consultarTodosEnvios() {
	$consulta = "SELECT * FROM ENVIO";
    return $consulta;
}

function consultarTodosEnvios2($conexion) {
	$consulta = "SELECT * FROM ENVIO";
    return $conexion->query($consulta);
}

function crear_envio_almacen_general($conexion, $oidAlmacen, $fecha) {
	try {
		$formato = "'yyyy-MM-dd'";
		$consulta = "CALL New_envio_almacen(TO_DATE('".$fecha."', ".$formato."), ".$oidAlmacen.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function crear_envio_proveedor($conexion, $oidProveedor, $fecha) {
	try {
		$formato = "'yyyy-MM-dd'";
		$consulta = "CALL New_envio_proveedor(TO_DATE('".$fecha."', ".$formato."), ".$oidProveedor.")";
		$conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

function borrar_envio($conexion, $oidEnvio) {
	try {
		$stmt=$conexion->prepare('DELETE FROM envio WHERE OID_envio = :oidEnvio');
		$stmt->bindParam(':oidEnvio',$oidEnvio);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function consultarEnviosPorProveedor($oidProveedor) {
		$consulta = "SELECT * FROM ENVIO"
		. " WHERE OID_PROVEEDOR = ".$oidProveedor;
		return $consulta;
}

function consultarEnviosPorAlmacen($oidAlmacen) {
		$consulta = "SELECT * FROM ENVIO"
		. " WHERE OID_ALMACEN = ".$oidAlmacen;
		return $consulta;
}

function consultarEnviosPorFecha($fecha) {
		$formato = "'yyyy-MM-dd'";
		$consulta = "SELECT * FROM ENVIO"
		. " WHERE FECHA_ENVIO >= TO_DATE('".$fecha."', ".$formato.")";
		return $consulta;
}

//Funciones para validacion

function existeAlmacen($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM Almacen WHERE OID_almacen ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function existeProveedor($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM proveedor WHERE OID_PROVEEDOR ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}
?>