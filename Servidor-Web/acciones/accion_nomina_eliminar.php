<?php	
	session_start();	
	
	if (isset($_SESSION["OID_NOMINA"])){
		$nomina = $_SESSION["OID_NOMINA"];
		unset($_SESSION["OID_NOMINA"]);
		
		require_once("gestionBD.php");
		require_once("gestionarNominas.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		//Eliminamos
		$excepcion = eliminarNomina($conexion, $nomina);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_NOMINAS.PHP"
		
		if($excepcion <> ""){
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "consulta_nominas.php";
			header("Location: excepcion.php");
		}else{
			header("Location: consulta_nominas.php");
		}
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_nominas.php"); 
?>
