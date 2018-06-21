<?php	
	session_start();	
	
	if (isset($_SESSION["OID_NOMINA"])){
		$nomina = $_SESSION["OID_NOMINA"];
		$dni = $_SESSION["DNI_EMPLEADO"];
		echo $dni;
		echo $nomina;
		unset($_SESSION["OID_NOMINA"]);
		
		require_once("../Base/gestionBD.php");
		require_once("../gestores/gestionarNominas.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		//Creamos
		cobrarNomina($conexion, $nomina);
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_NOMINAS.PHP"
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "../index.php";
			header("Location: ../index.php?tituloPag=Excepcion");
		}else{
			header("Location: ../index.php?tituloPag=Nominas&dniEmpleado=$dni");
		}
	}
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: ../index.php"); 
?>
