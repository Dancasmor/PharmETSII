<?php	
	session_start();	
	
	if (isset($_SESSION["OID_FARMACIA"])){
		$farmacia = $_SESSION["OID_FARMACIA"];
		unset($_SESSION["OID_FARMACIA"]);
		
		require_once("gestionBD.php");
		require_once("gestionarFarmacias.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		//Eliminamos
		$excepcion = eliminarFarmacia($conexion, $farmacia);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_FARMACIAS.PHP"
		if($excepcion <> ""){
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "consulta_farmacias.php";
			header("Location: excepcion.php");
		}else{
			header("Location: consulta_farmacias.php");
		}
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_farmacias.php"); 
?>
