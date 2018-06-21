e<?php	
	session_start();
	
	if (isset($_REQUEST["crear"])) {
		unset($_REQUEST["crear"]);
		$_SESSION["TELEFONO"] = $_REQUEST["TELEFONO"];
		$_SESSION["EMAIL"] = $_REQUEST["EMAIL"];
		$_SESSION["DIRECCION"] = $_REQUEST["DIRECCION"];
		$_SESSION["CODIGO_POSTAL"] = $_REQUEST["CODIGO_POSTAL"];
		$_SESSION["CIUDAD"] = $_REQUEST["CIUDAD"];
		Header("Location: accion_contacto_crear.php");
	}
	else if (isset($_REQUEST["consultar_contacto"])) {
		unset($_REQUEST["consultar_contacto"]);
		$_SESSION["OID_CONTACTO"] = $_REQUEST["OID_CONTACTO"];
		Header("Location: accion_contacto_buscar.php");
	}
	else if (isset($_REQUEST["borrar"])) {
		unset($_REQUEST["borrar"]);
		$_SESSION["OID_CONTACTO"] = $_REQUEST["OID_CONTACTO"];
		Header("Location: accion_contacto_eliminar.php");
	}
	else 
		Header("Location: consulta_contacto.php");
	
?>
