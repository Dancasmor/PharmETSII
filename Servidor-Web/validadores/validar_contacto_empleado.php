<?php

	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarEmpleados.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	if(isset($_REQUEST["oidContacto"])){
		$oidContacto = $_REQUEST["oidContacto"];
	}else{
		$oidContacto=$oidContacto;
	}
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = !(existeContactoEmpresa1($conexion, $oidContacto) or existeContactoFarmacia1($conexion, $oidContacto) or 
				existeContactoProveedor1($conexion, $oidContacto) or existeContactoEmpleado1($conexion, $oidContacto) or
				existeContactoUsuario1($conexion, $oidContacto));
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>