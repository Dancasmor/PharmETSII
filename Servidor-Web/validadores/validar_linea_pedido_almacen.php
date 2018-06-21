<?php
	require_once("./Base/gestionBD.php");
	require_once("./gestores/gestionarLineas.php");

	//Abrimos la conexión para poder realizar las consultas necesarias
	$conexion = crearConexionBD();
	
	//Rescatamos el parámetro del get para la consulta si se valida desde cliente, o el valor ya obtenido si se valida en servidor
	if(isset ($_REQUEST["oid"])){
		$oid = $_REQUEST["oid"];
	}else{
		$oid = $almacen;
	}
	
	//Realizamos las funciones para validar
		//Primero validamos que exista el proveedor
	$existe = existePedido($conexion, $oid);
	if($existe == 1){
		$almacen = esAlmacen($conexion, $oid);
		if($almacen == 1){
			$valido = 1;
		}else{
			$valido = 0;
		}
	}else{
		$valido = 0;
	}
	//Cerramos conexion
	cerrarConexionBD($conexion);
	
	//devolvemos a traves de impresión el resultado de la validación
	echo $valido;
?>