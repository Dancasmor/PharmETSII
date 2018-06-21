<?php	
	session_start();	
	
	if (isset($_SESSION["DNI_EMPLEADO"])){
		
		$nomina["DNI_EMPLEADO"] = $_SESSION["DNI_EMPLEADO"];
		$nomina["SALARIO_BASE"] = $_SESSION["SALARIO_BASE"];
		$nomina["SALARIO_VARIABLE"] = $_SESSION["SALARIO_VARIABLE"];
		$nomina["FECHA"] = $_SESSION["FECHA"];
		$dni = $nomina["DNI_EMPLEADO"];
		
		require_once("../Base/gestionBD.php");
		require_once("../gestores/gestionarNominas.php");
		
		// CREAR LA CONEXIÓN A LA BASE DE DATOS
		$conexion = crearConexionBD();
		//Creamos	
		crearNomina($conexion,$nomina["DNI_EMPLEADO"],$nomina["SALARIO_BASE"],$nomina["SALARIO_VARIABLE"],$nomina["FECHA"]);
		
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
