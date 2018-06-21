<?php	
	session_start();	
	
	if (isset($_SESSION["opcion"])) {
		if (isset($_SESSION["OID_NOMINA"])) {
			$nomina = $_SESSION["OID_NOMINA"];
			unset($_SESSION["OID_NOMINA"]);
		}
		else if(isset($_SESSION["DNI_EMPLEADO"])) {
			$nomina = $_SESSION["DNI_EMPLEADO"];
			unset($_SESSION["DNI_EMPLEADO"]);
		}
		else{
			$nomina = $_SESSION["FECHA"];
			unset($_SESSION["FECHA"]);
		}
		
		$opcion = $_SESSION["opcion"];
		unset($_SESSION["opcion"]);
		
		require_once("gestionBD.php");
		require_once("gestionarNominas.php");
		require_once("../paginacion/paginacion_consulta.php");
		
		// Consultamos
		if ($opcion == "oidNomina") {
			$query = consultarNominasPorId($nomina);
		}
		else if($opcion == "dniEmpleado"){
			$query = consultarNominasPorEmpleado($nomina);
		}
		else{
			$query = consultarnNominasPorFecha($nomina);
		}
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		
		$consulta = consulta_con_parametros($conexion, $query, 0, 0);
		
		// CERRAR LA CONEXIÓN
		cerrarConexionBD($conexion);
		
		// SI LA FUNCIÓN RETORNÓ UN MENSAJE DE EXCEPCIÓN, ENTONCES REDIRIGIR A "EXCEPCION.PHP"
		// EN OTRO CASO, VOLVER A "CONSULTA_NOMINAS.PHP"
		
		if(isset($_SESSION["excepcion"])){
			$_SESSION["destino"] = "consulta_nominas.php";
			Header("Location: excepcion.php");
		}else{
			$vacio = false;
			foreach ($consulta as $fila) {
				$_SESSION["nominas"][] = $fila;	
				if(!$vacio){
					$vacio = true;
				}
			}
			$_SESSION["lleno"] = $vacio;
			Header("Location: consulta_nominas.php");
		}
	} 
	else // Se ha tratado de acceder directamente a este PHP 
		Header("Location: consulta_nominas.php"); 
?>
