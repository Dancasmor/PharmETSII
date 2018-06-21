<?php
  	/*
     * #==========================================================#
     * #	Este fichero contiene las funciones de gestión     			 
     * #	de proveedores de la capa de acceso a datos 		
     * #==========================================================#
     */
//Funcion para cambiar contraseña proveedor
function cambiarContraseñaProveedor($conexion,$nombreLab,$contraseña){
	try {
		$stmt=$conexion->prepare("update proveedor set contraseña= '".$contraseña."where nombre_lab= '".$nombreLab);
		$stmt->execute();
	}catch(PDOException $e) {
		return $e->getMessage();
	}	
}  
//Funcion para consultar todos los proveedores   
function consultarTodosProveedores($conexion) {
	$consulta="select * from proveedor";
	return $conexion->query($consulta);
} 
//Funcion para consultar los proveedores por id
function consultarProveedoresId($conexion,$oidProveedor) {
	try {
		$consulta="select * from proveedor where oid_proveedor = ".$oidProveedor;
		return $conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}
//Funcion para consultar proveedores por nombre
function consultarProveedoresNombre($conexion,$nombreLab) {
	try {
		$consulta="select * from proveedor where nombre_lab = '".$nombreLab."'";
		return $conexion->query($consulta);
	}catch(PDOException $e) {
		$_SESSION["excepcion"] = $e->getMessage();
		return "";
    }
}
//Funcion para crear proveedores
function crearProveedor($conexion,$nombreLab,$precioEnvioSinGastos,$oidContacto,$contraseña) {
	try {
		$stmt=$conexion->prepare('call new_proveedor(:nombre_lab,:precio_envio_sin_gastos,:oid_contacto,:contraseña)');
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
//Funcion para eliminar proveedores
function  eliminarProveedor($conexion,$oidProveedor) {
	try {
		$stmt=$conexion->prepare('call delete_proveedor(:oid_proveedor)');
		$stmt->bindParam(':oid_proveedor',$oidProveedor);
		$stmt->execute();
		return "";
	}catch(PDOException $e) {
		return $e->getMessage();
    }			
} 
//Funciones para validacion
function existeProveedor($conexion,$nombreLab){
	$consulta="select count(*) from proveedor where nombre_lab= '".$nombreLab."'";
	return $conexion->query($consulta)->fetch()[0];
}
function existeContacto2($conexion,$oidContacto){
	$consulta="select count(*) from contacto where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoEmpresa2($conexion,$oidContacto){
	$consulta="select count(*) from empresa where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoFarmacia2($conexion,$oidContacto){
	$consulta="select count(*) from farmacia where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoProveedor2($conexion,$oidContacto){
	$consulta="select count(*) from proveedor where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoEmpleado2($conexion,$oidContacto){
	$consulta="select count(*) from empleado where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
function existeContactoUsuario2($conexion,$oidContacto){
	$consulta="select count(*) from usuario where oid_contacto= ".$oidContacto;
	return $conexion->query($consulta)->fetch()[0];
}
?>