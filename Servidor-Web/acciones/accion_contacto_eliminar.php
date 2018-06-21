<?php	
	session_start();	
	
	if (isset($_SESSION["OID_CONTACTO"])){
		$contacto = $_SESSION["OID_CONTACTO"];
		unset($_SESSION["OID_CONTACTO"]);
		
		require_once("gestionBD.php");
		require_once("gestionarContacto.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		//Eliminamos
		$excepcion = borrar_contacto($conexion, $contacto);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_ENVIOS.PHP"
		
		if($excepcion <> ""){
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "consulta_contacto.php";
			header("Location: excepcion.php");
		}else{
			header("Location: consulta_contacto.php");
		}
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_contacto.php"); 
?>
