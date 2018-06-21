<?php
	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarPedidoUsuario.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	//Rescatamos el parámetro del get para la consulta
	$dni = $_REQUEST["dni"];
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el almacen
	$valido = comprueba_dni($conexion, $dni);
	
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>