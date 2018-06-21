<?php

	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarEmpleados.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	if(isset($_REQUEST["oidFarmacia"])){
		$oidFarmacia = $_REQUEST["oidFarmacia"];
	}else{
		$oidFarmacia=$oidFarmacia;
	}
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = existeFarmacia1($conexion,$oidFarmacia);
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>