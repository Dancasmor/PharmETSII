<?php	
	session_start();
	
	if (isset($_REQUEST["crear_nomina"])) {
		unset($_REQUEST["crear_nomina"]);
		$_SESSION["DNI_EMPLEADO"] = $_REQUEST["DNI_EMPLEADO"];
		$_SESSION["SALARIO_BASE"] = $_REQUEST["SALARIO_BASE"];
		$_SESSION["SALARIO_VARIABLE"] = $_REQUEST["SALARIO_VARIABLE"];
		$_SESSION["FECHA"] = $_REQUEST["FECHA"];
		Header("Location: ../acciones/accion_nomina_crear.php");
	}
	else if (isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		$_SESSION["OID_NOMINA"] = $_REQUEST["OID_NOMINA"];
		
		Header("Location: ../acciones/accion_nomina_eliminar.php");
	}
	else if (isset($_REQUEST["consulta_nomina_id"])) {
		unset($_REQUEST["consulta_nomina_id"]);
		$_SESSION["opcion"] = "oidNomina";
		$_SESSION["OID_NOMINA"] = $_REQUEST["OID_NOMINA"];
		
		Header("Location: ../acciones/accion_nomina_consulta.php");
	}
	else if (isset($_REQUEST["consulta_nomina_empleado"])) {
		unset($_REQUEST["consulta_nomina_empleado"]);
		$_SESSION["opcion"] = "dniEmpleado";
		$_SESSION["DNI_EMPLEADO"] = $_REQUEST["DNI_EMPLEADO"];
		
		Header("Location: ../acciones/accion_nomina_consulta.php");
	}
	else if (isset($_REQUEST["consulta_nomina_fecha"])) {
		unset($_REQUEST["consulta_nomina_fecha"]);
		$_SESSION["opcion"] = "fecha";
		$_SESSION["FECHA"] = $_REQUEST["FECHA"];
		
		Header("Location: ../acciones/accion_nomina_consulta.php");
	}
	else if (isset($_REQUEST["cobrar"])) {
		unset($_REQUEST["cobrar"]);
		$_SESSION["OID_NOMINA"] = $_REQUEST["OID_NOMINA"];
		Header("Location: ../acciones/accion_nomina_cobrar.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
