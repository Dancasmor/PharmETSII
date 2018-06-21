<?php

	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarEmpleados.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	if(isset($_REQUEST["oidEmpresa"])){
		$oidEmpresa = $_REQUEST["oidEmpresa"];
	}else{
		$oidEmpresa=$oidEmpresa;
	}
	
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = existeEmpresa1($conexion,$oidEmpresa);
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>