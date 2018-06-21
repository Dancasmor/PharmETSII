<?php

	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarProveedores.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	if(isset($_REQUEST["nombreLab"])){
		$nombreLab = $_REQUEST["nombreLab"];
	}else{
		$nombreLab=$nombreLab;
	}
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = !existeProveedor($conexion, $nombreLab);
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>