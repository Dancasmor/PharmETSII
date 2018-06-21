<?php
 	/*
     * #==========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de nominas de la capa de acceso a datos 		
     * #==========================================================#
     */
//Funcion para consultar todos los empleados de la base de datos   
function consultarTodasNominas() {
	$consulta = "select * from nomina";
    return $consulta;
}
function consultarTodasNominas1($conexion) {
	$consulta = "select * from nomina";
    return $conexion->query($consulta);
}
//Funcion para consultar las nominas por id
function consultarNominasPorId($oidNomina) {
		$consulta = "select * from nomina where oid_nomina =".$oidNomina;
		return $consulta;
}
//Funcion para consultar las nominas por dni empleado
function consultarNominasPorEmpleado($dniEmpleado) {
		$consulta = "select * from nomina where dni_empleado ='".$dniEmpleado."'";
		return $consulta;
}
function consultarNominasPorDNI($conexion, $dniEmpleado){
	try {
		$consulta = "select * from nomina where dni_empleado ='".$dniEmpleado."'";
		return $conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
		return "";
	}
}

//Funcion para consultar nominas por fecha
function consultarnNominasPorFecha($fecha) {
		$formato = "'yyyy-MM-dd'";
		$consulta = "select * from nomina where fecha >= to_date('".$fecha."', ".$formato.")";
		return $consulta;
}
//Funcion para crear nominas
function crearNomina($conexion,$dniEmpleado,$salarioBase,$salarioVariable,$fecha) {
		try {
		$formato = "'yyyy-MM-dd'";
		$consulta = "insert into nomina (dni_empleado, salario_base, salario_variable, fecha, cobrada) values 
					 ('".$dniEmpleado."',".$salarioBase.",".$salarioVariable.", to_date('".$fecha."',".$formato."),0)";
		
		$conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"]=$e->getMessage();
	}
}
//Funcion para eliminar nomina
function eliminarNomina($conexion, $oidNomina) {
	try {
		$stmt=$conexion->prepare('call delete_nomina(:oid_nomina)');
		$stmt->bindParam(':oid_nomina',$oidNomina);
		$stmt->execute();
		return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}
//Funcion para cobrar nominas
function cobrarNomina($conexion, $oidNomina) {
	try {
		$stmt=$conexion->prepare('call cobrar_nomina(:oid_nomina)');
		$stmt->bindParam(':oid_nomina',$oidNomina);
		$stmt->execute();
	} catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
    }
}
//Funciones para validacion
function existeDniNomina($conexion,$dniEmpleado){
	session_start();
	$consulta1 = "SELECT dni_empleado FROM empleado WHERE dni_empleado ='".$dniEmpleado."'";
	$_SESSION["dni"] = $conexion->query($consulta1)->fetch()[0];
	$consulta="select count(*) from empleado where dni_empleado= '".$dniEmpleado."'";
	return $conexion->query($consulta)->fetch()[0];
}
function validarNominaEmpleado($conexion,$dniEmpleado){
	$consulta="select count(*) from nomina where dni_empleado= '".$dniEmpleado."'";
}
function validarNominaFecha($conexion,$fecha){
	$formato = "'yyyy-MM-dd'";
	$consulta="select count(*) from nomina where fecha= to_date('".$fecha."',".$formato.")";
}

?>