<?php

	require_once("gestionBD.php");
	require_once("../farmacia/gestionarFarmacias.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	$nombre = $_REQUEST["nombre"];
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = !existeFarmacia($conexion, $nombre);
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>