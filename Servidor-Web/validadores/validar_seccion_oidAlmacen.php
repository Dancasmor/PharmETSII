<?php

	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarSeccion.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	if(isset($_REQUEST["oid"])){
		$oid = $_REQUEST["oid"];
	}
	
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = existeAlmacen($conexion, $oid);
	
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>