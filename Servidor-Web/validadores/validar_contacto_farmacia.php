<?php

	require_once("gestionBD.php");
	require_once("../farmacia/gestionarFarmacias.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	$oidContacto = $_REQUEST["oidContacto"];
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = !(existeContactoEmpresa($conexion, $oidContacto) or existeContactoFarmacia($conexion, $oidContacto) or 
				existeContactoProveedor($conexion, $oidContacto) or existeContactoEmpleado($conexion, $oidContacto) or
				existeContactoUsuario($conexion, $oidContacto));
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>