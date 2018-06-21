<?php	
	session_start();	
	
	if (isset($_SESSION["OID_PRODUCTO"])) {
		
		$producto = $_SESSION["OID_PRODUCTO"];
		unset($_SESSION["OID_PRODUCTO"]);
		
		require_once("gestionBD.php");
		require_once("gestionarProducto.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		// Consultamos
		$consulta = consultarProductoPorOID($conexion, $producto);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_CUENTA_BANCARIA.PHP"
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "consulta_producto.php";
			if(!isset($_SESSION["excepcion"])){
				$_SESSION["excepcion"] = "Ninguna coincidiencia";
			}
			Header("Location: excepcion.php");
		}else{
			
			foreach ($consulta as $fila) {
				$_SESSION["producto"] = $fila;	
			}
			Header("Location: consulta_producto.php");
		}
	} 
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_producto.php"); 
?>