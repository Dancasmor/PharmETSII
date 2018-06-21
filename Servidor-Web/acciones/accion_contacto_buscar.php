<?php	
	session_start();	
	
	if (isset($_SESSION["OID_CONTACTO"])) {
		
		$contacto = $_SESSION["OID_CONTACTO"];
		unset($_SESSION["OID_CONTACTO"]);
		
		require_once("gestionBD.php");
		require_once("gestionarContacto.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		// Consultamos
		$consulta = consultarContactoPorOID($conexion, $contacto);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_CUENTA_BANCARIA.PHP"
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "consulta_contacto.php";
			if(!isset($_SESSION["excepcion"])){
				$_SESSION["excepcion"] = "Ninguna coincidiencia";
			}
			Header("Location: excepcion.php");
		}else{
			
			foreach ($consulta as $fila) {
				$_SESSION["contacto"] = $fila;	
			}
			Header("Location: consulta_contacto.php");
		}
	} 
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_contacto.php"); 
?>