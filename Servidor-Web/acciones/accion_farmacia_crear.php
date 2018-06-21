<?php	
	session_start();	
	
	if (isset($_SESSION["OID_CONTACTO"])){
		
		$farmacia["NOMBRE"] = $_SESSION["NOMBRE"];
		$farmacia["OID_CONTACTO"] = $_SESSION["OID_CONTACTO"];
		$farmacia["ID_CUENTA_BANCARIA"] = $_SESSION["ID_CUENTA_BANCARIA"];
		
		require_once("gestionBD.php");
		require_once("gestionarFarmacias.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		//Creamos
		crearFarmacia($conexion, $farmacia["NOMBRE"], $farmacia["OID_CONTACTO"], $farmacia["ID_CUENTA_BANCARIA"]);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_FARMACIAS.PHP"
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "consulta_farmacias.php";
			header("Location: excepcion.php");
		}else{
			header("Location: consulta_farmacias.php");
		}
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_farmacias.php"); 
?>