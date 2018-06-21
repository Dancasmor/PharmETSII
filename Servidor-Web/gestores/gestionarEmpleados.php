<?php
 	/*
     * #==========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de empleados de la capa de acceso a datos 		
     * #==========================================================#
     */
//Funcion para cambiar contraseña empleados
function cambiarContraseñaEmpleado($conexion,$dniEmpleado,$contraseña){
	try {
		$stmt=$conexion->prepare("update empleado set contrasenya= '".$contraseña."where dni_empleado= '".$dniEmpleado);
		$stmt->execute();
	}catch(PDOException $e) {
		return $e->getMessage();
	}	
} 
//Funcion para consultar todos los empleados de la base de datos   
function consultarTodosEmpleados() {
	$consulta = "select * from empleado";
    return $consulta;
}
function consultarTodosEmpleados2($conexion) {
	$consulta = "select * from empleado";
    return $conexion->query($consulta);
}
//Funcion para consultar los empleados por dni
function consultarEmpleadosPorDni($dniEmpleado) {
		$consulta = "select * from empleado where dni_empleado ='".$dniEmpleado."'";
		return $consulta;
}
//Funcion para consultar empleados por id de farmacia
function consultarEmpleadosPorFarmacia($oidFarmacia) {
		$consulta = "select * from empleado where oid_farmacia = ".$oidFarmacia;
		return $consulta;
}
//Funcion para crear empleados de empresa
function crearEmpleadoEmpresa($conexion,$dniEmpleado,$nombre,$apellidos,$fechaNacimiento,$oidContacto,$fechaAltaSistema,
							  $oidEmpresa,$contraseña,$cargo) {
		try {	
		$formato = "'yyyy-MM-dd'";
		$consulta= "insert into empleado (dni_empleado, nombre, apellidos, fecha_nacimiento, oid_contacto,
		 								  fecha_alta_sistema,oid_farmacia,oid_empresa, contrasenya, cargo) 
					values ('".$dniEmpleado."','".$nombre."','".$apellidos."', to_date('".$fechaNacimiento."',".$formato."),".$oidContacto.",
							to_date('".$fechaAltaSistema."',".$formato."),null,".$oidEmpresa.",'".$contraseña."','".$cargo."')";
		$conexion->query($consulta);
		return "creado empleado empresa";
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
	}
}		 	
//Funcion para crear empleados de farmacia
function crearEmpleadoFarmacia($conexion,$dniEmpleado,$nombre,$apellidos,$fechaNacimiento,$oidContacto,$fechaAltaSistema,
							   $oidFarmacia,$contraseña,$cargo) {
		try {
		$formato = "'yyyy-MM-dd'";
		$consulta= "insert into empleado (dni_empleado, nombre, apellidos, fecha_nacimiento, oid_contacto,
		 								  fecha_alta_sistema,oid_farmacia,oid_empresa, contrasenya, cargo) 
					values ('".$dniEmpleado."','".$nombre."','".$apellidos."', to_date('".$fechaNacimiento."',".$formato."),".$oidContacto.",
							to_date('".$fechaAltaSistema."',".$formato."),".$oidFarmacia.",null,'".$contraseña."','".$cargo."')";
		$conexion->query($consulta);
		return "creado empleado farmacia";
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
	}
}		   
//Funcion para eliminar empleado
function eliminarEmpleado($conexion, $dniEmpleado) {
	try {
		$stmt=$conexion->prepare('call eliminar_empleado(:dni_empleado)');
		$stmt->bindParam(':dni_empleado',$dniEmpleado);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}
//Funciones para validacion
function existeDniEmpleado($conexion,$dniEmpleado){
	$consulta="select count(*) from empleado where dni_empleado= '".$dniEmpleado."'";
	return $conexion->query($consulta)->fetch()[0];
}
function existeContacto1($conexion,$oidContacto){
	$consulta="select count(*) from contacto where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoEmpresa1($conexion,$oidContacto){
	$consulta="select count(*) from empresa where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoFarmacia1($conexion,$oidContacto){
	$consulta="select count(*) from farmacia where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoProveedor1($conexion,$oidContacto){
	$consulta="select count(*) from proveedor where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoEmpleado1($conexion,$oidContacto){
	$consulta="select count(*) from empleado where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoUsuario1($conexion,$oidContacto){
	$consulta="select count(*) from usuario where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeEmpresa1($conexion,$oidEmpresa){
	$consulta="select count(*) from empresa where oid_empresa= ".$oidEmpresa;
	return $conexion->query($consulta)->fetch()[0];
}
function existeFarmacia1($conexion,$oidFarmacia){
	$consulta="select count(*) from farmacia where oid_farmacia= ".$oidFarmacia;
	return $conexion->query($consulta)->fetch()[0];
}
?>