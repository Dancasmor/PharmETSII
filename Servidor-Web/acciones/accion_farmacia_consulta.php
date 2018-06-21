<?php	
	session_start();	
	
	if (isset($_SESSION["OID_FARMACIA"]) or ($_SESSION["NOMBRE"])) {
		if (isset($_SESSION["OID_FARMACIA"])) {
			$farmacia = $_SESSION["OID_FARMACIA"];
			$opcion = "farmacia";
			unset($_SESSION["OID_FARMACIA"]);
		}
		else{
			$farmacia = $_SESSION["NOMBRE"];
			$opcion = "nombre";
			unset($_SESSION["NOMBRE"]);
		}
		
		require_once("gestionBD.php");
		require_once("gestionarFarmacias.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		// Consultamos
		if ($opcion == "farmacia") {
			$consulta = consultarFarmaciaPorId($conexion, $farmacia);
		}
		else{
			$consulta = consultarFarmaciaPorNombre($conexion, $farmacia);
		}
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_FARMACIAS.PHP"
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "consulta_farmacias.php";
			if(!isset($_SESSION["excepcion"])){
				$_SESSION["excepcion"] = "Ninguna coincidiencia";
			}
			Header("Location: excepcion.php");
		}else{
			
			foreach ($consulta as $fila) {
				$_SESSION["farmacia"] = $fila;	
			}
			Header("Location: consulta_farmacias.php");
		}
	} 
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_farmacias.php"); 
?>