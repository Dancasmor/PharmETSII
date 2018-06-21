<?php
    /*
     * #==========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de farmacias de la capa de acceso a datos 		
     * #==========================================================#
     */
//Funcion para consultar todas las farmacias
function consultarTodasFarmacias($conexion) {
	$consulta = "select * from farmacia";
	return $conexion->query($consulta);
}

function consultarTodasEmpresas($conexion){
	$consulta = "select * from empresa";
	return $conexion->query($consulta);
}

//Funcion para consultar las farmacias por id
function consultarFarmaciaPorId($conexion,$oidFarmacia) {
	try {
		$consulta = "select * from farmacia where oid_farmacia = ".$oidFarmacia;
		return $conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
		return "";
	}
}
//Funcion para consultar las farmacias por nombre
function consultarFarmaciaPorNombre($conexion,$nombre) {
	try {
		$consulta = "select * from farmacia where nombre = '".$nombre."'";
		return $conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
		return "";
	}
}
//Funcion para crear cuentas bancarias
/*
function crearFarmacia($conexion,$nombre,$oidContacto,$idCuentaBancaria) {
	try {
		$stmt=$conexion->prepare('call nueva_farmacia(:nombre,:oid_contacto,:id_cuenta_bancaria)');
		$stmt->bindParam(':nombre',$nombre);
		$stmt->bindParam(':oid_contacto',$oidContacto);
		$stmt->bindParam(':id_cuenta_bancaria',$idCuentaBancaria);
		$stmt->execute();
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
	}
}
*/
function crearFarmacia($conexion,$nombre,$oidContacto){
	try{
		$consulta="insert into farmacia (nombre, oid_contacto, id_cuenta_bancaria) 
			       values ('".$nombre."',".$oidContacto.", null)";
		$conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
	}
}
//Funcion para eliminar farmacias
function eliminarFarmacia($conexion,$oidFarmacia) {
	try {
		$stmt=$conexion->prepare('call eliminar_farmacia(:oid_farmacia)');
		$stmt->bindParam(':oid_farmacia',$oidFarmacia);
		$stmt->execute();
		return "";
	}catch(PDOException $e) {
		return $e->getMessage();
    }			
}  
//Funciones para validacion
function existeFarmacia($conexion,$nombre){
	$consulta="select count(*) from farmacia where nombre= '".$nombre."'";
	return $conexion->query($consulta)->fetch()[0];
}
function existeContacto($conexion,$oidContacto){
	$consulta="select count(*) from contacto where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoEmpresa($conexion,$oidContacto){
	$consulta="select count(*) from empresa where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoFarmacia($conexion,$oidContacto){
	$consulta="select count(*) from farmacia where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoProveedor($conexion,$oidContacto){
	$consulta="select count(*) from proveedor where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoEmpleado($conexion,$oidContacto){
	$consulta="select count(*) from empleado where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoUsuario($conexion,$oidContacto){
	$consulta="select count(*) from usuario where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}

?>