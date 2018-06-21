<?php	
	session_start();	
	
	if (isset($_SESSION["OID_SECCION"])) {
		
		$seccion = $_SESSION["OID_SECCION"];
		unset($_SESSION["OID_SECCION"]);
		
		require_once("gestionBD.php");
		require_once("gestionarSeccion.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		// Consultamos
		$consulta = consultarSeccionPorOID($conexion, $seccion);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_CUENTA_BANCARIA.PHP"
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "consulta_seccion.php";
			if(!isset($_SESSION["excepcion"])){
				$_SESSION["excepcion"] = "Ninguna coincidiencia";
			}
			Header("Location: excepcion.php");
		}else{
			
			foreach ($consulta as $fila) {
				$_SESSION["seccion"] = $fila;	
			}
			Header("Location: consulta_seccion.php");
		}
	} 
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_seccion.php"); 
?>