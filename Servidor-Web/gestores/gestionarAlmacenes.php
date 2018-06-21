<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de almacenes de la capa de acceso a datos 		
     * #==========================================================#
     */
 function rescatarAlmacenGeneral($conexion){
 	try{
 		$consulta="select oid_almacen from almacen where oid_empresa is not null";
		return $conexion->query($consulta);
 	}catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
 	} 
}  
function consultarTodosAlmacenes($conexion) {
	$consulta = "SELECT * FROM ALMACEN WHERE OID_FARMACIA IS NOT NULL";
    return $conexion->query($consulta);
}

function consultarAlmacenPorOID($conexion,$oidAlmacen) {
	try {
		$consulta = "SELECT * FROM ALMACEN"
		. " WHERE OID_ALMACEN = ".$oidAlmacen;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}

function consultarAlmacenPorFarmacia($conexion,$oidFarmacia) {
	try {
		$consulta = "SELECT * FROM ALMACEN"
		. " WHERE OID_FARMACIA = ".$oidFarmacia;
		return $conexion->query($consulta);
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}
  
function quitar_almacen($conexion,$oidAlmacen) {
	try {
		$stmt=$conexion->prepare('CALL DELETE_ALMACEN(:oidAlmacen)');
		$stmt->bindParam(':oidAlmacen',$oidAlmacen);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function crear_almacen($conexion, $oidFarmacia) {
	try {
		$stmt=$conexion->prepare('CALL NEW_ALMACEN_FARMACIA(:oidFarmacia)');
		$stmt->bindParam(':oidFarmacia',$oidFarmacia);
		$stmt->execute();
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}

//Funciones para validacion

function existeFarmacia($conexion, $oid) {
		$consulta = "SELECT COUNT(*) FROM FARMACIA WHERE OID_FARMACIA ='".$oid."'";
		return $conexion->query($consulta)->fetch()[0];
}

function farmaciaVinculada($conexion, $oid) {
		$consulta_farmacia_disponible = "SELECT COUNT(*) FROM ALMACEN WHERE OID_FARMACIA ='".$oid."'";
		return $conexion->query($consulta_farmacia_disponible)->fetch()[0];
}
?>