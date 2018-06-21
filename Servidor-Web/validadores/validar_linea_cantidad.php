<?php
	session_start();
	require_once("../Base/gestionBD.php");
	require_once("../gestores/gestionarLineas.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	
	//Rescatamos el parámetro del get para la consulta si se valida desde cliente, o el valor ya obtenido si se valida en servidor
	if(isset ($_GET["cantidad"])){
		$cantidad = $_GET["cantidad"];
	}else{
		$cantidad = $cant;
	}
	
	$oid_almacen = $_SESSION["id_producto"];
	$pedido = $_SESSION["id_pedido"];
	//Realizamos las funciones para validar
	$valido = cantidadValida($conexion, $oid_almacen, $cantidad, $pedido);
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>