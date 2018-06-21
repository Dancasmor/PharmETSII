<?php	
	session_start();
	
	if (isset($_REQUEST["crear_envio_proveedor"])) {
		unset($_REQUEST["crear_envio_proveedor"]);
		$_SESSION["OID_PROVEEDOR"] = $_REQUEST["OID_PROVEEDOR"];
		$_SESSION["FECHA_ENVIO"] = $_REQUEST["FECHA_ENVIO"];
		$_SESSION["opcion"] = "proveedor";
		$_SESSION["OID_PEDIDO"] = $_REQUEST["OID_PEDIDO"];
		Header("Location: ../acciones/accion_envio_crear.php");
	}
	else if (isset($_REQUEST["crea_envio_almacen_general"])) {
		unset($_REQUEST["crea_envio_almacen_general"]);
		$_SESSION["OID_ALMACEN"] = $_REQUEST["OID_ALMACEN"];
		$_SESSION["FECHA_ENVIO"] = $_REQUEST["FECHA_ENVIO"];
		$_SESSION["opcion"] = "almacen_general";
		$_SESSION["OID_EMPRESA"] = $_REQUEST["OID_EMPRESA"];
		Header("Location: ../acciones/accion_envio_crear.php");
	}
	else 
		Header("Location: ../index.php");
	
?>
