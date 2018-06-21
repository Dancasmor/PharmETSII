<?php	
	session_start();
	
	if(isset($_REQUEST["consultar_farmacia_id"])) {
		unset($_REQUEST["consultar_farmacia_id"]);
		$_SESSION["OID_FARMACIA"] = $_REQUEST["OID_FARMACIA"];
		Header("Location: accion_farmacia_consulta.php");
	}
	else if(isset($_REQUEST["consultar_farmacia_nombre"])) {
		unset($_REQUEST["consultar_farmacia_nombre"]);
		$_SESSION["NOMBRE"] = $_REQUEST["NOMBRE"];
		Header("Location: accion_farmacia_consulta.php");
	}
	else if(isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		$_SESSION["OID_FARMACIA"] = $_REQUEST["OID_FARMACIA"];
		Header("Location: accion_farmacia_eliminar.php");
	}
	else if(isset($_REQUEST["crear"])) {
		unset($_REQUEST["crear"]);		
		$_SESSION["NOMBRE"] = $_REQUEST["NOMBRE"];	
		$_SESSION["OID_CONTACTO"] = $_REQUEST["OID_CONTACTO"];
		$_SESSION["ID_CUENTA_BANCARIA"] = $_REQUEST["ID_CUENTA_BANCARIA"];		
		Header("Location: accion_farmacia_crear.php");
	}
	else 
		Header("Location: consulta_farmacias.php");	
?>